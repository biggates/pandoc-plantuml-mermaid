# pandoc-plantuml-mermaid

[![GitHub Workflow badge](https://img.shields.io/github/workflow/status/biggates/pandoc-plantuml-mermaid/ci?label=GitHub%20building&logo=github)](https://github.com/biggates/pandoc-plantuml-mermaid) [![docker badge](https://img.shields.io/docker/pulls/biggates/pandoc-plantuml-mermaid?logo=docker)](https://hub.docker.com/r/biggates/pandoc-plantuml-mermaid)

一个带有 plantuml 和 mermaid 支持，并带有 LaTeX 环境的 docker 镜像。

## 如何使用

简单来说，这就是一个带上了 `--filter pandoc-plantuml --filter pandoc-mermaid` 参数的 pandoc 。

所以可以认为，如下指令

```bash
$ docker run --rm -v `pwd`:/var/docs biggates/pandoc-plantuml-mermaid
```

就可以代替原来的 `pandoc` 。

### 挂载目录

默认工作目录是容器内的 `/var/docs/` ，因此简单起见应该把 `.md` 文件夹挂载到这里。

在工作中会创建 `/var/docs/mermaid-images/` 目录和 `/var/docs/plantuml-images` 目录。

### 配置项

| 环境变量                  | 默认值              | 使用者              | 说明                    |
| ------------------------- | ------------------- | ------------------- | ----------------------- |
| `KROKI_SERVER`            | `https://kroki.io/` | pandoc-kroki-filter | Kroki 服务器的地址      |
| `KROKI_DIAGRAM_BLACKLIST` | `mermaid,plantuml`  | pandoc-kroki-filter | 不使用 kroki 绘图的类型 |

### 已知问题

* mermaid 图表无法生成，报 `Error in $: Failed reading: not a valid json value at 'Generatingsinglemermaidchart'` 错。

  > 使用相同的参数重新运行一次，一般情况下就可以解决了。
  > 如果仍然不行，要检查一下 mermaid 语法是否有错。

* 重复报 `Could not create directory "mermaid-images"`

  > 如果 pandoc 输出的文件没有问题，就可以忽略。

### 示例

假设当前目录中的文件为:

```
example.md
template.tex
```

使用如下方法将 example.md 转换为 pdf:

```bash
$ docker run --rm \
  -v `pwd`:/var/docs biggates/pandoc-plantuml-mermaid \
  --standalone \
  --number-sections \
  --output example.pdf \
  --toc \
  --include-in-header /var/docs/template.tex \
  --pdf-engine=xelatex \
  -VCJKmainfont="Noto Serif CJK SC" \
  example.md
```

## 参与开发

### 主要组件

本 image 中的主要组件为:

* 基于 `texlive/texlive`
* nodejs
  * mermaid-cli 位于 `/usr/local/lib/node_modules/.bin/mmdc` -> `/usr/bin/mermaid`
* python3
  * [pandoc-mermaid-filter](https://github.com/timofurrer/pandoc-mermaid-filter)
  * [pandoc-plantuml-filter](https://github.com/timofurrer/pandoc-plantuml-filter)
  * [pandoc-kroki-filter](https://gitlab.com/myriacore/pandoc-kroki-filter)
* plantuml 位于 `/home/plantuml.jar`
  * graphviz
  * inkspace
  * gnuplot
* fonts
  * fonts-noto-cjk
  * fonts-noto-cjk-extra
  * fonts-noto-mono

### 编译 docker 镜像

```bash
docker build -t biggates/pandoc-plantuml-mermaid:latest .
```

### 调用 bash

使用如下方法可以启动容器内部的 bash

```bash
docker run --rm -it --entrypoint /bin/bash biggates/pandoc-plantuml-mermaid:latest
```
