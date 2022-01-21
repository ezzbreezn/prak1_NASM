#include <stdio.h>
#include <stdlib.h>

struct tree
{
	int key;
	struct tree *left;
	struct tree *right;
};

void dfs(struct tree *t)
{
	if (t == NULL) return;
	printf("%d ", t -> key);
	dfs(t -> left);
	dfs(t -> right);
}

struct tree *build(FILE *f, int offset)
{

	struct tree *node = (struct tree *)malloc(12);
	int x;
	fseek(f, offset, 0);
	fread(&x, 4, 1, f);
	node -> key = x;
	fread(&x, 4, 1, f);
	if (x == -1)
		node -> left = NULL;
	else
	{
		fseek(f, 0, 0);
		node -> left = build(f, x);
		fseek(f, offset, 0);
		fread(&x, 4, 1, f);
		fread(&x, 4, 1, f);
	}
	fread(&x, 4, 1, f);
	if (x == -1)
		node -> right = NULL;
	else
	{
		fseek(f, 0, 0);
		node -> right = build(f, x);
	}
	return node;


}

int cmp(const void *a, const void *b)
{
	int a1 = *(int *)a, b1 = *(int *)b, a2 = *(int *)(a + 4), b2 = *(int *)(b + 4);
	if (a1 == b1 && a2 == b2) return 0;
	if (a1 < b1 || (a1 == b1 && a2 < b2)) return -1;
	if (a1 > b1 || (a1 == b1 && a2 > b2)) return 1;
}

int main(void)
{
	FILE *f = fopen("/home/boris/prak/asm/input2.bin", "rb");
	int i = 0, j = 0, shift = 0, x, y;
	int a[20000], b[20000];
	while (fread(&x, 4, 1, f))
	{
		//printf("%d\n", x);
		a[2 * i] = x;
		a[2 * i + 1] = shift;
		fread(&x, 4, 1, f);
		//printf("LO: %d\n", x);
		if (x != -1)
		{
			//printf("-------\n");
			fseek(f, x, 0);
			fread(&y, 4, 1, f);
			//printf("%d\n", y);
			b[2 * j] = y;
			b[2 * j + 1] = x;
			++j;
			fseek(f, shift, 0);
			fread(&x, 4, 1, f);
			//printf("%d\n", x);
			fread(&x, 4, 1, f);
		}
		fread(&x, 4, 1, f);
		//printf("RO :%d\n", x);
		if (x != -1)
		{
			//printf("-------\n");
			fseek(f, x, 0);
			fread(&y, 4, 1, f);
			//printf("%d\n", y);
			b[2 * j] = y;
			b[2 * j + 1] = x;
			++j;
			fseek(f, shift, 0);
			fread(&x, 4, 1, f);
			fread(&x, 4, 1, f);
			fread(&x, 4, 1, f);
		}
		++i;
		shift += 12;
	}
	//fclose(f);
	//printf("###############\n");

	/*for (int i1 = 0; i1 < i; ++i1)
		printf("%d %d\n", a[2 * i1], a[2 * i1 + 1]);
	printf("\n");
	for (int i1 = 0; i1 < j; ++i1)
		printf("%d %d\n", b[2 * i1], b[2 * i1 + 1]);*/
	qsort(a, i, 8, cmp);
	qsort(b, j, 8, cmp);
	/*printf("\n");
	for (int i1 = 0; i1 < i; ++i1)
		printf("%d %d\n", a[2 * i1], a[2 * i1 + 1]);
	printf("\n");
	for (int i1 = 0; i1 < j; ++i1)
		printf("%d %d\n", b[2 * i1], b[2 * i1 + 1]);*/
	int t;
	for (t = 0; t < i && t < j; ++t)
	{
		if (a[2 * t] != b[2 * t] || a[2 * t + 1] != b[2 * t + 1])
		{
			//printf("root: %d\n", a[2 * t]);
			break;
		}
	}
	fseek(f, 0, 0);
	struct tree *root = build(f, a[2 * t + 1]);
	fclose(f);
	dfs(root);
	/*if (t > j)
	{
		printf("root: %d\n", a[2 * t]);
	}*/

	return 0;
}