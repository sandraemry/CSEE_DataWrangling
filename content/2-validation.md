---
title: (2) Data Validation
nav: Validation
---

A short blurb on some common ways to validate your data, build in checks to your script to catch common errors
There are lots of ways to tackle this issue. We aren't going to cover plotting in this workshop but I visualizing your data can be hugely helpful in finding typos, extreme values, etc. Today we are going to focus on using the `assertr` package. 

## Verify

Check for missing values: 

```r
penguins %>%
  verify(!is.na(species)) 
```
When we run the code, it prints the dataframe to the console, which tells us there are no NAs in the species column. 

What about the bill_length_mm column?

```r
penguins %>%
  verify(!is.na(bill_length_mm)) 
```
This time we get an error message. And we know that rows 4 and 272 are the offenders. 

We can also use verify to check numeric values. 

```r
penguins %>%
  verify(bill_length_mm > 30 & bill_length_mm < 60) %>%
  verify(flipper_length_mm >= 170 & flipper_length_mm <= 240) %>%
  verify(body_mass_g >= 2500 & body_mass_g <= 7000)
```

You might notice that only the first verify() line of code ran, which is intentional. Verify will terminate the pipeline as soon as there is an error. This is helpful because we can build verify into our pipelines when wrangling data. 

We can also check for the same errors with assert()

```r
penguins |>
  assert(within_bounds(30, 60), bill_length_mm)
```

## Assert

