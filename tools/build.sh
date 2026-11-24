#!/usr/bin/env bash
#
# SIGBIT site builder.
#
# The deployed site is the plain *.html files in the repository root — GitHub
# Pages serves them directly, with no build step at deploy time.
#
# This script keeps the shared <head>, menu, and footer in one place. Run it
# after editing anything under tools/, then commit the regenerated HTML.
#
#   ./tools/build.sh
#
# Page content:  tools/pages/<name>.html   (the <main> block only)
# Chrome:        tools/partials/*.html
#
set -euo pipefail

cd "$(dirname "$0")/.."
P="tools/partials"

# Menu entries, "file:Label".
MENU="index:Home about:About workshops:Workshops"

render() {                      # name  title  [extra-head]
  local name="$1" title="$2" extra="${3:-}" item
  {
    echo '<!DOCTYPE html>'
    echo '<html lang="en">'
    echo '<head>'
    cat "$P/head.html"
    echo "  <title>${title}</title>"
    [ -n "$extra" ] && echo "  $extra"
    echo '</head>'
    echo '<body>'
    echo
    echo '<nav aria-label="Primary">'
    for item in $MENU; do
      echo "  <a href=\"${item%%:*}.html\">${item#*:}</a>"
    done
    echo '</nav>'
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

render index     "Home | SIGBIT"
render about     "About | SIGBIT"
render workshops "Workshops | SIGBIT"
render bylaws    "SIGBIT Bylaws | SIGBIT"
render 404       "Page not found | SIGBIT" '<meta name="robots" content="noindex">'

echo "Done."
