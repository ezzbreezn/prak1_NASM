//File with the test() function
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "funclist.c"

//Tests the root() and integral() functions on the function set from funclist.c

extern double root(double (*f)(double), double (*g)(double), double (*df)(double), double(*dg)(double),
								double a, double b, double eps);
extern double integral(double (*f)(double), double a, double b, double eps);

//Array of command line flags
extern int flags[4];

//Calculating errors
extern double eps1;
extern double eps2;

//Array of the pointers on the functions from funclist.c
//Functions are ordered by the "function - its derivative"
double (*functions[14])(double) = {f1, df1, f2, f2, f3, df3, f4, df4, f5, df5, f6, df6, f7, df7};

//Tests the root() and integral() functions
//Receives the arguments from the command line and launches the accorfing functions with the given parameters
void test(int argc, char **argv)
{
	if (argc == 2)
	{
		printf("Unavailable options or incorrect input were given\n");				
		printf("Use -help and -funclist to see the input format and the list of allowed options\n");
		return;		
	}
	//Testing the root() functiob
	if (strcmp(argv[2], "root") == 0)
	{
		//If too few arguments were given
		if (argc < 8)
		{
			printf("Too few arguments were given, the least number is 7\n");
			printf("The next input format were expected:\n");
			printf("./program -test root <func1№> <func2№> <lborder> <rborder> <optional flags>\n");
			printf("Use -help and -funclist to see the input format and the list of allowed options\n");
			return;
		}
		//If too many arguments were given
		if (argc > 11)
		{
			printf("Too much arguments were given, the maximal number is 10\n");
			printf("The next input format were expected:\n");
			printf("./program -test root <func1№> <func2№> <lborder> <rborder> <optional flags>\n");
			printf("Use -help and -funclist to see the input format and the list of allowed options\n");
			return;
		}
		//Check for the other options correctness
		for (int i = 3; i < argc; ++i)
		{
			//If the incorrect input were given
			if (strcmp(argv[i], "-iter") != 0 && strcmp(argv[i], "-isect") != 0 && strcmp(argv[i], "-debug") != 0 
				&& strcmp(argv[i], "0") != 0 && (atof(argv[i]) == 0 && atoi(argv[i]) == 0))
			{
				printf("Unavailable options or incorrect input were given\n");	
				printf("The next input format were expected:\n");
				printf("./program -test root <func1№> <func2№> <lborder> <rborder> <optional flags>\n");				
				printf("Use -help and -funclist to see the input format and the list of allowed options\n");
				return;
			}
		}
		//Numbers of the given functions
		int f1 = atoi(argv[3]);
		int f2 = atoi(argv[4]);
		//If the incorrect input were given
		if (f1 < 1 || f1 > 7 || f2 < 1 || f2 > 7 || f1 != atof(argv[3]) || f2 != atof(argv[4]))
		{
			printf("Unavailable options or incorrect input were given\n");	
			printf("The next input format were expected:\n");
			printf("./program -test root <func1№> <func2№> <lborder> <rborder> <optional flags>\n");				
			printf("Use -help and -funclist to see the input format and the list of allowed options\n");
			return;							
		}
		printf("Root calculation function\n");
		printf("Chosen functions:\n");
		switch(f1)
		{
			case 1:
				printf("f1 = -x^2 + 4\n");
				break;
			case 2:
				printf("f1 = e^x\n");
				break;
			case 3:
				printf("f1 = x + 1\n");
				break;
			case 4:
				printf("f1 = sqrt(x + 3)\n");
				break;
			case 5:
				printf("f1 = x^3\n");
				break;
			case 6:
				printf("f1 = sqrt(5 - x)\n");
				break;
			case 7:
				printf("f1 = x^2 / 2 + 3x\n");
				break;
			default:
			{
				printf("Unavailable options or incorrect input were given\n");	
				printf("The next input format were expected:\n");
				printf("./program -test root <func1№> <func2№> <lborder> <rborder> <optional flags>\n");				
				printf("Use -help and -funclist to see the input format and the list of allowed options\n");
				return;				
			}		
		}
		switch(f2)
		{
			case 1:
				printf("f2 = -x^2 + 4\n");
				break;
			case 2:
				printf("f2 = e^x\n");
				break;
			case 3:
				printf("f2 = x + 1\n");
				break;
			case 4:
				printf("f2 = sqrt(x + 3)\n");
				break;
			case 5:
				printf("f2 = x^3\n");
				break;
			case 6:
				printf("f2 = sqrt(5 - x)\n");
				break;
			case 7:
				printf("f2 = x^2 / 2 + 3x\n");
				break;	
			default:
			{
				printf("Unavailable options or incorrect input were given\n");	
				printf("The next input format were expected:\n");
				printf("./program -test root <func1№> <func2№> <lborder> <rborder> <optional flags>\n");				
				printf("Use -help and -funclist to see the input format and the list of allowed options\n");
				return;				
			}			
		}		
		//Given segment of the root location
		printf("Root location segment: [%lf, %lf]\n", atof(argv[5]), atof(argv[6]));
		printf("Calculation error: %lf\n", atof(argv[7]));
		double ans = root(functions[2 * (atoi(argv[3]) - 1)], functions[2 * (atoi(argv[4]) - 1)],
											functions[2 * (atoi(argv[3]) - 1) + 1], functions[2 * (atoi(argv[4]) - 1) + 1],
											atof(argv[5]), atof(argv[6]), atof(argv[7]));
		if (!flags[2] && !flags[3])
		{
			printf("Intersection point: %lf\n", ans);
		}
	}
	//Testing the integral() function
	else if (strcmp(argv[2], "integral") == 0)
	{
		//If too few arguments were given
		if (argc < 7)
		{
			printf("Too few arguments were given, the least number is 6\n");
			printf("The next input format were expected:\n");
			printf("./program -test integral <func№> <lborder> <rborder> <optional flags>\n");
			printf("Use -help and -funclist to see the input format and the list of allowed options\n");
			return;
		}
		//If too many arguments were given
		if (argc > 10)
		{
			printf("Too much arguments were given, the maximal number is 9\n");
			printf("The next input format were expected:\n");
			printf("./program -test integral <func№> <lborder> <rborder> <optional flags>\n");
			printf("Use -help and -funclist to see the input format and the list of allowed options\n");
			return;
		}
		//Check for the other options correctness
		for (int i = 3; i < argc; ++i)
		{
			//If the incorrect input were given
			if (strcmp(argv[i], "-debug") != 0 && strcmp(argv[i], "0") != 0 && (atoi(argv[i]) == 0 && atof(argv[i]) == 0))
			{
				printf("Unavailable options or incorrect input were given\n");	
				printf("The next input format were expected:\n");
				printf("./program -test integral <func№> <lborder> <rborder> <optional flags>\n");
				printf("Use -help and -funclist to see the input format and the list of allowed options\n");
				return;
			}
		}
		//Number of the given function		
		int f = atoi(argv[3]);
		//If the incorrect input were given
		if (f < 1 || f > 7 || f != atof(argv[3]))
		{
			printf("Unavailable options or incorrect input were given\n");	
			printf("The next input format were expected:\n");
			printf("./program -test integral <func№> <lborder> <rborder> <optional flags>\n");
			printf("Use -help and -funclist to see the input format and the list of allowed options\n");
			return;			
		}
		printf("Integral calculation function\n");
		printf("Chosen function:\n");
		switch(f)
		{
			case 1:
				printf("f = -x^2 + 4\n");
				break;
			case 2:
				printf("f = e^x\n");
				break;
			case 3:
				printf("f = x + 1\n");
				break;
			case 4:
				printf("f = sqrt(x + 3)\n");
				break;
			case 5:
				printf("f = x^3\n");
				break;
			case 6:
				printf("f = sqrt(5 - x)\n");
				break;
			case 7:
				printf("f = x^2 / 2 + 3x\n");
				break;
			default:
			{
				printf("Unavailable options or incorrect input were given\n");	
				printf("The next input format were expected:\n");
				printf("./program -test integral <func№> <lborder> <rborder> <optional flags>\n");
				printf("Use -help and -funclist to see the input format and the list of allowed options\n");
				return;					
			}	
		}
		//Given segment of integration
		printf("Integration segment: [%lf, %lf]\n", atof(argv[4]), atof(argv[5]));
		printf("Calculation error: %lf\n", atof(argv[6]));		
		double ans = integral(functions[2 * (atoi(argv[3]) - 1)], atof(argv[4]), atof(argv[5]), atof(argv[6]));
		if (!flags[3])
		{
			printf("Integral value: %lf\n", ans);
		}
	}
	//Unavailable flag were given
	else
	{
		printf("Unavailable flags were given\n");
		printf("Use -help to see the input format and the list of allowed options\n");
		return;
	}
}

