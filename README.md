# SIGBIT website

Static website for **SIGBIT** — the Special Interest Group on Blockchain Innovations and
Technologies, a Special Interest Group of the Association for Information Systems (AIS).

SIGBIT provides a platform for researchers and practitioners interested in blockchain-driven
innovations and technologies, such as Web3.0, DeFi, and NFT, to exchange ideas and share
experiences and knowledge.

## Pages

| File | Page |
| --- | --- |
| `index.html` | Home — mission, what the SIG does, research agenda, upcoming events |
| `about.html` | About — mission, scope, relationship to AIS, FAQ |
| `events.html` | Events, calls for papers, and the archive |
| `resources.html` | Publication venues, reading lists, teaching material, datasets |
| `leadership.html` | Officers, officer roles, advisory board |
| `join.html` | How to join, member benefits, mailing list, contact |
| `404.html` | Not-found page (served automatically by GitHub Pages) |

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
tools/partials/head.html          <head> contents (fonts, stylesheet, favicon)
tools/partials/header.html        top bar + primary navigation
tools/partials/spine-top.html     left spine: mark, opening markup
tools/partials/spine-bottom.html  left spine: closing links
tools/partials/footer.html        footer columns + scripts
tools/pages/<name>.html           the <main> block of each page
tools/build.sh                    assembles the above into the root *.html files
```

The left spine's block list is generated from the chain string passed to
`render()` in `tools/build.sh` — `"section-id:Label;section-id:Label"`. Each id
must match a `<section id="…">` in that page, or the scroll indicator will skip it.

Workflow:

```bash
# edit tools/pages/events.html (or a partial), then:
./tools/build.sh
git add -A && git commit -m "Update events"
```

The generated `*.html` files in the repository root **are** the deployed site and are
committed to git, so a small one-off fix can also be made directly in them — just mirror
the change back into `tools/` so the next build does not overwrite it.

Preview locally with any static server:

```bash
python3 -m http.server 8000
# then open http://localhost:8000
```

## Placeholders to fill in

The structure and copy are complete; a few facts were left as clearly marked placeholders
rather than invented. Search the repo for `TODO` and `MAINTAINERS`:

- **`leadership.html`** — officer names, affiliations, terms, and advisory board members.
- **`events.html`** — real event dates, venues, submission links; move expired calls to the archive.
- **`join.html`** — the SIG contact email address and a mailing-list endpoint for the signup
  form (Google Form, Formspree, Mailchimp, or the AIS list manager). The form currently posts
  nowhere and says so.
- **`resources.html`** — links for the reading list, syllabi, datasets, and tooling collections.
- **`about.html`** — founding date, charter, and bylaws if the SIG wants them published.

Edit these under `tools/pages/`, not in the generated root HTML, then re-run the build.

## Design

**Direction: "the ledger."** The site is laid out as an append-only record of the SIG's
activity — sections are numbered blocks, content is presented as ledger records rather than
cards, and a fixed left spine shows the chain of blocks on the current page and lights up
the one you are reading.

- **Type.** Archivo (variable width, set expanded and heavy) for display, Literata for
  reading, IBM Plex Mono for every label, index, and piece of data.
- **Colour.** Ink `#15171c` on paper `#fbfbf9`, one violet accent `#4b2fd9`, and six
  identicon swatch hues used only as 9px squares to code research topics.
- One stylesheet (`assets/css/style.css`) with all tokens as custom properties at the top —
  change the palette there and it propagates everywhere.
- `assets/js/main.js` only runs the mobile menu, the current-page nav mark, and the spine
  scroll indicator; every page works with JavaScript disabled.
- Responsive to 320px, keyboard accessible, skip link, visible focus rings, and
  `prefers-reduced-motion` respected.

## License

Content © SIGBIT / Association for Information Systems.
