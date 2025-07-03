library(palmerpenguins)
library(dplyr)
library(stringr)

set.seed(42)  # For reproducibility

messy_penguins <- penguins %>%
  mutate(
    # Introduce misplaced decimal in flipper_length_mm (e.g., 198 -> 1980)
    flipper_length_mm = case_when(
      row_number() %% 15 == 0 & !is.na(flipper_length_mm) ~ flipper_length_mm * 10,
      TRUE ~ flipper_length_mm
    ),
    
    # Introduce negative body masses
    body_mass_g = case_when(
      row_number() %% 20 == 0 & !is.na(body_mass_g) ~ -body_mass_g,
      TRUE ~ body_mass_g
    ),
    
    # Corrupt some year values
    year = case_when(
      row_number() == 5 ~ as.character(20077),
      row_number() == 10 ~ "2007-12-15",
      row_number() == 15 ~ "07/15/2008",
      TRUE ~ as.character(year)
    ),
    
    # Illogical bill_length_mm values (shorter than depth)
    bill_length_mm = case_when(
      row_number() %% 18 == 0 & !is.na(bill_depth_mm) ~ bill_depth_mm - 1,
      TRUE ~ bill_length_mm
    ),
    
    # Spelling errors in species
    species = case_when(
      row_number() %% 12 == 0 ~ "Adeliee",
      row_number() %% 13 == 0 ~ "Gentto",
      TRUE ~ species
    ),
    
    # Spelling errors in island
    island = case_when(
      row_number() %% 17 == 0 ~ "Dreamm",
      TRUE ~ island
    ),
    
    # Spelling errors in sex
    sex = case_when(
      row_number() %% 14 == 0 ~ "femlae",
      row_number() %% 16 == 0 ~ "mael",
      TRUE ~ sex
    )
  )

head(messy_penguins, 20)

# Optionally write to CSV
write.csv(messy_penguins, "./content/data/messy_penguins.csv", row.names = FALSE)

messy_penguins
