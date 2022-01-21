//The main file with the main(), root() and integral() functions
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "library.h"


//Array of the command line flags
//flags[i] == 1 if the according flag specified, otherwise flags[i] == 0
//flags[0] -- -test flag
//flags[1] -- -iter flag
//flags[2] -- -isect flag
//flags[3] -- -debug flag

int flags[4] = {};

//funclist() function from the funclist.c file
extern void funclist(void);

//test() function from the test.c file
extern void test(int argc, char ** argv);

//Calculated errors for the calculations; eps1 - for the intersection points search, eps2 - for the integral calculation
double eps1 = 1e-5;
double eps2 = 1.5e-4;

//Intersection point search function, calculates the abscissa of the intersection point  of the given
//functions by the tangent (Newton's) method
//Receives the pointers on f and g functions and their derivatives df and dg, left border of the 
//localization segment a and its right border b, calculation error eps
//Returns the approximate value of intersection point abscissa
double root(double (*f)(double), double (*g)(double), double (*df)(double), double (*dg)(double),
							double a, double b, double eps){
	//Checking the first derivative sign: 
	//Since the input is segment, at the ends of which the function f - g takes values of opposite signs, 
	//and by the conditions for the tangent method function has continuous and monotonous first derivative, 
	//preserving the sign on this segment, to test the sign of the first derivative, 
	//it is sufficient to consider the sign of the function in the left point of the segment: 
	//if the function at the a point is negative, the derivative is positive, if it is positive, the derivative is negative
	int f1 = (f(a) - g(a) < 0);
	//Checking the second derivative sign:
	//Consider the values of the function at the midpoint (a + b) / 2 (i.e. the point on the graph of the function f - g),
	//and the mean between the function values at the edges of the segment (i.e. (f(a) - g(a) + f(b) - g(b)) / 2,
	//the point on the chord connecting the points of the graph of the f - g function at the endpoints of the interval with the 
	//abscissa (a + b) / 2). If the first value is greater than the second, then the graph of the function lies over the chord, 
	//and the second derivative is negative, otherwise the graph lies under the chord, and the second derivative is positive.
	int f2 = (f((a + b) / 2) - g((a + b) / 2) < (f(a) - g (a) + f(b) - g(b)) / 2);
	//Start point of the approximation
	double c;
	//Number of iterations
	long long iter = 0;
	//By the tangent method, if the first and second derivatives of the f - g functions
	//have different signs, search starts from the left border, i. e. a point
	if (f1 ^ f2) 
	{
		c = a;
		if(flags[3])
		{
			printf("Approximation from the left\n");
			printf("First approximation point: %lf\n", c);
		}
		//By the tangent method, count while the function values on the ends of the current segment have different signs and 
		//while the current approximation is located on [a, b] segment
		while ((f(c + eps) - g(c + eps)) * (f(c) - g(c)) > 0)
		{
			c = c - (f(c) - g(c)) / (df(c) - dg(c));
			++iter;
			if(flags[3]){
				printf("Iteration: %lld\n", iter);
				printf("Current approximation: %lf\n", c);
			}
		}
	}
	//Otherwise, if the derivatives have the same signs, search starts from the
	//right border, i. e. b point
	else
	{
		c = b;
		if(flags[3])
		{
			printf("Approximation from the right\n");
			printf("First approximation point: %lf\n", c);
		}
		while ((f(c - eps) - g(c - eps)) * (f(c) - g(c)) > 0)
		{
			c = c - (f(c) - g(c)) / (df(c) - dg(c));
			++iter;
			if(flags[3]){
				printf("Iteration: %lld\n", iter);
				printf("Current approximation: %lf\n", c);
			}
		}
	}
	if(flags[1] || flags[3])
		printf("Completed in %lld iterations\n", iter);
	if(flags[2] || flags[3])
		printf("Intersection point: %lf\n", c);
	return c;
}


