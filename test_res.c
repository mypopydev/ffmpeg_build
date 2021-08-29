#include <time.h>
#include <stdio.h>

int main(int argc, char** argv)
{
    clockid_t types[] = {
        CLOCK_REALTIME,
        CLOCK_REALTIME_COARSE,
        CLOCK_MONOTONIC,
        CLOCK_MONOTONIC_COARSE,
        CLOCK_MONOTONIC_RAW,
        CLOCK_BOOTTIME,
        CLOCK_PROCESS_CPUTIME_ID,
        CLOCK_THREAD_CPUTIME_ID,
        (clockid_t) - 1
    };

    struct timespec spec;
    int i;
    for (i = 0; types[i] != (clockid_t) - 1; i++) {
        if (clock_getres( types[i], &spec ) != 0) {
            printf( "Timer %d not supported.\n", types[i] );
        } else {
            printf( "Timer: %d, Seconds: %ld Nanos: %ld\n", i, spec.tv_sec, spec.tv_nsec );
        }
    }
}
