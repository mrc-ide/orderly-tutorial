orderly_resource("wuenic.xlsx")
orderly_artefact(
  files = "wuenic.rds",
  description = "Tidied WUENIC data")
orderly_artefact(
  files = "corr_out.rds",
  description = "Output correlations between WUENIC and OFFICIAL coverage")
# -------------------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(readxl)
library(janitor)

df <- read_xlsx("wuenic.xlsx")

# Question: is there better agreement in coverage estimates for BCG or YF

# some cleaning
df <- df %>% clean_names()
df <- df %>% mutate(across(starts_with("x"),
                           .fns = function(inp) as.numeric(gsub("%", "", inp))))
df <- df %>% mutate(all_na_coverage = if_all(starts_with("x"), is.na))

# quick visual for 2023
df %>%
  filter(!is.na(antigen)) %>%
  filter(country_region %in% c("Nigeria", "Senegal", "Kenya", "Ghana")) %>%
  ggplot() +
  aes(x = country_region, y = x2023,  fill = category) +
  geom_col(position = "dodge") +
  facet_wrap(antigen ~ ., ncol = 1) +
  theme_minimal() +
  labs(x = "Country", y = "Coverage in 2023", fill = "Coverage type")

# get correlations per vaccine and country
get_ma_corr <- function(df, country_reg_in = "Afghanistan",
                        antigen_in = "Yellow fever vaccine") {
  df_subset <- df %>% filter(country_region %in% country_reg_in,
                             antigen %in% antigen_in)

  cor(t(df_subset[df_subset$category %in% "WUENIC", grep("^x", names(df))]),
      t(df_subset[df_subset$category %in% "OFFICIAL", grep("^x", names(df))]),
      use = "na.or.complete")
}

df_out <- data.frame(country = unique(df$country_region))
df_out$YF_cor <- sapply(df_out$country, function(x) get_ma_corr(df, x))
df_out$BCG_cor <- sapply(df_out$country, function(x) get_ma_corr(df, x, "BCG"))

# get a nice figure
p <- df_out %>%
  mutate(cor_diff = as.numeric(BCG_cor) - as.numeric(YF_cor)) %>%
  filter(!is.na(cor_diff)) %>%
  mutate(pos_neg = cor_diff > 0) %>%
  ggplot() +
  aes(x = reorder(country, cor_diff), y = cor_diff, fill = pos_neg) +
  geom_col() +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x = "Country", y = "Difference in correlation",
       fill = "BCG has better \nagreement between \nWUENIC and OFFICIAL \ncoverage than YF") +
  scale_fill_manual(values = c("yellow", "pink")) +
  ggtitle("Yellow fever vaccination coverage has better agreement between WUENIC and OFFICIAL estimates in more countries than BCG")

# save everything
ggsave(plot = p, filename = "BCG_YF_correlation_comparison.png",
       width = 14, height = 8)
saveRDS(df, "wuenic.rds")
saveRDS(df_out, "corr_out.rds")
