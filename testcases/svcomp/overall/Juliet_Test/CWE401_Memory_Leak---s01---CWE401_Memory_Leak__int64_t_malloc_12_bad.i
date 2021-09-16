/* Generated by Frama-C */

typedef unsigned long size_t;

typedef int wchar_t;

typedef long __int64_t;

typedef __int64_t int64_t;

typedef unsigned int wint_t;

struct _twoIntsStruct {
   int intOne ;
   int intTwo ;
};

typedef struct _twoIntsStruct twoIntsStruct;

struct __pthread_internal_list {
   struct __pthread_internal_list *__prev ;
   struct __pthread_internal_list *__next ;
};

typedef struct __pthread_internal_list __pthread_list_t;

struct __pthread_mutex_s {
   int __lock ;
   unsigned int __count ;
   int __owner ;
   unsigned int __nusers ;
   int __kind ;
   short __spins ;
   short __elision ;
   __pthread_list_t __list ;
};

typedef unsigned long pthread_t;

union __anonunion_pthread_mutexattr_t_36 {
   char __size[4U] ;
   int __align ;
};

typedef union __anonunion_pthread_mutexattr_t_36 pthread_mutexattr_t;

union pthread_attr_t {
   char __size[56U] ;
   long __align ;
};

typedef union pthread_attr_t pthread_attr_t;

union __anonunion_pthread_mutex_t_38 {
   struct __pthread_mutex_s __data ;
   char __size[40U] ;
   long __align ;
};

typedef union __anonunion_pthread_mutex_t_38 pthread_mutex_t;

struct _stdThread;

typedef struct _stdThread *stdThread;

struct _stdThreadLock;

typedef struct _stdThreadLock *stdThreadLock;

struct _stdThread {
   pthread_t handle ;
   void (*start)(void *) ;
   void *args ;
};

struct _stdThreadLock {
   pthread_mutex_t mutex ;
};

typedef long __time_t;

typedef __time_t time_t;

int printf(char const * , ...);


int sscanf(char const *, char const * , ...);


int puts(char const *);


int rand(void);


int iswxdigit(wint_t);


unsigned short const **__ctype_b_loc(void);


int const GLOBAL_CONST_TRUE;


int const GLOBAL_CONST_FALSE;


int const GLOBAL_CONST_FIVE;


int globalTrue;


int globalFalse;


int globalFive;


void printLine(char const *line);


void printWLine(wchar_t const *line);


void printIntLine(int intNumber);


void printShortLine(short shortNumber);


void printFloatLine(float floatNumber);


void printLongLine(long longNumber);


void printLongLongLine(int64_t longLongIntNumber);


void printSizeTLine(size_t sizeTNumber);


void printHexCharLine(char charHex);


void printWcharLine(wchar_t wideChar);


void printUnsignedLine(unsigned int unsignedNumber);


void printHexUnsignedCharLine(unsigned char unsignedCharacter);


void printDoubleLine(double doubleNumber);


void printStructLine(twoIntsStruct const *structTwoIntsStruct);


void printBytesLine(unsigned char const *bytes, size_t numBytes);


size_t decodeHexChars(unsigned char *bytes, size_t numBytes, char const *hex);


size_t decodeHexWChars(unsigned char *bytes, size_t numBytes, wchar_t const *hex);


int globalReturnsTrue(void);


int globalReturnsFalse(void);


int globalReturnsTrueOrFalse(void);


int globalArgc;


char **globalArgv;


int wprintf(wchar_t const * , ...);


int swscanf(wchar_t const *, wchar_t const * , ...);


void printLine(char const *line)
{
  
  if (line != (char const *)0) 
                               printf("%s\n",line); else ;
  
  return;
}


void printWLine(wchar_t const *line)
{
  
  if (line != (wchar_t const *)0) 
                                  wprintf((wchar_t const *)L"%" "l" "s" "\\n" ,line); else ;
  
  return;
}


void printIntLine(int intNumber)
{
  
  printf("%d\n",intNumber);
  
  return;
}




void printFloatLine(float floatNumber)
{
  
  printf("%f\n",(double)floatNumber);
  
  return;
}


