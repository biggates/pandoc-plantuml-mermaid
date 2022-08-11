# Change Log

## 20220810

* pandoc `2.19-1`
* plantuml `1.2022.6`
* mermaid-cli `9.1.4`
* nodejs `v18.6.0`
* python `3.10.5`
* pandoc-kroki-filter `0.1.0`
* pandoc-mermaid-filter `0.1.0`
* pandoc-plantuml-filter `0.1.2`
* pandocfilters `1.5.0`
* rsvg-convert `2.54.4`
* XeLaTeX `3.141592653-2.6-0.999994 (TeX Live 2022)`
* pdfTex `3.141592653-2.6-1.40.24 (TeX Live 2022)`

## 20220728

* pandoc `2.18-1`
* plantuml `1.2022.6`
* mermaid-cli `9.1.4`
* nodejs `v16.15.1`
* python `3.10.5`
* pandoc-mermaid-filter `0.1.0`
* pandoc-plantuml-filter `0.1.2`
* pandocfilters `1.5.0`
* XeLaTeX `3.141592653-2.6-0.999994 (TeX Live 2022)`
* pdfTex `3.141592653-2.6-1.40.24 (TeX Live 2022)`

## 如何生成

```bash
$ docker run --rm -it --entrypoint /bin/bash biggates/pandoc-plantuml-mermaid:latest

$ pandoc --version
$ plantuml -version
$ mermaid --version
$ node -v
$ python --version
$ python -m pip list -v
$ xelatex --version
$ rsvg-convert --version
```
