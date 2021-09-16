/* TEMPLATE GENERATED TESTCASE FILE
Filename: CWE476_NULL_Pointer_Dereference__int_32.c
Label Definition File: CWE476_NULL_Pointer_Dereference.label.xml
Template File: sources-sinks-32.tmpl.c
*/
/*
 * @description
 * CWE: 476 NULL Pointer Dereference
 * BadSource:  Set data to NULL
 * GoodSource: Initialize data
 * Sinks:
 *    GoodSink: Check for NULL before attempting to print data
 *    BadSink : Print data
 * Flow Variant: 32 Data flow using two pointers to the same value within the same function
 *
 * */

#include "std_testcase.h"

#include <wchar.h>

#ifndef OMITBAD

void CWE476_NULL_Pointer_Dereference__int_32_bad()
{
    int * data;
    int * *dataPtr1 = &data;
    int * *dataPtr2 = &data;
    {
        int * data = *dataPtr1;
        /* POTENTIAL FLAW: Set data to NULL */
        data = NULL;
        *dataPtr1 = data;
    }
    {
        int * data = *dataPtr2;
        /* POTENTIAL FLAW: Attempt to use data, which may be NULL */
        printIntLine(*data);
    }
}

#endif /* OMITBAD */

#ifndef OMITGOOD

/* goodG2B() uses the GoodSource with the BadSink */
static void goodG2B()
{
    int * data;
    int tmpData = 5;
    int * *dataPtr1 = &data;
    int * *dataPtr2 = &data;
    {
        int * data = *dataPtr1;
        /* FIX: Initialize data */
        {
            data = &tmpData;
        }
        *dataPtr1 = data;
    }
    {
        int * data = *dataPtr2;
        /* POTENTIAL FLAW: Attempt to use data, which may be NULL */
        printIntLine(*data);
    }
}

/* goodB2G() uses the BadSource with the GoodSink */
static void goodB2G()
{
    int * data;
    int * *dataPtr1 = &data;
    int * *dataPtr2 = &data;
    {
        int * data = *dataPtr1;
        /* POTENTIAL FLAW: Set data to NULL */
        data = NULL;
        *dataPtr1 = data;
    }
    {
        int * data = *dataPtr2;
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
}

void CWE476_NULL_Pointer_Dereference__int_32_good()
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
    CWE476_NULL_Pointer_Dereference__int_32_good();
    printLine("Finished good()");
#endif /* OMITGOOD */
#ifndef OMITBAD
    printLine("Calling bad()...");
    CWE476_NULL_Pointer_Dereference__int_32_bad();
    printLine("Finished bad()");
#endif /* OMITBAD */
    return 0;
}

#endif
