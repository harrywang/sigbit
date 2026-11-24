# SIGBIT website

Static website for **SIGBIT** — the Special Interest Group on Blockchain Innovations and
Technologies, a Special Interest Group of the Association for Information Systems (AIS).

SIGBIT provides a platform for researchers and practitioners interested in blockchain-driven
innovations and technologies, such as Web3.0, DeFi, and NFT, to exchange ideas and share
experiences and knowledge.

## Pages

| File | Page |
| --- | --- |
| `index.html` | Home — name, tagline, and social links |
| `about.html` | About — purpose, advisory committee, current officers |
| `workshops.html` | Past workshops |
| `bylaws.html` | SIGBIT bylaws (linked from About) |
| `404.html` | Not-found page (served automatically by GitHub Pages) |

The content is carried over from the previous sigbit.org site.

No frameworks, no dependencies, no build step at deploy time — just HTML and CSS.

## Deploying to GitHub Pages

**Option A — deploy from a branch (simplest).**
Settings → Pages → Source: *Deploy from a branch* → Branch: `main`, folder: `/ (root)`.
The site is live at `https://<org-or-user>.github.io/<repo>/` within a minute or two.
You can then delete `.github/workflows/pages.yml`.

**Option B — GitHub Actions.**
Settings → Pages → Source: *GitHub Actions*. The included
`.github/workflows/pages.yml` uploads the repository on every push to `main`.

A `.nojekyll` file is included so GitHub serves the files verbatim rather than
running them through Jekyll.

### Custom domain

Add a `CNAME` file in the repository root containing the domain (e.g. `sigbit.org`),
point a DNS `CNAME` record at `<org-or-user>.github.io`, then enable
*Enforce HTTPS* in Settings → Pages.

## Editing the site

The chrome is shared, so it lives in one place:

```
tools/partials/head.html     <head> contents (stylesheet, favicon)
tools/partials/footer.html   footer
tools/pages/<name>.html      the <main> block of each page
tools/build.sh               assembles the above into the root *.html files
```

The menu is the `MENU` list in `tools/build.sh`. To add a page, create
`tools/pages/<name>.html`, add a `render` line, and add it to `MENU` if it belongs there.

Workflow:

```bash
# edit tools/pages/workshops.html (or a partial), then:
./tools/build.sh
git add -A && git commit -m "Update workshops"
```

The generated `*.html` files in the repository root **are** the deployed site and are
committed to git, so a small one-off fix can also be made directly in them — just mirror
the change back into `tools/` so the next build does not overwrite it.

Preview locally with any static server:

```bash
python3 -m http.server 8000
# then open http://localhost:8000
```

## Design

Plain text on a white page: one 40rem column, the system font, blue links. The whole
stylesheet is about 30 lines in `assets/css/style.css`. No web fonts, no icons, and no
JavaScript beyond the footer year.

## License

Content © SIGBIT / Association for Information Systems.
