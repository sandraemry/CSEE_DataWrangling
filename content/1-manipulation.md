---
layout: default
title: Data Manipulation
nav: Manipulation
permalink: /manipulation/
---

Before we can begin to analyse our data, we often need to re-format our data to get into the right 'shape' for computers to read. Often humans enter data that is readable by us, but this format is not readable by computers. 

Click here to find the [slides](https://docs.google.com/presentation/d/1n3HJEGCP1tk4_XDXmdY8GalbZSj6kgko6MwzW2BwC5M/edit?usp=sharing) that we went through at the start of the workshop.

### Basics

**Getting data into R**  

I prefer to use `read_csv` from `readr` package as it ... but many prefer to use read.csv instead. There are many ways of achieving the same thing in R so don't feel like you need to change what you're doing if it works for you!
Whichever function you use, refrain from reading in data with a 'point and click' method, as this is not reproducible, and can't be easily used by someone else who wants to be able to run your code. 

If you are reading in your own file, you could do so with the following code. Make sure you change the file path and file name.  
```r
data  <- read_csv("./00_rawdata/rawdatafile.csv")
```

For the first part of our workshop, we are going to use the data from the `palmerpenguins` package. You can access the dataset by typing `penguins`
```r 
library(palmerpenguins)
```

**Getting to know your data**

Their are lots of functions that help you learn about your data. Here are a few that I often use:  
Here are two great functions, one from `dplyr` and one from base R, to see which variables you have in your dataset, and the structure for each 
```r
glimpse(penguins)
str(penguins)
```

You can also view parts of your dataset: 
```r
head(penguins)
tail(penguins)
penguins[1:20, ]
```

And learn the dimensions of your data: 
```r
nrow(penguins)
ncol(penguins)
dim(penguins)
```

### Wrangling 

#### Subsetting

If you want to work with only a few columns, you can use `select` to retain only the named columns like so: 
```r 
penguins |> select(species, island, bill_length_mm, bill_depth_mm)
```

It's important to note that we didn't save this subsetted dataset in our global environment yet. We would need to do so like this: 

```r
penguin_subset <- penguins |> select(species, island, bill_length_mm, bill_depth_mm)
```

You can also subset by excluding named columns: 

```r 
penguins |> select(-c(sex, year))
```

Or by selecting columns that follow one another like this:  

```r 
penguins |> select(species:body_mass_g)
```

Using select will always give you a dataframe with the same number of rows, but fewer columns. 

Alternatively, we also subset our data with the function `filter`. This function only keeps certain rows based on the criteria we provide. For example, we can keep only the data containing female penguins: 

```r
penguins_female <- pengions |> filter(sex == "female")
```

Or we can only keep penguins with a bill length greater than 40 mm 
```r
penguins_female |> filter(bill_length_mm > 40)
```

Filter will always give you a dataframe with fewer rows, but the same number of columns. 


#### Summarizing

**grouping**

In the previous step we filtered based off an arbitrary number (40 mm), but let's say we wanted to filter based on the mean bill length of females. We can first calculate the mean bill length of both males and females by grouping our data into two (male and female) and then summarizing the data.

```r
penguins |> 
  group_by(sex) |> 
  summarise(mean_bill_length_mm = mean(bill_length_mm))
```

#### Manipulating

**mutate**

**pivots**

**separate and unite**

**joins**





