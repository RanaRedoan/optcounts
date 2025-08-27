{smcl} 
{* *! version 1.3 27Aug2025}{...}
{cmd:help optcounts}
{hline}

{title:Title}

{p 4 4 2}{hi:optcounts} {hline 2} Counts user-specified special value selections per enumerator in survey data{p_end}

{title:Description}

{p 4 4 2}
{cmd:optcounts} tracks the frequency of user-defined special values (e.g., -99, 99, -999) across all variables in the dataset, counting their occurrences per enumerator. This is particularly useful for identifying the prevalence of specific codes, such as missing, outlier, or special indicator values, in survey data. The command helps you assess data quality by showing both the total count of these values and the total number of surveys per enumerator.
{p_end}

{p 4 4 2}
This command automatically handles both numeric and string enumerator variables. If a string enumerator is provided, it temporarily encodes it into a numeric variable for computation and then decodes it back for display, ensuring seamless operation.
{p_end}

{p 4 4 2}
It is particularly helpful in large survey datasets where you want to:
{p_end}

{p 6 6 2}
• Identify enumerators with unusually high or low counts of special values  
• Detect potential data entry errors or coding inconsistencies  
• Summarize survey completion or missing data patterns  
• Aid in monitoring and improving data quality across enumerators
{p_end}

{title:Syntax}

{p 8 12 2}
{cmd:optcounts} {it:special_values} , {cmd:by(}{it:enumerator_variable}{cmd:)}
{p_end}

{title:Options}

{p 4 8 2}{cmd:by(}{it:enumerator_variable}{cmd:)} specifies the variable identifying the enumerators. This is a required option.  
{p_end}

{p 4 8 2}{it:special_values} is a space-separated list of numeric values to count (e.g., -99 99 -999). At least one value must be provided.  
{p_end}

{title:Examples}

{p 4 4 2}* Count multiple special values per enumerator{p_end}
{phang}{cmd:. optcounts -99 99 -999 -98, by(interviewer_name)}{p_end}

{p 4 4 2}* Count a single special value per enumerator{p_end}
{phang}{cmd:. optcounts 99, by(interviewer_name)}{p_end}

{p 4 4 2}* Example workflow in a .do file{p_end}
{phang}{cmd:* Load dataset
use "survey_data.dta", clear
* Count specified special values
optcounts -99 99, by(interviewer_id)
}{p_end}

{title:Output}

{p 4 4 2}The command generates a table containing:  
{p_end}

{p 6 6 2}
• Enumerator identifier  
• Total number of surveys for each enumerator  
• Total count of special values per enumerator
{p_end}

{p 4 4 2}This allows quick visual inspection of which enumerators may have entered unusual or special codes more frequently than others.  
{p_end}

{title:Author}

{p 4 4 2}
Md. Redoan Hossain Bhuiyan  
{p_end}
{p 4 4 2}
Email: redoanhossain630@gmail.com  
{p_end}
{p 4 4 2}
LinkedIn: {browse "https://www.linkedin.com/in/mdredoanhossainbhuiyan":www.linkedin.com/in/mdredoanhossainbhuiyan}  
GitHub: {browse "https://github.com/RanaRedoan":https://github.com/RanaRedoan}  
{p_end}

{title:Also see}

{p 4 13 2}Online: {help biascheck}, {help detectoutlier}, {help inputcorrection}{p_end}
