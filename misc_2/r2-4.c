#include <stdio.h>

static int sas;

int main(void)
{
	unsigned mask[5] = {0xffff, 0xff00ff, 0xf0f0f0f, 0x33333333, 0x55555555};
	unsigned a, *b, c, d;
	scanf("%u", &a);
	b = &mask[4];
	static int *sasi;
	static int I[10];
	c = 1;
	for (int i = 4; i >= 0; --i)
	{
		d = a;
		a &= *b;
		d &= (~(*b));
		a <<= c;
		d >>= c;
		a |= d;
		c <<= 1;
		--b;
	}
	printf("%u\n", a);
	printf("%d\n", (unsigned)-2 >> 1);
	printf("%d %d\n", sas, sasi);
	for (int i = 0; i < 10; ++i)
		printf("%d ", I[i]);
	return 0;
}