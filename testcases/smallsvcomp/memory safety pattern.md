# invalid dereference

* ```cpp
  b = malloc (n * sizeof(*b));
  *b++ = 0;
  b[-2] = 2;
  // should be free(b - 1)
  ```

* 

# memory leak

# invalid free

* ```cpp
  b = malloc (n * sizeof(*b));
  *b++ = 0;
  if (b[-1]) free(b);
  // should be free(b - 1)
  ```

* ```cpp
  int main() {
  
      struct T {
          struct T* next;
      };
  
      struct T* x = NULL;
      struct T* y = NULL;
  
      y = malloc(sizeof(*y));
      intptr_t adressY = (intptr_t) y;
  
      free(y);
  
      x = malloc(sizeof(*x));
      intptr_t adressX = (intptr_t) x;
  
      if (adressX == adressY)
      { // if the second malloc returns the same value as the first, I should get here
          free(x);
      }
  
      free(x);
  
      return 0;
  }
  // may cause double free, the memory would be reuse after free
  ```

* change data in union, which contains pointer and other type

  ```cpp
  int main()
  {
      union {
          void *p0;
  
          struct {
              char c[2];
              void *p1;
              void *p2;
          } str;
  
      } data;
  
      // alloc 37B on heap
      data.p0 = malloc(37U);
  
      // this should be fine
      data.str.p2 = &data;
  
      // avoid introducing a memleak
      void *ptr = data.p0;
  
      // invalid free()
      data.str.c[1] = sizeof data.str.p1;
      free(data.p0);
  
      free(ptr);
      return 0;
  }
  ```

  

* 

# valid memtrack

* ```cpp
  AnyType* p = malloc(size);
  p = NULL;
  ```

* use union

  ```cpp
  int main()
  {
      union {
          void *p0;
  
          struct {
              char c[2];
              void *p1;
              void *p2;
          } str;
  
      } data;
  
      // alloc 37B on heap
      data.p0 = malloc(37U);
  
      // this should be fine
      data.str.p2 = &data;
  
      // this introduces a memleak
      data.str.c[1] = sizeof data.str.p1;
  
      return 0;
  }
  ```

* free incomplete

  ```cpp
  struct item {
      struct item *next;
      struct item *data;
  };
  
  static void append(struct item **plist)
  {
      struct item *item = malloc(sizeof *item);
      item->next = *plist;
  
      // shared data
      item->data = (item->next)
          ? item->next->data
          : malloc(sizeof *item);
  
      *plist = item;
  }
  
  int main()
  {
      struct item *list = NULL;
  
      // create a long singly-linked list
      do
          append(&list);
      while (__VERIFIER_nondet_int());
  
      // remove the first item
      if (list) {
          struct item *next = list->next;
          free(list);
          list = next;
      }
  
      while (list) {
          struct item *next = list->next;
          free(list);
          list = next;
      }
      // domain data do not free!
  
      return 0;
  }
  
  ```

  

# others

* should no take invalid path into consider

  ```cpp
  b = malloc (n * sizeof(*b));
  *b++ = 0;
  if (b[-1]) free(b); //This path is invalid, so the program is correct
  else free(b - 1);
  ```

* may use double pointer, i.e. pointer to pointer

* may use atexit()

  * register a function that would be executed when the program ends

* there's error caused by lib function

  * etc. int group `global-atexit`, there's a error caused by the different bewteen function _Exit() and exit()

* may use undefined values

* shape based anaylsis `test-0232`

* 

