#!/usr/bin/env bash
# Build every EnICS template in a clean scratch copy and report the results.
#
# Usage:  bash Utilities/build_all.sh [-k] [-n] [TEMPLATE ...]
#   -k         keep the build directories (printed at the end)
#   -n         additionally build every template with \guidefalse (guidance hidden)
#   TEMPLATE   one or more names from the Templates folder (default: all of them)
#
# Each template is copied to its own directory as main.tex, exactly the way a
# student's project looks, and compiled with latexmk (pdfLaTeX). Theses and
# proposals are also compiled with LuaLaTeX, which is what produces the Hebrew
# front matter. Set BUILD_DIR to choose where the builds go (default: mktemp).
#
# Requirements: latexmk, pdflatex, lualatex, bibtex, texcount, python3 + pygments (minted).

set -u
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
KEEP=0
NOGUIDE=0
while getopts "kn" opt; do
    case $opt in
        k) KEEP=1 ;;
        n) NOGUIDE=1 ;;
        *) echo "usage: $0 [-k] [-n] [TEMPLATE ...]"; exit 2 ;;
    esac
done
shift $((OPTIND - 1))

ALL=(IEEE_Journal IEEE_Conference ACM_Journal ACM_Conference MSc_Thesis PhD_Thesis Research_Proposal ISF_Template)
LUA=(MSc_Thesis PhD_Thesis Research_Proposal)
TEMPLATES=("${@:-${ALL[@]}}")
[ $# -eq 0 ] && TEMPLATES=("${ALL[@]}")

BUILD="${BUILD_DIR:-$(mktemp -d)}"
mkdir -p "$BUILD"
SUMMARY="$BUILD/summary.txt"
: > "$SUMMARY"

needs_lua() { for t in "${LUA[@]}"; do [ "$t" = "$1" ] && return 0; done; return 1; }

build_one() {
    local T=$1 ENGINE=$2 GUIDE=$3
    local name="$T-$ENGINE"; [ "$GUIDE" = "noguide" ] && name="$name-noguide"
    local D="$BUILD/$name"
    mkdir -p "$D"
    cp -r "$ROOT"/{AuxiliaryPages,Bios,Figures,Templates,bibliography,newcommands,packages} "$D"/
    cp "$ROOT/Reply_To_Reviewers.tex" "$D"/
    cp "$ROOT/Templates/$T.tex" "$D/main.tex"
    if [ "$GUIDE" = "noguide" ]; then
        sed -i 's/\\guidetrue/\\guidefalse/' "$D/main.tex"
    fi
    local flag="-pdf"; [ "$ENGINE" = "lualatex" ] && flag="-lualatex"
    ( cd "$D" && timeout 900 latexmk $flag -shell-escape -interaction=nonstopmode main.tex > build.out 2>&1 )
    local rc=$?
    local errors undef status
    if [ -f "$D/main.log" ]; then
        errors=$(grep -c '^!' "$D/main.log"); errors=${errors:-0}
        undef=$(grep -c 'Reference .* undefined\|Citation .* undefined' "$D/main.log"); undef=${undef:-0}
    else
        errors="?"; undef="?"
    fi
    if [ $rc -eq 0 ] && [ -s "$D/main.pdf" ] && [ "$errors" = "0" ]; then status=OK; else status=FAIL; fi
    printf '%-32s %-5s rc=%-3s errors=%-3s undefined-refs=%-3s\n' "$name" "$status" "$rc" "$errors" "$undef" >> "$SUMMARY"
}

echo "Building in $BUILD ..."
for T in "${TEMPLATES[@]}"; do
    build_one "$T" pdflatex guide &
    needs_lua "$T" && build_one "$T" lualatex guide &
    if [ $NOGUIDE -eq 1 ]; then
        build_one "$T" pdflatex noguide &
        needs_lua "$T" && build_one "$T" lualatex noguide &
    fi
done
wait

echo
sort "$SUMMARY"
echo
if grep -q FAIL "$SUMMARY"; then
    echo "Some builds FAILED. Look at main.log in the build directories under: $BUILD"
    exit 1
fi
echo "All builds passed."
if [ $KEEP -eq 1 ] || [ -n "${BUILD_DIR:-}" ]; then
    echo "Build output kept in: $BUILD"
else
    rm -rf "$BUILD"
fi
