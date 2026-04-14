#!/usr/bin/env bash
set +e  # Don't exit on errors

PROJECTS_DIR="${PROJECTS_DIR:-$HOME/github/}"
MAX_REPOS="${MAX_REPOS:-10}"
RECENT_DAYS="${RECENT_DAYS:-0}"

IGNORE_PATTERNS=(
  "/node_modules/"
  "/.cache/"
  "/dist/"
  "/build/"
  "/out/"
  "/.venv/"
  "/venv/"
  "/.tox/"
  "/target/"
  "/.git/modules/"
)

[[ -d "$PROJECTS_DIR" ]] || {
  echo "!! PROJECTS_DIR missing: $PROJECTS_DIR" >&2
  exit 0
}

tempfiles() {
  local f
  for f in "$@"; do
    rm -f "$f"
  done
}

TMPDIR="${TMPDIR:-/tmp}"
REPO_TMP="$TMPDIR/git_scan_repos.$$"
TIMES_TMP="$TMPDIR/git_scan_times.$$"
SORTED_TMP="$TMPDIR/git_scan_sorted.$$"

trap "tempfiles $REPO_TMP $TIMES_TMP $SORTED_TMP" EXIT

find "$PROJECTS_DIR" -type d -name .git -prune -print 2>/dev/null | sed 's#/.git$##' > "$REPO_TMP"

filtered=""
while IFS= read -r r; do
  skip=0
  for pat in "${IGNORE_PATTERNS[@]}"; do
    [[ "$r" == *"$pat"* ]] && {
      skip=1
      break
    }
  done
  [ "$skip" = "0" ] && filtered="$filtered$r"$'\n'
done < "$REPO_TMP"

echo "$filtered" | awk '!seen[$0]++' > "$SORTED_TMP"

> "$TIMES_TMP"
while IFS= read -r r; do
  [ -z "$r" ] && continue
  ts="$(git -C "$r" log -1 --format=%ct 2>/dev/null || echo 0)"
  echo "$ts $r" >> "$TIMES_TMP"
done < "$SORTED_TMP"

sort -nr "$TIMES_TMP" | awk '{ $1=""; sub(/^ /,""); print }' > "$REPO_TMP"

now="$(date +%s)"
count=0
while IFS= read -r r; do
  [ -z "$r" ] && continue
  [ ! -d "$r/.git" ] && continue

  ts="$(git -C "$r" log -1 --format=%ct 2>/dev/null || echo 0)"
  if [ "$RECENT_DAYS" -gt 0 ] 2>/dev/null; then
    [ "$ts" = "0" ] && continue
    age="$((now - ts))"
    max_age="$((RECENT_DAYS * 24 * 3600))"
    [ "$age" -gt "$max_age" ] && continue
  fi

  name="$(basename "$r")"
  branch="$(git -C "$r" rev-parse --abbrev-ref HEAD 2>/dev/null || echo '-')"

  dirty="0"
  if git -C "$r" status --porcelain >/dev/null 2>&1; then
    if [ -n "$(git -C "$r" status --porcelain 2>/dev/null)" ]; then
      dirty="1"
    fi
  fi

  ahead="0"
  behind="0"
  if git -C "$r" rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
    ab="$(git -C "$r" rev-list --left-right --count @{u}...HEAD 2>/dev/null | awk '{print $1, $2}')"
    behind="$(echo "$ab" | awk '{print $1}')"
    ahead="$(echo "$ab" | awk '{print $2}')"
  fi

  [ -z "$ahead" ] && ahead="0"
  [ -z "$behind" ] && behind="0"

  rel="$(git -C "$r" log -1 --date=relative --format='%ad' 2>/dev/null || echo '-')"

  remote_url="$(git -C "$r" remote get-url origin 2>/dev/null || echo '-')"
  slug="-"
  case "$remote_url" in
    *github.com*:*/*)
      slug="$(echo "$remote_url" | sed -n 's|.*github.com[:/]*\([^/]*\)/\([^/]*\)\.git.*|\1/\2|p')"
      ;;
  esac

  printf "%s|%s|%s|%s|%s|%s|%s|%s|%s\n" \
    "$name" "$r" "$branch" "0" "$dirty" "0" "$ahead" "$behind" "$slug"

  count=$((count + 1))
  [ "$MAX_REPOS" -gt 0 ] && [ "$count" -ge "$MAX_REPOS" ] && break
done < "$REPO_TMP"

exit 0