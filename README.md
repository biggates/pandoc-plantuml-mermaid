# pandoc-plantuml-mermaid

[![GitHub Workflow badge](https://img.shields.io/github/workflow/status/biggates/pandoc-plantuml-mermaid/ci?label=GitHub%20building&logo=github)](https://github.com/biggates/pandoc-plantuml-mermaid) [![docker badge](https://img.shields.io/docker/pulls/biggates/pandoc-plantuml-mermaid?logo=docker)](https://hub.docker.com/r/biggates/pandoc-plantuml-mermaid)

一个带有 plantuml 和 mermaid 支持的镜像。

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

### 已知问题

* 首次运行时，mermaid 图表无法生成，报 `Error in $: Failed reading: not a valid json value at 'Generatingsinglemermaidchart'` 错。

  > 使用相同的参数重新运行一次就可以了。

* 重复报 `Could not create directory "mermaid-images"`

  > 如果 pandoc 输出的文件没有问题，就可以忽略。

## 参与开发

### 编译 docker 镜像

```bash
$ docker build -t biggates/pandoc-plantuml-mermaid:latest .
```

### 调用 bash

使用如下方法可以启动容器内部的 bash

```bash
$ docker run --rm -it --entrypoint /bin/bash biggates/pandoc-plantuml-mermaid:latest
```
