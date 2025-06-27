---
title: (2) Data Validation
nav: Validation
---

A short blurb on some common ways to validate your data, build in checks to your script to catch common errors
There are lots of ways to tackle this issue. We aren't going to cover plotting in this workshop but I visualizing your data can be hugely helpful in finding typos, extreme values, etc. Today we are going to focus on using the `assertr` package. 

### QA/QC Checklist for `penguins` Dataset

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

## Verify

Verify takes a dataframe and a logical expression, and terminates the pipeline if the expression is evaluated to be FALSE for any values (i.e. any rows)

1. Check for missing values: 

```r
penguins %>%
  verify(!is.na(species)) %>%
  verify(!is.na(sex)) %>% 
  verify(!is.na(island)) %>% 

  
```
When we run the code, it prints the dataframe to the console, which tells us there are NAs in the `sex` column. 
You might notice that only the first two lines of code ran, which is intentional. Verify will terminate the pipeline as soon as there is an error. This is helpful because we can build verify into our pipelines when wrangling data. So we still don't know whether `island` has any NAs. 

1. Check that there are only the 3 species names we are expecting

```r
penguins %>%
  verify(species %in% c("Adelie", "Chinstrap", "Gentoo"))

```
2. What about the bill_length_mm column?

```r
penguins %>%
  verify(!is.na(bill_length_mm)) 
```

3. Check that `body_mass_g` is between 2500 and 7000

```r 

penguins %>%
  verify(body_mass_g >= 2500 & body_mass_g <= 7000)

```

This time we get an error message. And we know that rows 4 and 272 are the offenders. In this case, these are actually NAs 

```r
penguins[4, ]
penguins[272, ]
```

4. Check `flipper_length_mm` is > 0   

```r
penguins %>% 
  verify(flipper_length_mm > 0)

penguins %>% 
  assert(within_bounds(0, Inf), flipper_length_mm)
```
### Assert()
The assert function takes a dataframe, a predicate, and at least one column to apply it to. But you can supply more than 1 column at a time 

We can also check for the same errors with assert()

```r
penguins %>%
  assert(within_bounds(0, Inf), c(bill_length_mm, flipper_length_mm))
```

6. `bill_depth_mm` is between 15 and 25      

```r
penguins %>% 
  assert(within_bounds(15, 25), bill_depth_mm )
```

### Assert vs Verify 

Verify first will evaluate the logical expression given on the entire column, then checks those values for a FALSE. Becuase of this, verify will only return the rows that are the offenders but not the values of those cells. 

Assert uses `dplyr::select` internally on the columns provided, and so can tell you the value in the row. 

But because assert works on columns, you can't validate anything about the structure of the entire dataframe itself with assert. 

For example, 

```r
penguins %>%
  verify(nrow(.) > 100)

```

We can also write our own predicates to use with assert. For example, we can check that bill depth is always less than bill length.


```


```

### Insist
