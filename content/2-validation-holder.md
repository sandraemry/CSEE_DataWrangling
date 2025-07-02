---
title: (2) Data Validation
nav: Validation
---

While you are cleaning your data, you are also going to want to validate, or QA/QC, your data. Data entry errors are common, so we need a reproducible way to catch these. 
There are lots of ways to tackle this issue. We aren't going to cover plotting in this workshop but I visualizing your data can be hugely helpful in finding typos, extreme values, etc. Today we are going to focus on using the `assertr` package. 

### QA/QC Checklist for `penguins` Dataset

<div style="overflow-x:auto;">

| Check # | Validation Rule                                               | Status (✓/✗) | Notes / Fix Action                      |
|--------:|---------------------------------------------------------------|:------------:|------------------------------------------|
| 1       | No missing values in `species`, `sex`, `year`                 |              |                                          |
| 2       | All `species` are Adelie, Chinstrap, or Gentoo                |              |                                          |
| 3       | `body_mass_g` is between 2500 and 7000                        |              |                                          |
| 4       | `flipper_length_mm` is > 0                                    |              |                                          |
| 5       | `bill_length_mm` is between 30 and 60                         |              |                                          |
| 6       | `bill_depth_mm` is between 15 and 25                          |              |                                          |
| 7       | `year` is between 2007 and 2009                               |              |                                          |
| 8       | Categorical variables are properly formatted (no typos)       |              |                                          |
| 9       | No negative values in numeric fields                          |              |                                          |
| 10      | Data types are consistent with variable meaning (e.g. sex = factor) |         |                                          |

</div>
  
This page will be updated the day of the workshop. 