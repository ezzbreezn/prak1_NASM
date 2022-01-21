//File with functions provided to test root() and integral() functions
#include <stdio.h>
#include <math.h>


//Prints the funclist.txt file with the short manual and the list of available functions
void funclist(void)
{
	FILE *fin = fopen("funclist.txt", "r");
	char s[100];
	while(fgets(s, 100, fin) != NULL)
	{
		printf("%s", s);
	}
	fclose(fin);
}

//Functions provided for testing.
//These functions are selected for clarity in such a way that the graphs of each of them intersect with each other
//on the segment [-2, 2], and the area under their graphs, i.e. the value of the corresponding definite integral, 
//is positive on the same segment.

double f1(double x)
{
	return -(x * x) + 4;
}

double df1(double x)
{
	return -2 * x;
}

double f2(double x)
{
	return exp(x);
}

double f3(double x)
{
	return x + 1;
}

double df3(double x)
{
	return 1.0;
}

double f4(double x)
{
	return sqrt(x + 3);
}

double df4(double x)
{
	return 1.0 / sqrt(x + 3);
}

double f5(double x)
{
	return x * x * x;
}

double df5(double x)
{
	return 3 * x * x;
}

double f6(double x)
{
	return sqrt(-x + 5);
}

double df6(double x)
{
	return -1 / 2 * sqrt(5 - x);
}

double f7(double x)
{
	return x * x / 2 + 3 * x;
}

double df7(double x)
{
	return x + 3;
}