void printLongLine(long longNumber)
{
  
  printf("%ld\n",longNumber);
  
  return;
}




void printSizeTLine(size_t sizeTNumber)
{
  
  printf("%zu\n",sizeTNumber);
  
  return;
}


void printHexCharLine(char charHex)
{
  
  printf("%02x\n",(int)charHex);
  
  return;
}


void printWcharLine(wchar_t wideChar)
{
  wchar_t s[2U];
  
  s[0] = wideChar;
  
  s[1] = 0;
  
  printf("%ls\n",(wchar_t *)(& s));
  
  return;
}


void printUnsignedLine(unsigned int unsignedNumber)
{
  
  printf("%u\n",unsignedNumber);
  
  return;
}


void printHexUnsignedCharLine(unsigned char unsignedCharacter)
{
  
  printf("%02x\n",(int)unsignedCharacter);
  
  return;
}


void printDoubleLine(double doubleNumber)
{
  
  printf("%g\n",doubleNumber);
  
  return;
}


void printStructLine(twoIntsStruct const *structTwoIntsStruct)
{
  
  printf("%d -- %d\n",structTwoIntsStruct->intOne,structTwoIntsStruct->intTwo);
  
  return;
}


void printBytesLine(unsigned char const *bytes, size_t numBytes)
{
  size_t i;
  
  i = 0UL;
  
  goto ldv_3392;
  ldv_3391: 
  ;
  
  printf("%02x",(int)*(bytes + i));
  
  i += 1UL;
  ldv_3392: 
  ;
  
  if (i < numBytes) 
                    goto ldv_3391; else 
                                        goto ldv_3393;
  ldv_3393: 
  ;
  
  puts("");
  
  return;
}


size_t decodeHexChars(unsigned char *bytes, size_t numBytes, char const *hex)
{
  
  size_t numWritten = 0UL;
  
  goto ldv_3402;
  ldv_3401: 
  ;
  {
    int byte;
    
    sscanf(hex + numWritten * 2UL,"%02x",& byte);
    
    *(bytes + numWritten) = (unsigned char)byte;
    
    numWritten += 1UL;
  }
  ldv_3402: 
  ;
  
  if (numWritten < numBytes) {
    unsigned short const **tmp;
    
    tmp = __ctype_b_loc();
    
    ;
    
    if (((int)*(*tmp + (int)*(hex + numWritten * 2UL)) & 4096) != 0) {
      unsigned short const **tmp_0;
      
      tmp_0 = __ctype_b_loc();
      
      ;
      
      if (((int)*(*tmp_0 + (int)*(hex + (numWritten * 2UL + (size_t)1U))) & 4096) != 0) 
        
        goto ldv_3401; else 
                            goto ldv_3403;
    }
    else 
         goto ldv_3403;
  }
  else 
       goto ldv_3403;
  ldv_3403: 
  ;
  
  return numWritten;
}


size_t decodeHexWChars(unsigned char *bytes, size_t numBytes, wchar_t const *hex)
{
  
  size_t numWritten = 0UL;
  
  goto ldv_3412;
  ldv_3411: 
  ;
  {
    int byte;
    
    swscanf(hex + numWritten * 2UL,(wchar_t const *)L"%" "0" "2" "x" ,& byte);
    
    *(bytes + numWritten) = (unsigned char)byte;
    
    numWritten += 1UL;
  }
  ldv_3412: 
  ;
  
  if (numWritten < numBytes) {
    int tmp;
    
    tmp = iswxdigit((unsigned int)*(hex + numWritten * 2UL));
    
    if (tmp != 0) {
      int tmp_0;
      
      tmp_0 = iswxdigit((unsigned int)*(hex + (numWritten * 2UL + (size_t)1U)));
      
      if (tmp_0 != 0) 
                      goto ldv_3411; else 
                                          goto ldv_3413;
    }
    else 
         goto ldv_3413;
  }
  else 
       goto ldv_3413;
  ldv_3413: 
  ;
  
  return numWritten;
}


