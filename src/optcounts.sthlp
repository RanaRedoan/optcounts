{smcl}
{* *! version 1.1.0 04jul2025}{...}
{cmd:help optcounts}
{hline}

{title:Title}

{p 4 4 2}{hi:optcounts} {hline 2} Counts user-specified special value selections per enumerator in survey data{p_end}

{title:Description}

{p 4 4 2}
{cmd:optcounts} tracks the frequency of user-defined special values (e.g., -99, 99, -999) across all variables in the dataset, counting their occurrences per enumerator. This is particularly useful for identifying the prevalence of specific codes, such as missing or outlier values, in survey data. The command generates a table showing the total count of these values and the number of surveys per enumerator, aiding in data quality assessment.
{p_end}

{title:Syntax}

{p 8 12 2}
{cmd:optcounts} {it:special_values} , {cmd:enum(}{it:enumerator_variable}{cmd:)}
{p_end}

{title:Options}

{p 4 8 2}{cmd:enum(}{it:enumerator_variable}{cmd:)} specifies the variable identifying the enumerators. This is a required option.

{p 4 8 2}{it:special_values} is a space-separated list of numeric values to count (e.g., -99 99 -999). At least one value must be provided.

{title:Examples}

{phang}{cmd:. use "Dataset.dta", clear}{p_end}
{phang}{cmd:. optcounts -99 99 -999 -98, enum(interviewer_name)}{p_end}

{title:Author}

{p 4 4 2}Md. Redoan Hossain Bhuiyan{break}
redoanhossain@gmail.com{p_end}
Whatsapp: +8801675735811{p_end}

{title:Also see}

{p 4 13 2}Online: {help biascheck}, {help collapse}{p_end}
