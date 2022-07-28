#
# Build stage
#

# download latest plantuml.jar
FROM alpine as download-plantuml
RUN wget https://github.com/plantuml/plantuml/releases/download/v1.2022.6/plantuml-1.2022.6.jar -O /tmp/plantuml.jar

# download pandoc
FROM alpine as download-pandoc
RUN wget https://github.com/jgm/pandoc/releases/download/2.18/pandoc-2.18-1-amd64.deb -O /tmp/pandoc.deb

# make mermaid
FROM node:17-bullseye-slim as build-env-node
RUN yarn add @mermaid-js/mermaid-cli

#
# Run stage
#
# FROM danteev/texlive as setup-env
FROM texlive/texlive as setup-env

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y -q --fix-missing \
  nodejs \
  git \
  python3 \
  python3-pip \
  graphviz \
  inkscape \
  gnuplot \
  # Noto font families with large Unicode coverage
  fonts-noto-cjk \
  fonts-noto-cjk-extra \
  fonts-noto-mono \
  # puppeteer dependencies
  libx11-xcb-dev \
  libxcomposite-dev \
  libxcursor-dev \
  libxdamage-dev \
  libxtst-dev \
  libxss-dev \
  libxrandr-dev \
  libasound-dev \
  libatk1.0-dev \
  libatk-bridge2.0-dev \
  libpango1.0-dev \
  libgtk-3-dev \
  libnss3 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
COPY --from=download-pandoc /tmp/pandoc.deb /tmp/pandoc.deb
RUN dpkg -i pandoc.deb && rm pandoc.deb

RUN python -m pip install pandoc-plantuml-filter git+https://github.com/timofurrer/pandoc-mermaid-filter.git

COPY --from=download-plantuml /tmp/plantuml.jar /home/plantuml.jar

COPY --from=build-env-node /node_modules /usr/local/lib/node_modules

RUN ln -sf /usr/local/lib/node_modules/.bin/mmdc /usr/bin/mermaid

RUN echo '#!/bin/bash\n\
    /usr/bin/java -jar /home/plantuml.jar $@' > /usr/bin/plantuml
RUN chmod a+x /usr/bin/plantuml

# puppeteer conf
RUN mkdir /opt/puppeteer
RUN echo "{\"args\": [\"--no-sandbox\", \"--disable-setuid-sandbox\"]}" > /opt/puppeteer/puppeteer.json
ENV PUPPETEER_CFG=/opt/puppeteer/puppeteer.json

# Could not create directory xxx, 但即使设置了也没用
# ENV PANDOCFILTER_CLEANUP="1"

RUN useradd pandoc

RUN mkdir /var/docs && chown pandoc /var/docs

RUN mkdir /home/pandoc && chown pandoc /home/pandoc

USER pandoc

WORKDIR /var/docs/

ENTRYPOINT ["pandoc", "--filter", "pandoc-plantuml", "--filter", "pandoc-mermaid"]