int globalReturnsTrue(void)
{
  int __retres;
  
  __retres = 1;
  
  return __retres;
}


int globalReturnsFalse(void)
{
  int __retres;
  
  __retres = 0;
  
  return __retres;
}


int globalReturnsTrueOrFalse(void)
{
  int __retres;
  int tmp;
  
  tmp = rand();
  
  __retres = tmp % 2;
  
  return __retres;
}


int const GLOBAL_CONST_TRUE = 1;

int const GLOBAL_CONST_FALSE = 0;

int const GLOBAL_CONST_FIVE = 5;

int globalTrue = 1;

int globalFalse = 0;

int globalFive = 5;

void good1(void)
{
  
  return;
}


void good2(void)
{
  
  return;
}


void good3(void)
{
  
  return;
}


void good4(void)
{
  
  return;
}


void good5(void)
{
  
  return;
}


void good6(void)
{
  
  return;
}


void good7(void)
{
  
  return;
}


void good8(void)
{
  
  return;
}


void good9(void)
{
  
  return;
}


void bad1(void)
{
  
  return;
}


void bad2(void)
{
  
  return;
}


void bad3(void)
{
  
  return;
}


void bad4(void)
{
  
  return;
}


void bad5(void)
{
  
  return;
}


void bad6(void)
{
  
  return;
}


void bad7(void)
{
  
  return;
}


void bad8(void)
{
  
  return;
}


void bad9(void)
{
  
  return;
}


int globalArgc = 0;

char **globalArgv = (char **)0;

void *malloc(size_t);


void free(void *);


int pthread_create(pthread_t *, pthread_attr_t const *, void *(*)(void *), void *);


void pthread_exit(void *);


int pthread_join(pthread_t, void **);


int pthread_mutex_init(pthread_mutex_t *, pthread_mutexattr_t const *);


int pthread_mutex_destroy(pthread_mutex_t *);


int pthread_mutex_lock(pthread_mutex_t *);


int pthread_mutex_unlock(pthread_mutex_t *);


int stdThreadCreate(void (*start)(void *), void *args, stdThread *thread);


int stdThreadJoin(stdThread thread);


int stdThreadDestroy(stdThread thread);


int stdThreadLockCreate(stdThreadLock *lock);


void stdThreadLockAcquire(stdThreadLock lock);


void stdThreadLockRelease(stdThreadLock lock);


void stdThreadLockDestroy(stdThreadLock lock);


static void *internal_start(void *args)
{
  void *__retres;
  
  stdThread thread = (struct _stdThread *)args;
  
  (*(thread->start))(thread->args);
  
  pthread_exit((void *)0);
  
  __retres = (void *)0;
  
  return __retres;
}


int stdThreadCreate(void (*start)(void *), void *args, stdThread *thread)
{
  int __retres;
  pthread_t handle;
  stdThread my_thread;
  int tmp_0;
  
  *thread = (struct _stdThread *)0;
  
  my_thread = (stdThread)malloc(24UL);
  
  if (my_thread == (struct _stdThread *)0) {
    
    __retres = 0;
    
    goto return_label;
  }
  else ;
  
  my_thread->start = start;
  
  my_thread->args = args;
  
  tmp_0 = pthread_create(& handle,(pthread_attr_t const *)0,& internal_start,(void *)my_thread);
  
  if (tmp_0 != 0) {
    
    free((void *)my_thread);
    
    __retres = 0;
    
    goto return_label;
  }
  else ;
  
  my_thread->handle = handle;
  
  *thread = my_thread;
  
  __retres = 1;
  return_label: 
                return __retres;
}


int stdThreadJoin(stdThread thread)
{
  int __retres;
  void *dummy;
  int tmp;
  
  tmp = pthread_join(thread->handle,& dummy);
  
  if (tmp != 0) {
    
    __retres = 0;
    
    goto return_label;
  }
  else ;
  
  __retres = 1;
  return_label: 
                return __retres;
}


int stdThreadDestroy(stdThread thread)
{
  int __retres;
  
  free((void *)thread);
  
  __retres = 1;
  
  return __retres;
}


