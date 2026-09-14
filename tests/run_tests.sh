#!/usr/bin/env bash
# COSC 407/507 Lab 0 -- does your toolchain work, and did you record a baseline?
#
#   bash tests/run_tests.sh
#
# Lab 0 is marked for completion, not correctness. These checks exist so that
# you find out today whether anything is missing, rather than in Lab 1.

set -u
FAILED=0

pass() { printf '  PASS  %s\n' "$1"; }
fail() { printf '  FAIL  %s\n' "$1"; FAILED=1; }
info() { printf '  ....  %s\n' "$1"; }

bin() {
    if   [ -x ./baseline ];     then echo ./baseline
    elif [ -x ./baseline.exe ]; then echo ./baseline.exe
    else                             echo ""
    fi
}

echo "Toolchain"

if command -v gcc >/dev/null 2>&1; then
    pass "gcc is on PATH ($(gcc -dumpversion))"
else
    fail "gcc is not on PATH -- you are not inside the lab container"
fi

if command -v make >/dev/null 2>&1; then
    pass "make is on PATH"
else
    fail "make is not on PATH"
fi

# threads are the whole course; check they actually link
cat > /tmp/cosc407_probe.c <<'EOF'
#include <pthread.h>
static void *f(void *p) { (void)p; return 0; }
int main(void) { pthread_t t; pthread_create(&t, 0, f, 0); pthread_join(t, 0); return 0; }
EOF
if gcc -std=gnu11 -pthread -o /tmp/cosc407_probe /tmp/cosc407_probe.c 2>/dev/null; then
    pass "a pthreads program compiles and links"
else
    fail "pthreads did not link -- check you are in the container, not on the host"
fi
rm -f /tmp/cosc407_probe /tmp/cosc407_probe.c /tmp/cosc407_probe.exe

info "cores visible to this machine: $(nproc 2>/dev/null || echo unknown)"

echo
echo "Baseline"

B="$(bin)"
if [ -z "$B" ]; then
    fail "./baseline was not built -- run 'make'"
else
    pass "./baseline built"
    out="$("$B" 1000000 3 2>&1)"
    if printf '%s\n' "$out" | grep -q 'spread'; then
        pass "./baseline 1000000 3 runs and reports a spread"
        info "$(printf '%s\n' "$out" | grep spread)"
    else
        fail "./baseline did not report a spread; output was: $out"
    fi
    if printf '%s\n' "$out" | grep -q 'WRONG'; then
        fail "./baseline reported a wrong sum -- tell your TA, this should not happen"
    fi
fi

echo
echo "RESULTS.md"

f=RESULTS.md
if [ ! -f "$f" ]; then
    fail "RESULTS.md is missing"
else
    if grep -q 'REPLACE THIS LINE' "$f"; then
        fail "RESULTS.md still contains a 'REPLACE THIS LINE' placeholder"
    else
        pass "no placeholders left in RESULTS.md"
    fi

    disc="$(sed -n 's/^[Tt]ools and sources:[[:space:]]*//p' "$f" | head -1)"
    if [ -n "$disc" ] && ! printf '%s' "$disc" | grep -q 'REPLACE'; then
        pass "the tools-and-sources disclosure is filled in"
    else
        fail "state your tools and sources -- for Lab 0, AI help with setup is allowed, just say so"
    fi

    # match the program's own output format, so the questions mentioning the
    # word "spread" do not satisfy this by themselves
    if [ "$(grep -cE 'spread [0-9.]+% of best' "$f")" -ge 2 ]; then
        pass "both baseline runs pasted into RESULTS.md"
    else
        fail "paste the output of BOTH ./baseline runs into RESULTS.md"
    fi
fi

echo
if [ "$FAILED" -eq 0 ]; then
    echo "Lab 0 complete. You are ready for Lab 1."
else
    echo "Something above needs fixing BEFORE your Lab 1 session. Ask on the course forum in Canvas."
fi
exit "$FAILED"
