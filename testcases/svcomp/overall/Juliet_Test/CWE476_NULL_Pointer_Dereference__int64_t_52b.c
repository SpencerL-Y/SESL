/* TEMPLATE GENERATED TESTCASE FILE
Filename: CWE476_NULL_Pointer_Dereference__int64_t_52b.c
Label Definition File: CWE476_NULL_Pointer_Dereference.label.xml
Template File: sources-sinks-52b.tmpl.c
*/
/*
 * @description
 * CWE: 476 NULL Pointer Dereference
 * BadSource:  Set data to NULL
 * GoodSource: Initialize data
 * Sinks:
 *    GoodSink: Check for NULL before attempting to print data
 *    BadSink : Print data
 * Flow Variant: 52 Data flow: data passed as an argument from one function to another to another in three different source files
 *
 * */

#include "std_testcase.h"

#include <wchar.h>

#ifndef OMITBAD

/* bad function declaration */
void CWE476_NULL_Pointer_Dereference__int64_t_52c_badSink(int64_t * data);

void CWE476_NULL_Pointer_Dereference__int64_t_52b_badSink(int64_t * data)
{
    CWE476_NULL_Pointer_Dereference__int64_t_52c_badSink(data);
}

#endif /* OMITBAD */

#ifndef OMITGOOD

/* goodG2B uses the GoodSource with the BadSink */
void CWE476_NULL_Pointer_Dereference__int64_t_52c_goodG2BSink(int64_t * data);

void CWE476_NULL_Pointer_Dereference__int64_t_52b_goodG2BSink(int64_t * data)
{
    CWE476_NULL_Pointer_Dereference__int64_t_52c_goodG2BSink(data);
}

/* goodB2G uses the BadSource with the GoodSink */
void CWE476_NULL_Pointer_Dereference__int64_t_52c_goodB2GSink(int64_t * data);

void CWE476_NULL_Pointer_Dereference__int64_t_52b_goodB2GSink(int64_t * data)
{
    CWE476_NULL_Pointer_Dereference__int64_t_52c_goodB2GSink(data);
}

#endif /* OMITGOOD */
