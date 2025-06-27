---
title: Data Manipulation
nav: Manipulation
permalink: /manipulation/
---

Before we can begin to analyse our data, we often need to re-format our data to get into the right 'shape' for computers to read. Often humans enter data that is readable by us, but this format is not readable by computers. 

👉 [Slides from the workshop](https://docs.google.com/presentation/d/1n3HJEGCP1tk4_XDXmdY8GalbZSj6kgko6MwzW2BwC5M/edit?usp=sharing)

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

Learn the dimensions of your data: 
```r
nrow(penguins)
```

```r
ncol(penguins)
```

```r
dim(penguins)
```

You can also view parts of your dataset: 
```r
head(penguins)
```

```r
tail(penguins)
```

```r
penguins[1:20, ]
```

```r
print(penguins)
```

```r
print(penguins, n = 20)
```

Here are two great functions, one from `dplyr` and one from base R, to see which variables you have in your dataset, and the structure for each 
```r
glimpse(penguins)
str(penguins)
```

An aside: a bit about factors vs strings
```r
x <- c("May", "July", "June", "August")
str(x)
sort(x)
```

Sorting alphabetically - is this useful?


Let's make 'x' a factor and tell R what the order should be 
```r
x <- factor(x, levels = c("May", "June", "July", "August"))
str(x)
sort(x)
```
Now we see it's a factor and it sorts properly. This can be very helpful when plotting and fitting models (e.g. especially when you have a control treatment)

Now back to penguins...

Before we can wrangle, let's learn what the pipe is all about. There are two pipes in r and you can use either: %>% or |> 
There is a keyboard shortcut for the pipe so you don't have to type it out each time, for Macs: Cmd + Shift + M and on windows: Ctrl + Shift + M

############### PIPE ############### 
A children's poem: 
Little bunny Foo Foo
Went hopping through the forest
Scooping up the field mice
And bopping them on the head

We could code this poem by nesting each function, which means to understand it we need to read from the inside out. This can get complicated quick!
```r
bop(scoop(hop(foo_foo, through = forest), up = field_mice), on = head)
```

Or we can save each step as an intermediary and using it in the next step like so: 
```r
foo_foo_1 <- hop(foo_foo, through = forest)
foo_foo_2 <- scoop(foo_foo_1, up = field_mice)
foo_foo_3 <- bop(foo_foo_2, on = head)
```
Alternatively, we could use the pipe! I like to think of this as before vs after. The product from **before** the pipe gets squished through the pipe and the function **after** the pipe is performed on this product. 
```r
foo_foo %>%
  hop(through = forest) %>%
  scoop(up = field_mouse) %>%
  bop(on = head)
```

We are going to use this pipe for the remainder of the workshop. 

### Wrangling 

#### Subsetting

##### Select 

The function select is always going to return the same number of rows but fewer columns. If you want to work with only a few columns, you can use `select` to retain only the named columns like so: 
```r
penguins |> 
  select(species, sex, bill_length_mm)
```

Note that we didn't save this subsetted dataset in our global environment yet. We would need to do so like this: 
**Tip**: Never overwrite the original DF 
```r
penguins_select <- penguins |> 
  select(species, sex, bill_length_mm)
```

Use : to select many consecutive cols at once 
```r
penguins |> 
  select(species:body_mass_g)
```

You can also subset by excluding named columns: 
```r 
penguins |> 
  select(!c(body_mass_g))
```
 Other ways to subset: 
```r 
penguins |> 
  select(starts_with("bill"))

penguins |> 
  select(where(is.numeric))
```

##### Filter 

Alternatively, we also subset our data with the function `filter`. This function only keeps certain rows based on the criteria we provide. Filter will always give you a dataframe with fewer rows, but the same number of columns. 

For example, we can keep only the data containing female penguins: 

```r
penguins_female <- pengions |> filter(sex == "female")
```

Or we can only keep penguins with a numeric column greater or smaller than a certain number 
```r
penguins_female |> filter(bill_length_mm > 40)

penguins |> 
  filter(bill_depth_mm > 19 & bill_depth_mm <= 20)
```

```r
penguins |> 
  filter(species %in% c("Chinstrap", "Gentoo")) 
```

Note that there are still three levels in the factor though. Also here's the first time we have more than 1 pipe!
```r
penguins |> 
  filter(species %in% c("Chinstrap", "Gentoo")) |> 
  str()  
```
##### Mutate
Mutate will return the same number of rows with additional columns, by using certain columns to calculate new columns.

For exampls, let's calculate the ratio of bill length to bill depth 
```r
penguins |> 
  mutate(length_depth_ratio = bill_length_mm/bill_depth_mm)
```
##### Arrange

Arrange will order rows based on values of selected columns. 

The default is to sort from smallest to largest, but we can change this with 'desc'
```r
penguins |> 
  arrange(bill_length_mm)

penguins |> 
  arrange(desc(bill_length_mm))
```

We can also sort by multiple columns. 
```r
penguins |> 
  arrange(sex, year, species, island) 
```

##### Summarizing

**grouping**

In the previous step we filtered based off an arbitrary number (40 mm), but let's say we wanted to filter based on the mean bill length of females. We can first calculate the mean bill length of both males and females by grouping our data into two (male and female) and then summarizing the data.

```r
penguins |> 
  group_by(sex) |> 
  summarise(mean_bill_length_mm = mean(bill_length_mm, na.rm = T))
```
Summarize will always return less rows and columns. The number of rows will be equivalent to your grouping, the number of columns will be equivalent to the number of variables used to grouped and summary data calculated.

Sometimes you might want to add your calculated row to the same DF, i.e.g not get rid of any rows. For example, if we wanted to filter based on the mean value that we just calculated. We can group_by and mutate instead. 

```r
penguins |> 
  group_by(sex) |> 
  mutate(mean_bill_length_mm = mean(bill_length_mm, na.rm = T)) |> 
  filter(bill_length_mm > mean_bill_length_mm)
```

##### Tally 
Tally can be very useful when wrangling and summarizing data but also in data validation (more on this later).

```r
penguins |> 
  group_by(species) |> 
  tally()

penguins |> 
  group_by(species) |> 
  add_tally()
```

##### Rename

```r
penguins |> 
  group_by(species) |> 
  add_tally() |> 
  rename(sample_size = n)
```

##### Separate and Unite

I often use these two verbs to create new columns from existing columns. For example, if we wanted to separate the column 'Species' into two columns in the penguin_raw dataframe. 
```r
pen_unite <- penguins |> 
  unite("species_island", c("species", "island"), sep = "_", remove = T)
```

```r
pen_unite |> 
  separate(col = "species_island", into = c("species", "island"), sep = "_", remove = F)
```

##### Joins
Joins are incredibly helpful in combining more than one dataframe. There are two kinds of join: mutating joins that add columns and filtering joins that filter rows based on presence/absence of matches 
Let's use these two small tibble that are already available to you if you loaded either tidyverse or dplyr. 

```r
band_members
band_instruments
```

First let's use left_join which is a very commonly used mutating join. Here we are going to add columns to the 'x' dataframe from the 'y' dataframe. 
```r
left_join(x = band_members, y = band_instruments, by = "name")
```

Alternatively, semi_join is a filtering join which will only retain the rows in 'x' that have matches in 'y'
```r
semi_join(x = band_members, y = band_instruments, by = "name")
```

Here's a slightly more complicated example to make sure the joins make sense. For this we are going to use the `Lahman` package which is a relational database with stats for Major League Baseball. 

```r
library(Lahman)

head(Batting)
dim(Batting)

head(People)
dim(People)
```

Each of these dataframes have 'playerID' in common. So let's add the additional information about each player to the batting dataframe. 
How many columns and rows do you expect the resulting df to have?
```
left_join(x = Batting, y = People, by = "playerID") |> dim()
```
It should have the same number of rows from Batting. 

What's happening here? How many rows and columns do we expect here?
```
players <- People %>%
  filter(playerID %in% c("ruthba01", "bondsba01", "troutmi01")) %>%
  select(playerID, nameFirst, nameLast)

left_join(players, Batting, by = "playerID") |> dim()
```

It's helpful to tell R what you are expecting, and R wiill tell you if you are wrong!
```r
left_join(players, Batting, by = "playerID", relationship = "one-to-one")
```

##### Pivots

Often we will enter data, or receive data, in wide format and we need to convert it to long format. We can switch between the two formats with pivot_wider and pivot_longer. 

Let's use the `billboard` dataset from the `tidyr` package. 
```r
billboard |> 
  pivot_longer(cols = wk1:wk76, names_to = "week_no", values_to = "rank")
  
billboard_long <- billboard |> 
  pivot_longer(cols = starts_with("wk"), names_to = "week_no", values_to = "rank")
  
```

Revert back to wide format: 

```r
billboard_long |> 
  pivot_wider(names_from = "week_no", values_from = "rank")
```

##### Dates
Let's move on my arch nemesis - dates. The lubridate package is the best package I have found for dealing with dates. 

```r
dates <- c("20-06-2025", "15/07/2024", "01.01.2023")
```

Tell R what format(s) to expect. 

```r
parsed_dates <- dmy(dates)
parsed_dates
```

Note: the result is standardized to ISO 8601 format (yyyy-mm-dd) internally, which is perfect for analysis and plotting.

What if we have mixed formats? 
```r
dates <- c("2025-06-20",    # ISO format
           "6/20/25",       # US style mm/dd/yy
           "20-06-2025",    # European style dd-mm-yyyy
           "June 20, 2025", # Long-form
           "20250620",      # Compact ISO
           "20th June 2025") # Human-readable

parsed_dates <- parse_date_time(dates,
                                orders = c("ymd", "mdy", "dmy", "B d, Y", "Ymd", "d B Y"))

parsed_dates
```

Explanation of orders codes:

"ymd" → 2025-06-20

"mdy" → 6/20/25

"dmy" → 20-06-2025

"B d, Y" → June 20, 2025 (B = full month name)

"Ymd" → 20250620 (compact)

"d B Y" → 20th June 2025 (works even with “20th”)