int stdThreadLockCreate(stdThreadLock *lock)
{
  int __retres;
  int tmp_0;
  
  stdThreadLock my_lock = (struct _stdThreadLock *)0;
  
  *lock = (struct _stdThreadLock *)0;
  
  my_lock = (stdThreadLock)malloc(40UL);
  
  if (my_lock == (struct _stdThreadLock *)0) {
    
    __retres = 0;
    
    goto return_label;
  }
  else ;
  
  tmp_0 = pthread_mutex_init(& my_lock->mutex,(pthread_mutexattr_t const *)0);
  
  if (tmp_0 != 0) {
    
    free((void *)lock);
    
    __retres = 0;
    
    goto return_label;
  }
  else ;
  
  *lock = my_lock;
  
  __retres = 1;
  return_label: 
                return __retres;
}


void stdThreadLockAcquire(stdThreadLock lock)
{
  
  pthread_mutex_lock(& lock->mutex);
  
  return;
}


void stdThreadLockRelease(stdThreadLock lock)
{
  
  pthread_mutex_unlock(& lock->mutex);
  
  return;
}


void stdThreadLockDestroy(stdThreadLock lock)
{
  
  pthread_mutex_destroy(& lock->mutex);
  
  free((void *)lock);
  
  return;
}

void *__builtin_alloca(unsigned long);


void ldv_exit(void);


void srand(unsigned int);


static void ldv_exit_1(int ldv_func_arg1);


time_t time(time_t *);


void CWE401_Memory_Leak__int64_t_malloc_12_bad(void)
{
  int64_t *data = 0;
  int tmp_1;
  int tmp_2;
  
  data = (int64_t *)0L;
  
  tmp_1 = globalReturnsTrueOrFalse();
  
  if (tmp_1 != 0) {
    
    data = (int64_t *)malloc(800UL);
    
    if (data == (int64_t *)0L) 
                               ldv_exit_1(-1); else ;
    
    *data = 5L;
    
    printLongLongLine(*data);
  }
  else {
    
    data = (int64_t *)__builtin_alloca(800UL);
    
    *data = 5L;
    
    printLongLongLine(*data);
  }
  
  tmp_2 = globalReturnsTrueOrFalse();
  
  if (tmp_2 != 0) ; else 
                         free((void *)data);
  
  return;
}


int main(int argc, char **argv)
{
  int __retres;
  {
    time_t tmp;
    
    tmp = time((time_t *)0L);
    
    srand((unsigned int)tmp);
    
    printLine("Calling bad()...");
    
    CWE401_Memory_Leak__int64_t_malloc_12_bad();
    
    printLine("Finished bad()");
    
    __retres = 0;
    
    goto return_label;
  }
  
  __retres = 0;
  return_label: 
                return __retres;
}


static void ldv_exit_1(int ldv_func_arg1)
{
  
  ldv_exit();
  
  return;
}


void *ldv_xmalloc(size_t size);


int ldv_undef_int(void);


int ldv_undef_int_positive(void);


int ldv_asprintf(char **ptr);


int ldv_asprintf(char **ptr)
{
  int __retres;
  char *new;
  int tmp_1;
  
  tmp_1 = ldv_undef_int();
  
  if (tmp_1 != 0) {
    int tmp_0;
    
    new = (char *)ldv_xmalloc(1UL);
    
    *ptr = new;
    
    tmp_0 = ldv_undef_int_positive();
    
    __retres = tmp_0;
    
    goto return_label;
  }
  else {
    
    __retres = -1;
    
    goto return_label;
  }
  return_label: 
                return __retres;
}


void abort(void); 
void assume_abort_if_not(int cond) { 
  if(!cond) {abort();}
}


void ldv_exit(void)
{
  
  assume_abort_if_not(0);
  
  return;
}


void *ldv_xmalloc(size_t size);


void *memcpy(void *, void const *, size_t);


char *ldv_strdup(char const *s);


char *ldv_strcpy(char *dest, char const *src);


char *ldv_strncpy(char *dest, char const *src, size_t n);


size_t ldv_strlen(char const *str);


