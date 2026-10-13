#!/bin/sh
set -eu

if [ -z "${VIRTUAL_ENV:-}" ] || [ ! -x "$VIRTUAL_ENV/bin/ruff" ]; then
    echo "Activate the development virtual environment and install the dev extra first." >&2
    exit 1
fi

HOOK=$(git rev-parse --git-path hooks/pre-commit)
if [ -e "$HOOK" ] || [ -L "$HOOK" ]; then
    echo "A pre-commit hook already exists at $HOOK; leaving it unchanged." >&2
    exit 1
fi

TEMP_HOOK=$(mktemp "${HOOK}.XXXXXX")
trap 'rm -f "$TEMP_HOOK"' EXIT
trap 'exit 1' HUP INT TERM

{
    printf '#!/bin/sh\nset -e\n'
    # Single-quote the path so substitutions and quotes remain literal data.
    printf "RUFF='%s'\n" "$(printf '%s' "$VIRTUAL_ENV/bin/ruff" | sed "s/'/'\\\\''/g")"
    cat <<'HOOK_BODY'
REPO_DIR=$(git rev-parse --show-toplevel)
cd "$REPO_DIR"
"$RUFF" check .
"$RUFF" format --check .
HOOK_BODY
} > "$TEMP_HOOK"
chmod +x "$TEMP_HOOK"

# A hard link publishes the complete hook atomically without replacing a hook
# installed by another process after the existence check above.
if ! ln "$TEMP_HOOK" "$HOOK"; then
    echo "Could not install $HOOK; leaving any existing hook unchanged." >&2
    exit 1
fi
