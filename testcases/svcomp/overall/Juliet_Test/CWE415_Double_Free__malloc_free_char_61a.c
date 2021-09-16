/* TEMPLATE GENERATED TESTCASE FILE
Filename: CWE415_Double_Free__malloc_free_char_61a.c
Label Definition File: CWE415_Double_Free__malloc_free.label.xml
Template File: sources-sinks-61a.tmpl.c
*/
/*
 * @description
 * CWE: 415 Double Free
 * BadSource:  Allocate data using malloc() and Deallocate data using free()
 * GoodSource: Allocate data using malloc()
 * Sinks:
 *    GoodSink: do nothing
 *    BadSink : Deallocate data using free()
 * Flow Variant: 61 Data flow: data returned from one function to another in different source files
 *
 * */

#include "std_testcase.h"

#include <wchar.h>

#ifndef OMITBAD

/* bad function declaration */
char * CWE415_Double_Free__malloc_free_char_61b_badSource(char * data);

void CWE415_Double_Free__malloc_free_char_61_bad()
{
    char * data;
    /* Initialize data */
    data = NULL;
    data = CWE415_Double_Free__malloc_free_char_61b_badSource(data);
    /* POTENTIAL FLAW: Possibly freeing memory twice */
    free(data);
}

#endif /* OMITBAD */

#ifndef OMITGOOD

/* goodG2B uses the GoodSource with the BadSink */
char * CWE415_Double_Free__malloc_free_char_61b_goodG2BSource(char * data);

static void goodG2B()
{
    char * data;
    /* Initialize data */
    data = NULL;
    data = CWE415_Double_Free__malloc_free_char_61b_goodG2BSource(data);
    /* POTENTIAL FLAW: Possibly freeing memory twice */
    free(data);
}

/* goodB2G uses the BadSource with the GoodSink */
char * CWE415_Double_Free__malloc_free_char_61b_goodB2GSource(char * data);

static void goodB2G()
{
    char * data;
    /* Initialize data */
    data = NULL;
    data = CWE415_Double_Free__malloc_free_char_61b_goodB2GSource(data);
    /* do nothing */
    /* FIX: Don't attempt to free the memory */
    ; /* empty statement needed for some flow variants */
}

void CWE415_Double_Free__malloc_free_char_61_good()
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
    CWE415_Double_Free__malloc_free_char_61_good();
    printLine("Finished good()");
#endif /* OMITGOOD */
#ifndef OMITBAD
    printLine("Calling bad()...");
    CWE415_Double_Free__malloc_free_char_61_bad();
    printLine("Finished bad()");
#endif /* OMITBAD */
    return 0;
}

#endif
