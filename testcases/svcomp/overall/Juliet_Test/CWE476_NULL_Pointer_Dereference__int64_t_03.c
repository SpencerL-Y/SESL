/* TEMPLATE GENERATED TESTCASE FILE
Filename: CWE476_NULL_Pointer_Dereference__int64_t_03.c
Label Definition File: CWE476_NULL_Pointer_Dereference.label.xml
Template File: sources-sinks-03.tmpl.c
*/
/*
 * @description
 * CWE: 476 NULL Pointer Dereference
 * BadSource:  Set data to NULL
 * GoodSource: Initialize data
 * Sinks:
 *    GoodSink: Check for NULL before attempting to print data
 *    BadSink : Print data
 * Flow Variant: 03 Control flow: if(5==5) and if(5!=5)
 *
 * */

#include "std_testcase.h"

#include <wchar.h>

#ifndef OMITBAD

void CWE476_NULL_Pointer_Dereference__int64_t_03_bad()
{
    int64_t * data;
    if(5==5)
    {
        /* POTENTIAL FLAW: Set data to NULL */
        data = NULL;
    }
    if(5==5)
    {
        /* POTENTIAL FLAW: Attempt to use data, which may be NULL */
        printLongLongLine(*data);
    }
}

#endif /* OMITBAD */

#ifndef OMITGOOD

/* goodB2G1() - use badsource and goodsink by changing the second 5==5 to 5!=5 */
static void goodB2G1()
{
    int64_t * data;
    if(5==5)
    {
        /* POTENTIAL FLAW: Set data to NULL */
        data = NULL;
    }
    if(5!=5)
    {
        /* INCIDENTAL: CWE 561 Dead Code, the code below will never run */
        printLine("Benign, fixed string");
    }
    else
    {
        /* FIX: Check for NULL before attempting to print data */
        if (data != NULL)
        {
            printLongLongLine(*data);
        }
        else
        {
            printLine("data is NULL");
        }
    }
}

/* goodB2G2() - use badsource and goodsink by reversing the blocks in the second if */
static void goodB2G2()
{
    int64_t * data;
    if(5==5)
    {
        /* POTENTIAL FLAW: Set data to NULL */
        data = NULL;
    }
    if(5==5)
    {
        /* FIX: Check for NULL before attempting to print data */
        if (data != NULL)
        {
            printLongLongLine(*data);
        }
        else
        {
            printLine("data is NULL");
        }
    }
}

/* goodG2B1() - use goodsource and badsink by changing the first 5==5 to 5!=5 */
static void goodG2B1()
{
    int64_t * data;
    int64_t tmpData = 5LL;
    if(5!=5)
    {
        /* INCIDENTAL: CWE 561 Dead Code, the code below will never run */
        printLine("Benign, fixed string");
    }
    else
    {
        /* FIX: Initialize data */
        {
            data = &tmpData;
        }
    }
    if(5==5)
    {
        /* POTENTIAL FLAW: Attempt to use data, which may be NULL */
        printLongLongLine(*data);
    }
}

/* goodG2B2() - use goodsource and badsink by reversing the blocks in the first if */
static void goodG2B2()
{
    int64_t * data;
    int64_t tmpData = 5LL;
    if(5==5)
    {
        /* FIX: Initialize data */
        {
            data = &tmpData;
        }
    }
    if(5==5)
    {
        /* POTENTIAL FLAW: Attempt to use data, which may be NULL */
        printLongLongLine(*data);
    }
}

void CWE476_NULL_Pointer_Dereference__int64_t_03_good()
{
    goodB2G1();
    goodB2G2();
    goodG2B1();
    goodG2B2();
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
    CWE476_NULL_Pointer_Dereference__int64_t_03_good();
    printLine("Finished good()");
#endif /* OMITGOOD */
#ifndef OMITBAD
    printLine("Calling bad()...");
    CWE476_NULL_Pointer_Dereference__int64_t_03_bad();
    printLine("Finished bad()");
#endif /* OMITBAD */
    return 0;
}

#endif
