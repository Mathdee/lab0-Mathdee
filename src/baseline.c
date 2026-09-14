/* COSC 407/507 Lab 0 -- a working toolchain, and an honest measurement.
 *
 * This file is COMPLETE. You do not have to write any C in Lab 0. Read it,
 * build it, run it, and pay attention to the last number it prints.
 *
 *   make && ./baseline 10000000 5
 *
 * It sums the array 1, 2, ..., n on one thread, `repeats` times, and reports
 * how much the timing varied between runs of identical work.
 *
 * That spread is the point of Lab 0. Every later lab asks you to claim that
 * one version of a program is faster than another. A claim like that is
 * meaningless until you know how much your own machine wobbles when nothing
 * has changed at all.
 */
#include <stdio.h>
#include <stdlib.h>

#include "timer.h"

int main(int argc, char **argv)
{
    long long n       = (argc > 1) ? strtoll(argv[1], NULL, 10) : 10000000;
    int       repeats = (argc > 2) ? (int)strtol(argv[2], NULL, 10) : 5;

    if (n < 1 || repeats < 1 || repeats > 100) {
        fprintf(stderr, "usage: %s [n] [repeats 1..100]\n", argv[0]);
        return 1;
    }

    long long *a = malloc((size_t)n * sizeof *a);
    if (a == NULL) {
        fprintf(stderr, "not enough memory for %lld elements\n", n);
        return 1;
    }
    for (long long i = 0; i < n; i++) {
        a[i] = i + 1;
    }

    /* 1 + 2 + ... + n, worked out a different way, so this is a real check on
     * the loop below rather than the same code run twice. */
    long long expected = n * (n + 1) / 2;

    double best = 0.0, worst = 0.0, sum_time = 0.0;

    printf("n = %lld, %d repeats\n", n, repeats);

    for (int r = 0; r < repeats; r++) {
        double t0 = now_seconds();

        long long total = 0;
        for (long long i = 0; i < n; i++) {
            total += a[i];
        }

        double elapsed = now_seconds() - t0;

        /* Without this the compiler is entitled to notice that `total` is never
         * used and delete the whole loop, and you would be timing nothing. */
        if (total != expected) {
            printf("  run %d: WRONG (got %lld, expected %lld)\n", r, total, expected);
            free(a);
            return 1;
        }

        printf("  run %d: %.6f s\n", r, elapsed);

        if (r == 0 || elapsed < best)  best  = elapsed;
        if (r == 0 || elapsed > worst) worst = elapsed;
        sum_time += elapsed;
    }

    double mean   = sum_time / repeats;
    double spread = (best > 0.0) ? 100.0 * (worst - best) / best : 0.0;

    printf("best  %.6f s\n", best);
    printf("worst %.6f s\n", worst);
    printf("mean  %.6f s\n", mean);
    printf("spread %.1f%% of best\n", spread);

    free(a);
    return 0;
}