char *ldv_strdup(char const *s)
{
  char *__retres;
  char *new;
  int tmp_2;
  
  tmp_2 = ldv_undef_int();
  
  if (tmp_2 != 0) {
    void *tmp_0;
    size_t tmp;
    size_t tmp_1;
    
    tmp = ldv_strlen(s);
    
    tmp_0 = ldv_xmalloc(tmp);
    
    new = (char *)tmp_0;
    
    tmp_1 = ldv_strlen(s);
    
    ;
    
    ;
    
    memcpy((void *)new,(void const *)s,tmp_1);
    
    __retres = new;
    
    goto return_label;
  }
  else {
    
    __retres = (char *)0;
    
    goto return_label;
  }
  return_label: 
                return __retres;
}


size_t ldv_strlen(char const *str)
{
  size_t __retres;
  char const *s;
  
  s = str;
  
  goto ldv_1424;
  ldv_1423: 
  ;
  
  s += 1;
  ldv_1424: 
  ;
  
  if ((int)*s != 0) 
                    goto ldv_1423; else 
                                        goto ldv_1425;
  ldv_1425: 
  ;
  
  __retres = (unsigned long)((long)s - (long)str);
  
  return __retres;
}


char *ldv_strncpy(char *dest, char const *src, size_t n)
{
  size_t i;
  
  i = 0UL;
  
  goto ldv_1433;
  ldv_1432: 
  ;
  
  *(dest + i) = *(src + i);
  
  i += 1UL;
  ldv_1433: 
  ;
  
  if (i < n && (int)*(src + i) != 0) 
                                     goto ldv_1432; else 
                                                         goto ldv_1434;
  ldv_1434: 
  ;
  
  goto ldv_1436;
  ldv_1435: 
  ;
  
  *(dest + i) = (char)0;
  
  i += 1UL;
  ldv_1436: 
  ;
  
  if (i < n) 
             goto ldv_1435; else 
                                 goto ldv_1437;
  ldv_1437: 
  ;
  
  return dest;
}


char *ldv_strcpy(char *dest, char const *src)
{
  size_t tmp;
  
  tmp = ldv_strlen(src);
  
  ;
  
  ;
  
  memcpy((void *)dest,(void const *)src,tmp);
  
  return dest;
}


void *ldv_malloc(size_t size);


void *ldv_calloc(size_t nmemb, size_t size);


void *ldv_zalloc(size_t size);


void ldv_free(void *s);


void *ldv_realloc(void *ptr, size_t size);


void *ldv_xzalloc(size_t size);








void *ldv_reference_malloc(size_t size);


void *ldv_reference_calloc(size_t nmemb, size_t size);


void *ldv_reference_zalloc(size_t size);


void ldv_reference_free(void *s);


void *ldv_reference_realloc(void *ptr, size_t size);


void *ldv_reference_xmalloc(size_t size);


void *ldv_reference_xzalloc(size_t size);










void *ldv_malloc(size_t size)
{
  void *tmp;
  
  tmp = ldv_reference_malloc(size);
  
  return tmp;
}


void *ldv_calloc(size_t nmemb, size_t size)
{
  void *tmp;
  
  tmp = ldv_reference_calloc(nmemb,size);
  
  return tmp;
}


void *ldv_zalloc(size_t size)
{
  void *tmp;
  
  tmp = ldv_reference_zalloc(size);
  
  return tmp;
}


void ldv_free(void *s)
{
  
  ldv_reference_free(s);
  
  return;
}


void *ldv_xmalloc(size_t size)
{
  void *tmp;
  
  tmp = ldv_reference_xmalloc(size);
  
  return tmp;
}


void *ldv_xzalloc(size_t size)
{
  void *tmp;
  
  tmp = ldv_reference_xzalloc(size);
  
  return tmp;
}










void *ldv_realloc(void *ptr, size_t size)
{
  void *tmp;
  
  tmp = ldv_reference_realloc(ptr,size);
  
  return tmp;
}


void abort(void); 
void reach_error(){}


void ldv_error(void);


void ldv_error(void)
{
  
  {reach_error();abort();}
  
  return;
}





