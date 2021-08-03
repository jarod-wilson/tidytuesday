# Packages and prep =======================================================================================
library(tidyverse)
library(scales)
library(ragg)
library(hrbrthemes)
library(tidytuesdayR)

showtext::showtext_auto()

# Data ====================================================================================================
tt_data <- tidytuesdayR::tt_load(2021, week = 31)
olympics <- tt_data$olympics

sex_count <- olympics %>%
  filter(season %in% "Summer") %>%
  group_by(year) %>%
  count(sex)

sex_percent <- sex_count %>%
  group_by(year) %>%
  mutate(percent = 100 * n / sum(n)) %>%
  ungroup

# Visualisation ===========================================================================================
p <- 
  ggplot(data = sex_percent, mapping = aes(year, percent)) +
  geom_col(aes(fill = sex), color = NA) +
  scale_fill_manual(values = c("M" = "#225599", "F" = "#F49429")) +
  geom_hline(yintercept = 50, color = "gray81", linetype = "dashed", size = 0.7) +
  scale_y_continuous(labels = scales::unit_format(unit = "%")) +
  scale_x_continuous(n.breaks = 10) +
  theme_ft_rc(axis_text_size = 30) +
  theme(
    legend.title = element_blank(),
    legend.text = element_text(color = "gray81", size = 40),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title = element_text(color = "gray81", size = 40),
    axis.text = element_text(color = "gray81"),
    plot.caption = element_text(color = "gray81", family = "Roboto Condensed", size = 30),
    plot.title = element_text(color = "white", family = "Roboto Condensed", hjust = 0.5, size = 40)
  ) +
  labs(
    y = "",
    x = "",
    title = "Proportion of Male and Female Athletes in the Summer Olympics",
    caption = "#TidyTuesday | Source: Kaggle"
  )

agg_png(filename = paste0("TT-W31a.png"), width = 40, height = 25, units = 'cm', res = 180)
print(p)
dev.off()

