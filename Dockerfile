#
# Build stage
#

# download pandoc
FROM alpine as download-pandoc
RUN wget https://github.com/jgm/pandoc/releases/download/2.19.2/pandoc-2.19.2-1-amd64.deb -O /tmp/pandoc.deb

# clone eisvogel template
FROM alpine as download-eisvogel
WORKDIR /tmp
RUN wget https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v2.0.0/Eisvogel-2.0.0.tar.gz -O /tmp/eisvogel.tar.gz
RUN tar zxf eisvogel.tar.gz

#
# Run stage
#
FROM texlive/texlive as setup-env

# debian 软件源, 仅在调试时打开
# RUN sed -i -E 's/(deb|security).debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y -q --fix-missing \
  git \
  # python3 \
  python3-pip \
  librsvg2-bin \
  # Noto font families with large Unicode coverage
  fonts-noto-cjk \
  # fonts-noto-cjk-extra \
  fonts-noto-mono \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
COPY --from=download-pandoc /tmp/pandoc.deb /tmp/pandoc.deb
RUN dpkg -i pandoc.deb && rm pandoc.deb

# python packages
RUN python -m pip install \
  pandoc-latex-environment \
  git+https://gitlab.com/myriacore/pandoc-kroki-filter.git

RUN useradd pandoc

RUN mkdir /var/docs && chown pandoc /var/docs

RUN mkdir /home/pandoc && chown pandoc /home/pandoc

USER pandoc

# eisvogel template

RUN mkdir -p /home/pandoc/.local/share/pandoc/templates/

COPY --from=download-eisvogel /tmp/eisvogel.latex /home/pandoc/.local/share/pandoc/templates/eisvogel.latex

WORKDIR /var/docs/

ENTRYPOINT ["pandoc", "--filter", "pandoc-kroki", "--filter", "pandoc-latex-environment"]