int ldv_undef_long(void);


unsigned int ldv_undef_uint(void);


unsigned long ldv_undef_ulong(void);


unsigned long long ldv_undef_ulonglong(void);




int ldv_undef_int_negative(void);


int ldv_undef_int_nonpositive(void);




int __VERIFIER_nondet_int(void);


long __VERIFIER_nondet_long(void);


unsigned int __VERIFIER_nondet_uint(void);


unsigned long __VERIFIER_nondet_ulong(void);


unsigned long long __VERIFIER_nondet_ulonglong(void);




int ldv_undef_int(void)
{
  int tmp;
  
  tmp = __VERIFIER_nondet_int();
  
  return tmp;
}


int ldv_undef_long(void)
{
  int __retres;
  long tmp;
  
  tmp = __VERIFIER_nondet_long();
  
  __retres = (int)tmp;
  
  return __retres;
}


unsigned int ldv_undef_uint(void)
{
  unsigned int tmp;
  
  tmp = __VERIFIER_nondet_uint();
  
  return tmp;
}




unsigned long ldv_undef_ulong(void)
{
  unsigned long tmp;
  
  tmp = __VERIFIER_nondet_ulong();
  
  return tmp;
}


unsigned long long ldv_undef_ulonglong(void)
{
  unsigned long long tmp;
  
  tmp = __VERIFIER_nondet_ulonglong();
  
  return tmp;
}


int ldv_undef_int_positive(void)
{
  
  int ret = ldv_undef_int();
  
  assume_abort_if_not(ret > 0);
  
  return ret;
}


int ldv_undef_int_negative(void)
{
  
  int ret = ldv_undef_int();
  
  assume_abort_if_not(ret < 0);
  
  return ret;
}


int ldv_undef_int_nonpositive(void)
{
  
  int ret = ldv_undef_int();
  
  assume_abort_if_not(ret <= 0);
  
  return ret;
}






void *calloc(size_t, size_t);


void *memset(void *, int, size_t);


void *ldv_reference_malloc(size_t size)
{
  void *__retres;
  void *res;
  int tmp;
  
  tmp = ldv_undef_int();
  
  if (tmp != 0) {
    
    res = malloc(size);
    
    assume_abort_if_not(res != (void *)0);
    
    __retres = res;
    
    goto return_label;
  }
  else {
    
    __retres = (void *)0;
    
    goto return_label;
  }
  return_label: 
                return __retres;
}


void *ldv_reference_calloc(size_t nmemb, size_t size)
{
  void *tmp;
  
  tmp = calloc(nmemb,size);
  
  return tmp;
}


void *ldv_reference_zalloc(size_t size)
{
  void *tmp;
  
  tmp = calloc(1UL,size);
  
  return tmp;
}


void ldv_reference_free(void *s)
{
  
  free(s);
  
  return;
}


void *ldv_reference_realloc(void *ptr, size_t size)
{
  void *__retres;
  void *res;
  int tmp;
  
  if (ptr != (void *)0 && size == 0UL) {
    
    free(ptr);
    
    __retres = (void *)0;
    
    goto return_label;
  }
  else ;
  
  if (ptr == (void *)0) {
    
    res = malloc(size);
    
    __retres = res;
    
    goto return_label;
  }
  else ;
  
  tmp = ldv_undef_int();
  
  if (tmp != 0) {
    
    res = malloc(size);
    
    assume_abort_if_not(res != (void *)0);
    
    memcpy(res,(void const *)ptr,size);
    
    free(ptr);
    
    __retres = res;
    
    goto return_label;
  }
  else {
    
    __retres = (void *)0;
    
    goto return_label;
  }
  return_label: 
                return __retres;
}


void *ldv_reference_xmalloc(size_t size)
{
  void *res;
  
  res = malloc(size);
  
  assume_abort_if_not(res != (void *)0);
  
  return res;
}


void *ldv_reference_xzalloc(size_t size)
{
  void *res;
  
  res = calloc(1UL,size);
  
  assume_abort_if_not(res != (void *)0);
  
  return res;
}










