*! version 1.2.2 30Jul2025
program define optcounts
    version 17
    
    syntax [anything(name=values id="special values")] , ENUMerator(varname)
    
    * Validate input
    if `"`values'"' == "" {
        di as error "Error: Please specify at least one special value to count."
        exit 198
    }
    
    * Parse values into a local macro list
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
    
    * Preserve the original data
    preserve
    
    * Handle string enumerator variable by creating numeric copy
    tempvar enum_num
    capture confirm string variable `enumerator'
    if !_rc {
        encode `enumerator', gen(`enum_num')
        local enum_var `enum_num'
        local is_string_enumerator 1
    }
    else {
        local enum_var `enumerator'
        local is_string_enumerator 0
    }
    
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
            * Convert string values to numeric for comparison
            quietly {
                tempvar numeric_var
                gen `numeric_var' = real(`var')
                gen temp_count = 0
                foreach val of local value_list {
                    replace temp_count = temp_count + 1 if `numeric_var' == `val' & !missing(`numeric_var')
                }
                replace total_special = total_special + temp_count
                drop temp_count `numeric_var'
            }
        }
    }
    
    * Generate total surveys per enumerator
    bysort `enum_var': gen survey_count = _N
    
    * Handle string enumerator case without nested preserve
    if `is_string_enumerator' {
        tempfile temp_results
        collapse (sum) total_special (firstnm) survey_count, by(`enum_var')
        decode `enum_var', gen(`enumerator')
        keep `enumerator' survey_count total_special
        save "`temp_results'"
        restore
        
        * Load and display the results
        preserve
        use "`temp_results'", clear
    }
    else {
        collapse (sum) total_special (firstnm) survey_count, by(`enumerator')
    }
    
    * Sort and display results
    sort total_special
    list `enumerator' survey_count total_special, noobs separator(0) abbreviate(12)
    
    * Clean up
    restore
end
