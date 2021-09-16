/* TEMPLATE GENERATED TESTCASE FILE
Filename: CWE476_NULL_Pointer_Dereference__long_04.c
Label Definition File: CWE476_NULL_Pointer_Dereference.label.xml
Template File: sources-sinks-04.tmpl.c
*/
/*
 * @description
 * CWE: 476 NULL Pointer Dereference
 * BadSource:  Set data to NULL
 * GoodSource: Initialize data
 * Sinks:
 *    GoodSink: Check for NULL before attempting to print data
 *    BadSink : Print data
 * Flow Variant: 04 Control flow: if(STATIC_CONST_TRUE) and if(STATIC_CONST_FALSE)
 *
 * */

#include "std_testcase.h"

#include <wchar.h>

/* The two variables below are declared "const", so a tool should
   be able to identify that reads of these will always return their
   initialized values. */
static const int STATIC_CONST_TRUE = 1; /* true */
static const int STATIC_CONST_FALSE = 0; /* false */

#ifndef OMITBAD

void CWE476_NULL_Pointer_Dereference__long_04_bad()
{
    long * data;
    if(STATIC_CONST_TRUE)
    {
        /* POTENTIAL FLAW: Set data to NULL */
        data = NULL;
    }
    if(STATIC_CONST_TRUE)
    {
        /* POTENTIAL FLAW: Attempt to use data, which may be NULL */
        printLongLine(*data);
    }
}

#endif /* OMITBAD */

#ifndef OMITGOOD

/* goodB2G1() - use badsource and goodsink by changing the second STATIC_CONST_TRUE to STATIC_CONST_FALSE */
static void goodB2G1()
{
    long * data;
    if(STATIC_CONST_TRUE)
    {
        /* POTENTIAL FLAW: Set data to NULL */
        data = NULL;
    }
    if(STATIC_CONST_FALSE)
    {
        /* INCIDENTAL: CWE 561 Dead Code, the code below will never run */
        printLine("Benign, fixed string");
    }
    else
    {
        /* FIX: Check for NULL before attempting to print data */
        if (data != NULL)
        {
            printLongLine(*data);
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
    long * data;
    if(STATIC_CONST_TRUE)
    {
        /* POTENTIAL FLAW: Set data to NULL */
        data = NULL;
    }
    if(STATIC_CONST_TRUE)
    {
        /* FIX: Check for NULL before attempting to print data */
        if (data != NULL)
        {
            printLongLine(*data);
        }
        else
        {
            printLine("data is NULL");
        }
    }
}

/* goodG2B1() - use goodsource and badsink by changing the first STATIC_CONST_TRUE to STATIC_CONST_FALSE */
static void goodG2B1()
{
    long * data;
    long tmpData = 5L;
    if(STATIC_CONST_FALSE)
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
    if(STATIC_CONST_TRUE)
    {
        /* POTENTIAL FLAW: Attempt to use data, which may be NULL */
        printLongLine(*data);
    }
}

/* goodG2B2() - use goodsource and badsink by reversing the blocks in the first if */
static void goodG2B2()
{
    long * data;
    long tmpData = 5L;
    if(STATIC_CONST_TRUE)
    {
        /* FIX: Initialize data */
        {
            data = &tmpData;
        }
    }
    if(STATIC_CONST_TRUE)
    {
        /* POTENTIAL FLAW: Attempt to use data, which may be NULL */
        printLongLine(*data);
    }
}

void CWE476_NULL_Pointer_Dereference__long_04_good()
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
    CWE476_NULL_Pointer_Dereference__long_04_good();
    printLine("Finished good()");
#endif /* OMITGOOD */
#ifndef OMITBAD
    printLine("Calling bad()...");
    CWE476_NULL_Pointer_Dereference__long_04_bad();
    printLine("Finished bad()");
#endif /* OMITBAD */
    return 0;
}

#endif
