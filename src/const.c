#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>

void print_const(const char* name, unsigned value) {
    printf("#define %s %#x\n", name, value);
}

int main(void) {
    struct {
        const char* name;
        unsigned value;
    } constants[] = {
        {"O_CREAT", O_CREAT},
        {"O_APPEND", O_APPEND},
        {"O_WRONLY", O_WRONLY},
    };

    for (int i = 0; i < sizeof(constants) / sizeof(constants[0]); ++i) {
        print_const(constants[i].name, constants[i].value);
    }

    return 0;
}