/* TEMPLATE GENERATED TESTCASE FILE
Filename: CWE476_NULL_Pointer_Dereference__int_44.c
Label Definition File: CWE476_NULL_Pointer_Dereference.label.xml
Template File: sources-sinks-44.tmpl.c
*/
/*
 * @description
 * CWE: 476 NULL Pointer Dereference
 * BadSource:  Set data to NULL
 * GoodSource: Initialize data
 * Sinks:
 *    GoodSink: Check for NULL before attempting to print data
 *    BadSink : Print data
 * Flow Variant: 44 Data/control flow: data passed as an argument from one function to a function in the same source file called via a function pointer
 *
 * */

#include "std_testcase.h"

#include <wchar.h>

#ifndef OMITBAD

static void badSink(int * data)
{
    /* POTENTIAL FLAW: Attempt to use data, which may be NULL */
    printIntLine(*data);
}

void CWE476_NULL_Pointer_Dereference__int_44_bad()
{
    int * data;
    /* define a function pointer */
    void (*funcPtr) (int *) = badSink;
    /* POTENTIAL FLAW: Set data to NULL */
    data = NULL;
    /* use the function pointer */
    funcPtr(data);
}

#endif /* OMITBAD */

#ifndef OMITGOOD

/* goodG2B() uses the GoodSource with the BadSink */
static void goodG2BSink(int * data)
{
    /* POTENTIAL FLAW: Attempt to use data, which may be NULL */
    printIntLine(*data);
}

static void goodG2B()
{
    int * data;
    int tmpData = 5;
    void (*funcPtr) (int *) = goodG2BSink;
    /* FIX: Initialize data */
    {
        data = &tmpData;
    }
    funcPtr(data);
}

/* goodB2G() uses the BadSource with the GoodSink */
static void goodB2GSink(int * data)
{
    /* FIX: Check for NULL before attempting to print data */
    if (data != NULL)
    {
        printIntLine(*data);
    }
    else
    {
        printLine("data is NULL");
    }
}

static void goodB2G()
{
    int * data;
    void (*funcPtr) (int *) = goodB2GSink;
    /* POTENTIAL FLAW: Set data to NULL */
    data = NULL;
    funcPtr(data);
}

void CWE476_NULL_Pointer_Dereference__int_44_good()
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
    CWE476_NULL_Pointer_Dereference__int_44_good();
    printLine("Finished good()");
#endif /* OMITGOOD */
#ifndef OMITBAD
    printLine("Calling bad()...");
    CWE476_NULL_Pointer_Dereference__int_44_bad();
    printLine("Finished bad()");
#endif /* OMITBAD */
    return 0;
}

#endif
