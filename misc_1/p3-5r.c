#include <stdio.h>

int f(unsigned char * b, unsigned char *c, unsigned char *d)
{
	for (int i = 0; i < 255; ++i)
		b[i] = i;
	while (*c != 0)
	{
		if (*d != 0)
		{
			b[*c] = *d;
			++d;
			++c;
		}
		else return 0;
	}
	return (*d == 0);
}

void p(unsigned char *d, unsigned char *c)
{
	while (*c)
	{
		*c = *(d + *c);
		++c;
	}
}

void s(unsigned char *d, int c)
{
	--c;
	fgets(d, c, stdin);
	d[c] = 0;
	//return 1;
}

int main(void)
{
	unsigned char ms[4880];
	int n;
	s(ms + 4624, 256);
	s(ms + 4368, 256);
	int tmp = f(ms + 4112, ms + 4624, ms + 4368);
	if (tmp == 0) return 0;
	scanf("%d", &n);
	getchar();
	for (int i = 0; i < n; ++i)
	{
		s(ms + 12, 4096);
		p(ms + 4112, ms + 12);
		printf("%s", ms + 12);
	}
	return 0;
}