#include <smack.h>

int main() {
  int i = 5;
  while (i > 0)
  {
      int j = 1;
      while (j < i)
      {
          // if (a[j] > a[i]);
          //    swap(a[j], a[i]);
          j++;
      }
      i--;
  }
  return 0;
}
