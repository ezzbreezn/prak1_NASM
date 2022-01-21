#include <stdio.h>

unsigned int f(unsigned int a)
{
	if (a == 0) return 1;
	return 3 * f (a - 1);
}

int main(void)
{
	unsigned int a;
	scanf("%u", &a);
	printf("%u\n", f(a));
	return 0;
}