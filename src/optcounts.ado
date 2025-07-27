*! version 1.2.1 05jul2025
program define optcounts
    version 17
    
    syntax [anything(name=values id="special values")] , ENUMerator(varname)
    
    * Validate input - no change needed here
    if `"`values'"' == "" {
        di as error "Error: Please specify at least one special value to count."
        exit 198
    }
    
    * Parse values into a local macro list - no change needed here
    local value_count : word count `values'
    if `value_count' == 0 {
        di as error "Error: No valid values specified."
        exit 198
    }
    local value_list
    forvalues i = 1/`value_count' {
        local val : word `i' of `values'
        capture confirm number `val'
        if _rc == 0 {
            local value_list `value_list' `val'
        }
        else {
            di as text "Warning: '`val'' is not a valid number, skipping."
        }
    }
    if `"`value_list'"' == "" {
        di as error "Error: No valid numeric values specified."
        exit 198
    }
    
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
            quietly {
                gen temp_count = 0
                foreach val of local value_list {
                    replace temp_count = temp_count + 1 if `var' == `val'
                }
                replace total_special = total_special + temp_count
                drop temp_count
            }
        }
        capture confirm string variable `var'
        if _rc == 0 {
            * Convert string values to numeric for comparison (assuming valid numbers)
            quietly {
                destring `var', replace ignore(" ") force
                gen temp_count = 0
                foreach val of local value_list {
                    replace temp_count = temp_count + 1 if `var' == `val'
                }
                replace total_special = total_special + temp_count
                drop temp_count
            }
        }
    }
    
    * Generate total surveys per enumerator
    * MODIFIED: Create string version of enumerator for grouping
    tempvar enum_str
    capture confirm string variable `enumerator'
    if _rc == 0 {
        clonevar `enum_str' = `enumerator'
    }
    else {
        tostring `enumerator', gen(`enum_str') force
    }
    
    bysort `enum_str': gen survey_count = _N
    
    * Collapse to get counts by enumerator
    collapse (sum) total_special (firstnm) survey_count, by(`enum_str')
    rename `enum_str' `enumerator'
    
    * Sort and display results
    sort total_special
    list `enumerator' survey_count total_special, noobs separator(0) abbreviate(12)
    
    * Clean up
    restore, not
end
