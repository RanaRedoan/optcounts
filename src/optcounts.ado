*! version 1.1.0 04jul2025
program define optcounts
    version 17
    
    syntax [anything(name=values id="special values")] , ENUMerator(varname)
    
    * Validate input
    if `"`values'"' == "" {
        di as error "Error: Please specify at least one special value to count."
        exit 198
    }
    
    * Convert values to local macro for inlist
    local value_list `values'
    
    * Create a temporary dataset to store counts
    preserve
    
    * Initialize count variable
    gen total_special = 0
    
    * Get list of all variables
    ds
    foreach var of varlist `r(varlist)' {
        capture confirm numeric variable `var'
        if _rc == 0 {
            * Count occurrences of special values for numeric variables
            replace total_special = total_special + 1 if inlist(`var', `value_list')
        }
        capture confirm string variable `var'
        if _rc == 0 {
            * Convert string values to numeric for comparison (assuming valid numbers)
            quietly {
                destring `var', replace ignore(" ") force
                replace total_special = total_special + 1 if inlist(`var', `value_list')
            }
        }
    }
    
    * Generate total surveys per enumerator
    bysort `enumerator': gen survey_count = _N
    
    * Collapse to get counts by enumerator
    collapse (sum) total_special (firstnm) survey_count, by(`enumerator')
    
    * Sort and display results
    sort total_special
    list `enumerator' survey_count total_special, noobs separator(0) abbreviate(12)
    
    * Clean up
    restore, not
end