/* TEMPLATE GENERATED TESTCASE FILE
Filename: CWE476_NULL_Pointer_Dereference__int_53c.c
Label Definition File: CWE476_NULL_Pointer_Dereference.label.xml
Template File: sources-sinks-53c.tmpl.c
*/
/*
 * @description
 * CWE: 476 NULL Pointer Dereference
 * BadSource:  Set data to NULL
 * GoodSource: Initialize data
 * Sinks:
 *    GoodSink: Check for NULL before attempting to print data
 *    BadSink : Print data
 * Flow Variant: 53 Data flow: data passed as an argument from one function through two others to a fourth; all four functions are in different source files
 *
 * */

#include "std_testcase.h"

#include <wchar.h>

#ifndef OMITBAD

/* bad function declaration */
void CWE476_NULL_Pointer_Dereference__int_53d_badSink(int * data);

void CWE476_NULL_Pointer_Dereference__int_53c_badSink(int * data)
{
    CWE476_NULL_Pointer_Dereference__int_53d_badSink(data);
}

#endif /* OMITBAD */

#ifndef OMITGOOD

/* goodG2B uses the GoodSource with the BadSink */
void CWE476_NULL_Pointer_Dereference__int_53d_goodG2BSink(int * data);

void CWE476_NULL_Pointer_Dereference__int_53c_goodG2BSink(int * data)
{
    CWE476_NULL_Pointer_Dereference__int_53d_goodG2BSink(data);
}

/* goodB2G uses the BadSource with the GoodSink */
void CWE476_NULL_Pointer_Dereference__int_53d_goodB2GSink(int * data);

void CWE476_NULL_Pointer_Dereference__int_53c_goodB2GSink(int * data)
{
    CWE476_NULL_Pointer_Dereference__int_53d_goodB2GSink(data);
}

#endif /* OMITGOOD */
