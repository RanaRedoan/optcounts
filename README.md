# 📊 optcounts: Count Special Values per Enumerator in Survey Data

`optcounts` is a Stata program that counts **user-specified special values** (e.g., -99, 99, -999) across all variables in your survey dataset, **grouped by enumerator**.  
It helps researchers quickly identify data quality issues, unusual codes, and patterns across enumerators.

---

## 🚀 Installation

You can install the command directly from GitHub:

```stata
net install optcounts, from("https://raw.githubusercontent.com/RanaRedoan/optcounts/main") replace
```
---
## 📖 Syntax

```stata
net install optcounts, from("https://raw.githubusercontent.com/RanaRedoan/optcounts/main") replace
```
---

---
## 📌 Option

### Required
`by(enumerator_variable)` → Enumerator identifier variable (e.g., interviewer ID)

### Optional
`special_values` → Space-separated list of numeric values to count (e.g., -99 99 -999). At least one value must be provided.

---

## 📊 Description

`optcounts` scans all variables in your dataset and counts occurrences of user-defined special values per enumerator.
It works with both numeric and string enumerator variables (automatically encoding strings if needed).

### Researchers can use this tool to:
✅ Identify enumerators with unusually high or low counts of special values
✅ Detect potential data entry errors or coding inconsistencies
✅ Summarize survey completion or missing data patterns
✅ Monitor and improve data quality across enumerators

## 💻 Examples
Basic usage: count multiple special values per enumerator
```stata
optcounts -99 99 -999 -98, by(interviewer_name)
```
---
Count a single special value
```stata
optcounts -99, by(interviewer_name)
```
---

## 🤝 Contribution
Pull requests and suggestions are welcome!
If you find issues or have feature requests, please open an Issue in the repository.

## 👨‍💻 Author
  Md. Redoan Hossain Bhuiyan
📧 redoanhossain630@gmail.com

 ## 📌 License

This project is licensed under the MIT License.

