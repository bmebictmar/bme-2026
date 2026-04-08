# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Quarto website** for the course *Bases da Matemática e Estatística (BME)* — BICT Mar, Unifesp, 2026. It mixes Python and R code cells in `.qmd` documents. The site is published to GitHub Pages at `https://bmebictmar.github.io/bme-2026`.

## Commands

### Local preview
```bash
quarto preview
```

### Render site
```bash
quarto render
```

### Publish to GitHub Pages (manual)
```bash
quarto publish gh-pages
```
CI/CD (`.github/workflows/publish.yml`) auto-publishes on push to `main`.

### Python environment
```bash
# Install dependencies
pip install -r requirements.txt

# Register kernel for Quarto
python -m ipykernel install --user --name python3
```

### R environment (renv)
```r
renv::restore()
```

## Architecture

### Content types

| Path | Format | Runtime |
|------|--------|---------|
| `content/reading/` | `.qmd` → HTML | Python or R (inline code) |
| `content/computer-lab/` | `.qmd` → HTML | Python |
| `content/slides/` | `.html` (RevealJS) + `.pdf` | Pre-rendered; no execution |
| `content/exams/` | `.qmd` | Python or R |

### Execution freeze

`execute: freeze: auto` is set in `_quarto.yml`. This means Quarto caches computed outputs in `_freeze/`. Re-execution only happens if a `.qmd` source changes. Frozen results are committed to the repo so CI can publish without re-running every notebook.

To force re-execution of a single file:
```bash
quarto render content/reading/tendcentral.qmd --execute-daemon-restart
```

Or delete the file's freeze cache under `_freeze/` before rendering.

### Navigation

All sidebar navigation is defined in `_quarto.yml` under `website.sidebar.contents`. New pages must be added there to appear in the site.

### Dual-language content

- Python cells use packages from `requirements.txt`
- R cells rely on packages tracked in `renv.lock` (R 4.5.2)
- A single `.qmd` should use only one language (Python or R), not both

### Static slide assets

RevealJS slides under `content/slides/` are standalone HTML files (not rendered by Quarto at site-build time). They are referenced directly in `_quarto.yml` as links with `target: "_blank"`. The CSS and images they depend on are declared as `resources` in `_quarto.yml` so Quarto copies them to `_site`.
