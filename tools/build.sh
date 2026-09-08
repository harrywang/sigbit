#!/usr/bin/env bash
#
# SIGBIT site builder.
#
# The deployed site is the plain *.html files in the repository root — GitHub
# Pages serves them directly, with no build step at deploy time.
#
# This script exists so the shared <head>, top bar, left spine, and footer live
# in ONE place instead of being copy-pasted into every page. Run it after
# editing anything under tools/, then commit the regenerated HTML.
#
#   ./tools/build.sh
#
# Page content:  tools/pages/<name>.html   (the <main> block only)
# Chrome:        tools/partials/*.html
# Spine links:   the CHAIN string passed to render() below — "id:Label;id:Label"
#                Each id must match a section id in the page.
#
set -euo pipefail

cd "$(dirname "$0")/.."
P="tools/partials"

spine() {                       # $1 = "id:Label;id:Label;…"
  cat "$P/spine-top.html"
  echo '    <ol class="chain">'
  local i=0 pair id label
  IFS=';' read -ra pairs <<< "$1"
  for pair in "${pairs[@]}"; do
    id="${pair%%:*}"
    label="${pair#*:}"
    printf '      <li><a href="#%s"><span class="node"></span><span class="lbl">%03d &middot; %s</span></a></li>\n' "$id" "$i" "$label"
    i=$((i + 1))
  done
  echo '    </ol>'
  cat "$P/spine-bottom.html"
}

render() {                      # name  title  description  chain  [extra-head]
  local name="$1" title="$2" desc="$3" chain="$4" extra="${5:-}"
  {
    echo '<!DOCTYPE html>'
    echo '<html lang="en">'
    echo '<head>'
    cat "$P/head.html"
    echo "  <title>${title}</title>"
    if [ -n "$desc" ]; then
      echo "  <meta name=\"description\" content=\"${desc}\">"
      echo "  <meta property=\"og:title\" content=\"${title}\">"
      echo "  <meta property=\"og:description\" content=\"${desc}\">"
      echo '  <meta property="og:type" content="website">'
      echo '  <meta property="og:site_name" content="SIGBIT">'
      echo '  <meta name="twitter:card" content="summary">'
    fi
    [ -n "$extra" ] && echo "  $extra"
    echo '</head>'
    if [ -n "$chain" ]; then echo '<body class="has-spine">'; else echo '<body>'; fi
    echo
    cat "$P/header.html"
    echo
    [ -n "$chain" ] && spine "$chain"
    echo
    cat "tools/pages/${name}.html"
    echo
    cat "$P/footer.html"
    echo
    echo '</body>'
    echo '</html>'
  } > "${name}.html"
  echo "  ${name}.html"
}

echo "Building SIGBIT…"

render index \
  "SIGBIT — AIS Special Interest Group on Blockchain Innovations and Technologies" \
  "SIGBIT is the AIS Special Interest Group on Blockchain Innovations and Technologies: a platform for researchers and practitioners working on blockchain, Web3.0, DeFi, and NFTs to exchange ideas and share experiences and knowledge." \
  "genesis:Genesis;mandate:Mandate;scope:Scope;calendar:Calendar;membership:Members"

render about "About — SIGBIT" \
  "The mission, scope, and structure of the AIS Special Interest Group on Blockchain Innovations and Technologies." \
  "charter:Charter;mission:Mission;scope:Scope;ais:AIS;governance:Governance;questions:Questions"

render events "Events and calls — SIGBIT" \
  "Workshops, conference tracks, webinars, and calls for papers organized or sponsored by SIGBIT." \
  "ledger:Calendar;upcoming:Upcoming;calls:Calls;archive:Archive;propose:Propose"

render resources "Resources — SIGBIT" \
  "Publication venues, reading lists, teaching material, datasets, and tooling for blockchain research in information systems." \
  "index:Index;venues:Venues;collections:Collections;contribute:Contribute"

render leadership "Leadership — SIGBIT" \
  "The officer team and advisory board of the AIS Special Interest Group on Blockchain Innovations and Technologies." \
  "officers:Officers;roles:Roles;advisors:Advisors;volunteer:Volunteer"

render join "Join — SIGBIT" \
  "How to join SIGBIT, what membership gives you, and how to reach the officer team." \
  "join:Join;steps:Steps;benefits:Benefits;list:Sign up;contact:Contact"

render 404 "Page not found — SIGBIT" "" "" '<meta name="robots" content="noindex">'

echo "Done."
