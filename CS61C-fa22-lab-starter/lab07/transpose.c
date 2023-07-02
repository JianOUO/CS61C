#include "transpose.h"

/* The naive transpose function as a reference. */
void transpose_naive(int n, int blocksize, int *dst, int *src) {
    for (int x = 0; x < n; x++) {
        for (int y = 0; y < n; y++) {
            dst[y + x * n] = src[x + y * n];
        }
    }
}

/* Implement cache blocking below. You should NOT assume that n is a
 * multiple of the block size. */
void transpose_blocking(int n, int blocksize, int *dst, int *src) {
    // YOUR CODE HERE
    int a = n / 4;
    int b = n % 4;
    for (int i = 0; i <= a; i++) {
        if (i != a) {
            for (int j = 0; j <= a; j++) { 
                for (int x = 4 * i; x < 4 * i + 4; x++) {
                    if (j != a) {
                        for (int y = 4 * j; y < 4 * j + 4; y++) {
                            dst[y + x * n] = src[x + y * n];
                        }
                    } else {
                        for (int y = 4 * j; y < 4 * j + b; y++) {
                            dst[y + x * n] = src[x + y * n];
                        }
                    }

                }
            }
        } else {
            for (int j = 0; j <= a; j++) { 
                for (int x = 4 * i; x < 4 * i + b; x++) {
                    if (j != a) {
                        for (int y = 4 * j; y < 4 * j + 4; y++) {
                            dst[y + x * n] = src[x + y * n];
                        }
                    } else {
                        for (int y = 4 * j; y < 4 * j + b; y++) {
                            dst[y + x * n] = src[x + y * n];
                        }
                    }
                }
            }
        }
    }
}
