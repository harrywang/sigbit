# SIGBIT website

Static website for **SIGBIT** — the Special Interest Group on Blockchain Innovations and
Technologies, a Special Interest Group of the Association for Information Systems (AIS).

SIGBIT provides a platform for researchers and practitioners interested in blockchain-driven
innovations and technologies, such as Web3.0, DeFi, and NFT, to exchange ideas and share
experiences and knowledge.

## Pages

Every page is a Markdown file in the repository root:

| File | Page |
| --- | --- |
| `index.md` | Home |
| `about.md` | About: purpose, advisory committee, current officers |
| `workshops.md` | Past workshops |
| `bylaws.md` | SIGBIT bylaws (linked from About) |
| `404.md` | Not-found page |

GitHub Pages builds the site with Jekyll on every push to `main`; there is no local build step.
The shared `<head>`, menu and footer live in `_layouts/default.html`, and the menu entries
are the `menu` list in `_config.yml`.

## Editing the site

Edit the `.md` file and push. Each page starts with a small front-matter block:

```markdown
---
layout: default
title: Workshops
---

# Workshops
...
```

To add a page, create `<name>.md` with that header (it is served at `/<name>.html`), and add
it to `menu` in `_config.yml` if it belongs in the menu.

Preview locally (optional, needs Ruby):

```bash
gem install bundler jekyll
jekyll serve
# then open http://localhost:4000
```

## Deployment

Settings → Pages → Source: *Deploy from a branch* → `main`, `/ (root)`. Custom domain
`sigbit.org` (the `CNAME` file), with DNS at GoDaddy and HTTPS enforced.

## Design

Plain text on a white page: one 40rem column, the system font, blue links. The whole
stylesheet is about 30 lines in `assets/css/style.css`. No web fonts, no icons, and no
JavaScript.

## License

Content © SIGBIT / Association for Information Systems.
