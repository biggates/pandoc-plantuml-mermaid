# Change Log

## 20220824

移除了 plantuml 和 mermaid ，全部靠 kroki 完成绘图。

* mermaid N/A ➖
* node N/A ➖
* pandoc `2.19.2` ⬆
* pandoc-kroki-filter `0.1.0`
* pandoc-latex-environment `1.1.6` ➕
* pandoc-mermaid-filter N/A ➖
* pandoc-plantuml-filter N/A ➖
* pandocfilters `1.5.0`
* pdfTex `3.141592653-2.6-1.40.24 (TeX Live 2022)`
* plantuml N/A ➖
* python `3.10.6`
* rsvg-convert `2.54.4`
* XeLaTeX `3.141592653-2.6-0.999994 (TeX Live 2022)`

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

in Linux host:

```bash title=linux host
docker run --rm --entrypoint /usr/bin/python3 -v `pwd`/scripts:/tmp/scripts biggates/pandoc-plantuml-mermaid:latest /tmp/scripts/list_versions.py
```

in Windows host:

```bash title=windows host
docker run --rm --entrypoint /usr/bin/python3 -v %cd%/scripts:/tmp/scripts biggates/pandoc-plantuml-mermaid:latest /tmp/scripts/list_versions.py
```