//Definite integral calculation function, calculates the value of the function f integral on the [a, b] segment
//by the rectangles method
//Receives the pointer of the f function, borders of the integration segment (a and b) and calculating error eps
//Returns the approximate value of the according definite integral
double integral(double (*f)(double), double a, double b, double eps)
{
	//First approximation, divide the segment into 10 equal parts and calculate the first approximation of the integral
	//by the rectangles formula

	//Number of partitions
	long long n = 10;
	//Previous approximation in and the next approximation i2n
	double in = 0, i2n = 0;
	//Length of segment parts
	double step = (b - a) / n;
	//Calculate the first approximation
	for (int i = 0; i < n; ++i)
		in += f(a + (i + (double) 1 / 2) * step);
	in *= step;
	if(flags[3])
	{
		printf("Current number of partitions: %lld\n", n);
		printf("Current integral approximation: %lf\n", in);
	}
	//Then double the number of partitions at each step and compare the neighboring values of approximations by the Runge rule
	while (1)
	{
		n *= 2;
		step = (b - a) / n;
		i2n = 0;
		for (int i = 0; i < n; ++i)
			i2n += f(a + (i + (double) 1 / 2) * step);
		i2n *= step;
		if(flags[3])
		{
			printf("Current number of partitions: %lld\n", n);
			printf("Current integral approximation: %lf\n", i2n);
		}
		//Count while according difference is bigger than given calculation error
		if (fabs(i2n - in) < 3 * eps)
			break;
		in = i2n;

	}
	if(flags[3])
		printf("Integral value: %lf\n", i2n);
	return i2n;
}


//Prints the help.txt file in the terminal, i. e. shows the short manual for the program
//with the list of options
void help(void)
{
	FILE *fin = fopen("help.txt", "r");
	char str[100];
	while(fgets(str, 100, fin) != NULL)
	{
		printf("%s", str);
	}
	fclose(fin);
	return;
}


//Main function
int main(int argc, char **argv)
{
	//If the -help flag was specified
	if (argc == 2 && strcmp(argv[1], "-help") == 0)
	{
		help();
		return 0;
	}
	//If the -funclist flag was specified
	else if (argc == 2 && strcmp(argv[1], "-funclist") == 0)
	{
		funclist();
		return 0;
	}
	//If the -test flag was specified
	else if (argc >= 2 && strcmp(argv[1], "-test") == 0)
	{
		flags[0] = 1;
	}
	//If additional flags were specified; all of the sutuations will be noted in flags[] array
	for (int i = 1; i < argc; ++i)
	{
		if(strcmp(argv[i], "-iter") == 0)
			flags[1] = 1;
		else if(strcmp(argv[i], "-isect") == 0)
			flags[2] = 1;
		else if(strcmp(argv[i], "-debug") == 0)
			flags[3] = 1;
		//If the incorrect options were given
		else if(!flags[0])
		{
			printf("Unavailable flags were given\n");
			printf("Use -help and -funclist to see the input format and the list of allowed options\n");
			return 0;
		}
	}
	//If the -test flag was specified
	if (flags[0])
	{
		//Passing the entire contents of command line arguments to the function test()
		test(argc, argv);
		return 0;
	}
	printf("Area between the functions:\n");
	printf("F1 = e^x + 2\n");
	printf("F2 = -1 / x\n");
	printf("F3 = -2(x + 1) / 3\n");
	if(flags[3] || flags[1] || flags[2])
		printf("Intersection of F1 and F3\n");
	//Borders of the according segments were calculated analytically
	double x1 = root(F1, F3, DF1, DF3, -5.0, -4.0, eps1);
	if(flags[3] || flags[1] || flags[2])
		printf("\nIntersection of F2 and F3\n");
	//Borders of the according segments were calculated analytically
	double x2 = root(F2, F3, DF2, DF3, -2.0, -1.0, eps1);
	if(flags[3] || flags[1] || flags[2])
		printf("\nIntersection of F1 and F2\n");
	//Borders of the according segments were calculated analytically
	double x3 = root(F1, F2, DF1, DF2, -1.0, -0.25, eps1);
	if(flags[3])
		printf("\nF1 integral\n");
	double fs1 = integral(F1, x1, x2, eps2);
	if(flags[3])
		printf("\nF3 integral\n");
	double ss1 = integral(F3, x1, x2, eps2);
	//Calculate the needed integral like the difference between the areas under the functions
	double s1 = fs1 - ss1;
	if(flags[3])
		printf("\nFirst part of area: %lf\n", s1);
	if(flags[3])
		printf("\nF1 integral\n");
	double fs2 = integral(F1, x2, x3, eps2);
	if(flags[3])
		printf("\nF2 integral\n");
	double ss2 = integral(F2, x2, x3, eps2);
	double s2 = fs2 - ss2;
	if(flags[3])
		printf("\nSecond part of area: %lf\n", s2);
	//Final answer is the sum of areas of two figures
	double ans = s1 + s2;
	if(flags[3])
		printf("\n");
	//Print the final answer
	printf("Final area: %.3lf\n", ans);
	return 0;
}
