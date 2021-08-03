# Packages and prep =======================================================================================
library(tidyverse)
library(scales)
library(ragg)
library(hrbrthemes)
library(tidytuesdayR)
devtools::install_github('rensa/ggflags')

showtext::showtext_auto()

# Data ====================================================================================================
tt_data <- tidytuesdayR::tt_load(2021, week = 31)
olympics <- tt_data$olympics

GB <- olympics %>%
  filter(team == 'Great Britain', season == "Summer", medal != "NA") %>%
  distinct(year, event, .keep_all = TRUE) %>% # This makes team sports count as one medal
  group_by(year, medal) %>%
  summarise(freq = n()) %>%
  mutate(medal = as.factor(medal))

# Visualisation ===========================================================================================

