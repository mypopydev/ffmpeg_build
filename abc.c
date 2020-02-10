/*
gcc-9 abc.c -o abc-1
gcc-9 -O2 abc.c -o abc-2
gcc-9 -O3 -fno-tree-vectorize abc.c -o abc-3
gcc-9 -O3 abc.c -o abc-4
gcc-9 -O3 -msse3 abc.c -o abc-5
gcc-9 -O3 -march=native abc.c -o abc-6
gcc-9 -O3 -march=native -fopt-info-vec -fopt-info-vec-missed  abc.c -o abc-6
 */
#include <stdio.h>

#define ARRAY_SIZE 1024
#define NUMBER_OF_TRIALS 1000000

void main(int argc, char *argv[])
{
    /* Declare arrays small enough to stay in L1 cache.
       Assume the compiler aligns them correctly. */
    double a[ARRAY_SIZE], b[ARRAY_SIZE], c[ARRAY_SIZE];
    int i, t;
    double m = 1.5, d;
    /* Initialize a, b and c arrays */
    for (i=0; i < ARRAY_SIZE; i++) {
        a[i] = 0.0; b[i] = i*1.0e-9; c[i] = i*0.5e-9;
    }
    /* Perform operations with arrays many, many times */
    for (t=0; t < NUMBER_OF_TRIALS; t++) {
        for (i=0; i < ARRAY_SIZE; i++) {
            a[i] += m*b[i] + c[i];
        }
    }
    /* Print a result so the loops won't be optimized away */
    for (i=0; i < ARRAY_SIZE; i++) d += a[i];
    printf("%f\n",d/ARRAY_SIZE);
}

