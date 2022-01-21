#include <stdio.h>

int main(void)
{
	unsigned a = 0, b = 1, c, temp;
	scanf("%u", &c);
	for (int i = 0; i < c; ++i)
	{
		temp = a, a = b, b = temp;
		b += a;
	}
	printf("%u", a);
	return 0;
}