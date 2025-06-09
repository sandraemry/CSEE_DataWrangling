---
title: Workshop Prep
nav: Prep
permalink: /prep/
---


This workshop assumes a basic knowledge of R and R Studio, but don't fret if you need a refresher. We will have tech support to help during the workshop. 

To prepare for your Data Wrangling 101 workshop at this year's CSEE meeting, please ensure that you have the most recent versions of R and RStudio installed (or as recent as your operating system will allow).

**Current versions**  
**R** is currently on version 4.5.1 ("Great Square Root")  
**RStudio** is currently on version 2025.05.1+513 

**Check which versions you're running** 

To check which version of RStudio you have:  
- Open RStudio  
- In the toolbar, select RStudio > About RStudio  
- You should have RStudio version 1.4 or higher 
  
To check which version of R you have:  
- Open RStudio  
- See the first line of the welcome message in your console, or run the command sessionInfo()  
- You should have R version 4.0 or higher  

**Installing R and R Studio** 

If you don't already have R and RStudio installed, or don't have the most recent versions, you can download them from:  
- [Download R](https://mirror.csclub.uwaterloo.ca/CRAN/)  
- [Download RStudio](https://posit.co/download/rstudio-desktop/)  

> *Tip:* Downloading RStudio does not download R. You will need to install both.  

Basic familiarity with R Studio's interface will be helpful. For a refresher, check out... [page](link)

Be sure to read the relevant download and installation instructions for your operating system (Windows, Mac OS, Linux).      

**Packages to install**
These packages can be installed by typing into RStudio's console: `install packages("packagename")`.  
* `tidyverse` (This is a suite of packages which can be installed together by `install.packages("tidyverse")`. If you are running into issues with this, you can alternatively install these packages separately:  
  * `ggplot2`  
  * `dplyr`  
  * `tidyr`  
  * `readr`  
  * `stringr`  
  * `lubridate`  
  * `purrr`  
  * `forcats`  
* `palmerpenguins`  
* `assertr`  
* `lubridate`  

### Workshop structure

There are three main sections to the workshop. We will first learn some common packages and functions to manipulate, or 'wrangle' data using the `gapminder` data set. We will then move on to learning some common data validation techniques. The last section of the workshop involves applying our newly learned skills to a real dataset. Please feel free to bring your own dataset to work on. If you haven't collected your own data yet (or you collected it in a tidy format!), think about asking your supervisor if they have some messy data that needs to be cleaned! Alternatively, we will have a messy data set on hand for participants to work with. 

{% include card.html 
   header="Setup Overview"
   text="
1. Have R installed  
2. Have R Studio installed  
3. Download relevant packages  
4. *Optional:* Bring a messy data set from your own, or your supervisor's, research to work on  
" %}







