/* TEMPLATE GENERATED TESTCASE FILE
Filename: CWE476_NULL_Pointer_Dereference__struct_54c.c
Label Definition File: CWE476_NULL_Pointer_Dereference.label.xml
Template File: sources-sinks-54c.tmpl.c
*/
/*
 * @description
 * CWE: 476 NULL Pointer Dereference
 * BadSource:  Set data to NULL
 * GoodSource: Initialize data
 * Sinks:
 *    GoodSink: Check for NULL before attempting to print data
 *    BadSink : Print data
 * Flow Variant: 54 Data flow: data passed as an argument from one function through three others to a fifth; all five functions are in different source files
 *
 * */

#include "std_testcase.h"

#include <wchar.h>

#ifndef OMITBAD

/* bad function declaration */
void CWE476_NULL_Pointer_Dereference__struct_54d_badSink(twoIntsStruct * data);

void CWE476_NULL_Pointer_Dereference__struct_54c_badSink(twoIntsStruct * data)
{
    CWE476_NULL_Pointer_Dereference__struct_54d_badSink(data);
}

#endif /* OMITBAD */

#ifndef OMITGOOD

/* goodG2B uses the GoodSource with the BadSink */
void CWE476_NULL_Pointer_Dereference__struct_54d_goodG2BSink(twoIntsStruct * data);

void CWE476_NULL_Pointer_Dereference__struct_54c_goodG2BSink(twoIntsStruct * data)
{
    CWE476_NULL_Pointer_Dereference__struct_54d_goodG2BSink(data);
}

/* goodB2G uses the BadSource with the GoodSink */
void CWE476_NULL_Pointer_Dereference__struct_54d_goodB2GSink(twoIntsStruct * data);

void CWE476_NULL_Pointer_Dereference__struct_54c_goodB2GSink(twoIntsStruct * data)
{
    CWE476_NULL_Pointer_Dereference__struct_54d_goodB2GSink(data);
}

#endif /* OMITGOOD */
