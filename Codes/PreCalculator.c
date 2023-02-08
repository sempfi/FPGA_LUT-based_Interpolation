#include <stdio.h>
#include <math.h>
#include <stdlib.h>


unsigned char complement(const unsigned char x) 
{
	unsigned char z = ~x + 1;
	return z;
}

unsigned short calculator(const unsigned char x) 
{
	unsigned char x_bar = complement(x);
	unsigned short x_pow = (pow(x, 2));
    unsigned char y = (x_pow * x_bar) >> 16;
    return y;
}

void writeToROM(FILE *ROM, size_t const size, void const * const ptr)
{
    unsigned char *b = (unsigned char*) ptr;
    unsigned char byte;
    int i, j;
    
    for (i = size-1; i >= 0; i--) {
        for (j = 7; j >= 0; j--) {
            byte = (b[i] >> j) & 1;
            fprintf(ROM, "%u", byte);
        }
    }
    fputs("\n", ROM);
}

int main() 
{
	FILE *ROM;
    ROM = fopen("ROM.bin","wb");
    if (ROM == NULL) {
        printf("Error!");   
        exit(1);
    }
    unsigned char x = 0; 
    for (int i = 0; i < 256; i++) {
        unsigned char y = calculator(x);
        x++;
        writeToROM(ROM, sizeof(y), &y);
    }
    return 0;
}
