/* TEMPLATE GENERATED TESTCASE FILE
Filename: CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45.c
Label Definition File: CWE401_Memory_Leak.c.label.xml
Template File: sources-sinks-45.tmpl.c
*/
/*
 * @description
 * CWE: 401 Memory Leak
 * BadSource: realloc Allocate data using realloc()
 * GoodSource: Allocate data on the stack
 * Sinks:
 *    GoodSink: call free() on data
 *    BadSink : no deallocation of data
 * Flow Variant: 45 Data flow: data passed as a static global variable from one function to another in the same source file
 *
 * */

#include "std_testcase.h"

#include <wchar.h>

static struct _twoIntsStruct * CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_badData;
static struct _twoIntsStruct * CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_goodG2BData;
static struct _twoIntsStruct * CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_goodB2GData;

#ifndef OMITBAD

static void badSink()
{
    struct _twoIntsStruct * data = CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_badData;
    /* POTENTIAL FLAW: No deallocation */
    ; /* empty statement needed for some flow variants */
}

void CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_bad()
{
    struct _twoIntsStruct * data;
    data = NULL;
    /* POTENTIAL FLAW: Allocate memory on the heap */
    data = (struct _twoIntsStruct *)realloc(data, 100*sizeof(struct _twoIntsStruct));
    if (data == NULL) {exit(-1);}
    /* Initialize and make use of data */
    data[0].intOne = 0;
    data[0].intTwo = 0;
    printStructLine((twoIntsStruct *)&data[0]);
    CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_badData = data;
    badSink();
}

#endif /* OMITBAD */

#ifndef OMITGOOD

/* goodG2B() uses the GoodSource with the BadSink */
static void goodG2BSink()
{
    struct _twoIntsStruct * data = CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_goodG2BData;
    /* POTENTIAL FLAW: No deallocation */
    ; /* empty statement needed for some flow variants */
}

static void goodG2B()
{
    struct _twoIntsStruct * data;
    data = NULL;
    /* FIX: Use memory allocated on the stack with ALLOCA */
    data = (struct _twoIntsStruct *)ALLOCA(100*sizeof(struct _twoIntsStruct));
    /* Initialize and make use of data */
    data[0].intOne = 0;
    data[0].intTwo = 0;
    printStructLine((twoIntsStruct *)&data[0]);
    CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_goodG2BData = data;
    goodG2BSink();
}

/* goodB2G() uses the BadSource with the GoodSink */
static void goodB2GSink()
{
    struct _twoIntsStruct * data = CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_goodB2GData;
    /* FIX: Deallocate memory */
    free(data);
}

static void goodB2G()
{
    struct _twoIntsStruct * data;
    data = NULL;
    /* POTENTIAL FLAW: Allocate memory on the heap */
    data = (struct _twoIntsStruct *)realloc(data, 100*sizeof(struct _twoIntsStruct));
    if (data == NULL) {exit(-1);}
    /* Initialize and make use of data */
    data[0].intOne = 0;
    data[0].intTwo = 0;
    printStructLine((twoIntsStruct *)&data[0]);
    CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_goodB2GData = data;
    goodB2GSink();
}

void CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_good()
{
    goodG2B();
    goodB2G();
}

#endif /* OMITGOOD */

/* Below is the main(). It is only used when building this testcase on
   its own for testing or for building a binary to use in testing binary
   analysis tools. It is not used when compiling all the testcases as one
   application, which is how source code analysis tools are tested. */
#ifdef INCLUDEMAIN

int main(int argc, char * argv[])
{
    /* seed randomness */
    srand( (unsigned)time(NULL) );
#ifndef OMITGOOD
    printLine("Calling good()...");
    CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_good();
    printLine("Finished good()");
#endif /* OMITGOOD */
#ifndef OMITBAD
    printLine("Calling bad()...");
    CWE401_Memory_Leak__struct_twoIntsStruct_realloc_45_bad();
    printLine("Finished bad()");
#endif /* OMITBAD */
    return 0;
}

#endif
