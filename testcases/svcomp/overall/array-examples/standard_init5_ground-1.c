extern void abort(void); 
void reach_error(){}
void __VERIFIER_assert(int cond) { if(!(cond)) { ERROR: {reach_error();abort();} } }

#define N 100000

int main ( ) {
  int a[N];
  int i = 0;
  while ( i < N ) {
    a[i] = 42;
    i = i + 1;
  }
  i = 0;
  while ( i < N ) {
    a[i] = 43;
    i = i + 1;
  }
  i = 0;
  while ( i < N ) {
    a[i] = 44;
    i = i + 1;
  }
  i = 0;
  while ( i < N ) {
    a[i] = 45;
    i = i + 1;
  }
  i = 0;
  while ( i < N ) {
    a[i] = 46;
    i = i + 1;
  }

  int x;
  for ( x = 0 ; x < N ; x++ ) {
    __VERIFIER_assert(  a[x] == 46  );
  }
  return 0;
}