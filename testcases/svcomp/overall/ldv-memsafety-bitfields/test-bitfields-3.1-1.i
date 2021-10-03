/* Contributed by Anton Vasilyev. */

typedef long unsigned int size_t;

extern void *memcpy (void *__restrict __dest,
       __const void *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern void *malloc (size_t __size) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) ;

extern void free (void *__ptr) __attribute__ ((__nothrow__ , __leaf__));

struct A {
	unsigned char a;
	unsigned char b:2;
	unsigned char c:2;
	unsigned char d:4;
	unsigned char e:4;
	unsigned char pad;
	unsigned int f;
} __attribute__((packed));

struct B {
	unsigned char a;
	unsigned char b:2;
	unsigned char c:2;
	unsigned char d:4;
	unsigned char e;
	unsigned char f;
	unsigned char f1;
	unsigned char f2;
	unsigned char f3;
	unsigned char f4;
} __attribute__((packed));

struct B d = {.c = 3, 4, .b = 2};
int main(void)
{
	struct A *p;
	p = malloc(sizeof(struct A));
	memcpy(p, &d, sizeof(struct A));
	if (p->a != 0) {
		free(p);
	}
	if (p->b != 2) {
		free(p);
	}
	if (p->c != 3) {
		free(p);
	}
	if (p->d != 4) {
		free(p);
	}
	if (p->e != 0) {
		free(p);
	}
	if (p->f != 0) {
		free(p);
	}
	free(p);
}
