# 附加脚本

此目录下列出的是测试和调试用的脚本。

## list_versions

便捷地列出镜像中的重要依赖项的版本号。

```bash title=linux host
docker run --rm --entrypoint /usr/bin/python3 -v `pwd`/scripts:/tmp/scripts biggates/pandoc-plantuml-mermaid:latest /tmp/scripts/list_versions.py
```

```bash title=windows host
docker run --rm --entrypoint /usr/bin/python3 -v %cd%/scripts:/tmp/scripts biggates/pandoc-plantuml-mermaid:latest /tmp/scripts/list_versions.py
```
