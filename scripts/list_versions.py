#! /usr/bin/python3
# get interested versions

import re
import subprocess


def _run(*args, regex: str = None) -> str:
    try:
        p = subprocess.run(args, capture_output=True, text=True)

        if regex is None:
            return p.stdout.strip()
        else:
            lines = p.stdout.splitlines()
            for line in lines:
                m = re.match(regex, line)
                if m:
                    return m.group(1).strip()
    except:
        pass
    return None


def _version_pandoc() -> str:
    return _run("pandoc", "--version", regex=r"^pandoc (.+)$")


def _version_plantuml() -> str:
    return _run("plantuml", "-version", regex=r"^PlantUML version (.+)$")


def _version_mermaid() -> str:
    return _run("mermaid", "--version")


def _version_node() -> str:
    return _run("node", "--version")


def _version_python() -> str:
    return _run("python", "--version", regex=r"^Python (.+)$")


def __version_pip(name: str) -> str:
    return _run(
        "python",
        "-m",
        "pip",
        "show",
        name,
        regex=r"^Version: (.+)$",
    )


def _version_xelatex() -> str:
    return _run("xelatex", "--version", regex=r"^XeTeX ([\d\.\-]+) .+$")


def _version_pdftex() -> str:
    return _run("pdftex", "--version", regex=r"^pdfTeX ([\d\.\-]+) .+$")


def _version_rsvg_convert() -> str:
    return _run("rsvg-convert", "--version", regex=r"^rsvg\-convert version (.+)$")


if __name__ == "__main__":

    # name: str => version : str
    known_deps = {}

    # program versions
    for name in [
        "pandoc",
        "plantuml",
        "mermaid",
        "node",
        "python",
        "xelatex",
        "pdftex",
        "rsvg-convert",
    ]:
        name = name.replace("-", "_")
        func_name = f"_version_{name}"
        func = globals()[func_name]
        version = func()

        known_deps[name] = version

    # pip package versions
    for name in [
        "pandoc-mermaid-filter",
        "pandoc-plantuml-filter",
        "pandocfilters",
        "pandoc-kroki-filter",
        "pandoc-latex-environment",
    ]:
        version = __version_pip(name)
        known_deps[name] = version

    # print to stdout as markdown list
    for name in sorted(known_deps.keys()):
        version = known_deps[name]
        if version is None:
            print("*", name, "N/A")
        else:
            print("*", name, "`" + known_deps[name] + "`")
