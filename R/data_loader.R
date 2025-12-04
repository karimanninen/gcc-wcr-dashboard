# ============================================================================
# DATA LOADER MODULE
# ============================================================================
# This module handles all data loading for the WCR dashboard.
# Currently loads from local R objects / Excel files.
# Future: Replace with Fusion Registry SDMX API calls.
# ============================================================================

library(dplyr)
library(tidyr)

# ============================================================================
# MAIN DATA LOADING FUNCTION
# ============================================================================

#' Load WCR Data
#' 
#' Currently: Loads from embedded data or local files
#' Future: Will pull from Fusion Registry via SDMX API
#' 
#' @return List containing all WCR datasets
load_wcr_data <- function() {
  
  # -------------------------------------------------------------------------
  # OPTION 1: Embedded data (current default)
  # -------------------------------------------------------------------------
  
  WCR_data <- list()
  
  # GDP Weights (2024, USD billions)
  WCR_data$gdp_weights <- data.frame(
    Country = c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Oman", "Kuwait"),
    GDP_2024 = c(552.3, 219.2, 1085.4, 46.9, 109.7, 160.2),
    stringsAsFactors = FALSE
  )
  
  # Overall Rankings 2020-2025
  WCR_data$overall_rankings <- data.frame(
    Country = rep(c("UAE", "Saudi Arabia", "Qatar", "Bahrain", "Kuwait", "Oman"), each = 6),
    Year = rep(2020:2025, 6),
    Overall_Rank = c(
      9, 9, 12, 10, 7, 5,      # UAE
      24, 32, 24, 17, 16, 17,  # Saudi Arabia
      14, 17, 18, 12, 11, 9,   # Qatar
      NA, NA, 30, 25, 21, 22,  # Bahrain (joined 2022)
      NA, NA, NA, 38, 37, 36,  # Kuwait (joined 2023)
      NA, NA, NA, NA, NA, 28   # Oman (joined 2025)
    ),
    stringsAsFactors = FALSE
  )
  
  # Main Factor Scores 2025
  WCR_data$factors_2025 <- data.frame(
    Country = c("UAE", "Saudi Arabia", "Qatar", "Bahrain", "Kuwait", "Oman"),
    Year = 2025,
    Overall_Rank = c(5, 17, 9, 22, 36, 28),
    Overall_Score = c(96.09, 82.09, 89.93, 76.56, 68.69, 72.86),
    EconPerf_Rank = c(2, 17, 7, 18, 43, 48),
    EconPerf_Score = c(79.64, 62.29, 69.53, 61.10, 49.60, 48.63),
    GovEff_Rank = c(4, 17, 7, 28, 19, 16),
    GovEff_Score = c(87.28, 69.26, 82.88, 57.73, 67.26, 69.97),
    BusEff_Rank = c(3, 12, 5, 14, 31, 21),
    BusEff_Score = c(92.55, 81.40, 91.41, 78.13, 56.86, 65.72),
    Infra_Rank = c(23, 31, 30, 36, 43, 38),
    Infra_Score = c(69.00, 59.50, 60.00, 53.38, 45.14, 51.21),
    stringsAsFactors = FALSE
  )
  
  # Add GDP weights to factors
  WCR_data$factors_2025 <- WCR_data$factors_2025 %>%
    left_join(WCR_data$gdp_weights, by = "Country")
  
  # Calculate GCC Aggregates
  gcc_simple <- WCR_data$factors_2025 %>%
    summarise(
      Country = "GCC (Simple)",
      Year = 2025,
      Overall_Rank = mean(Overall_Rank),
      Overall_Score = mean(Overall_Score),
      EconPerf_Rank = mean(EconPerf_Rank),
      EconPerf_Score = mean(EconPerf_Score),
      GovEff_Rank = mean(GovEff_Rank),
      GovEff_Score = mean(GovEff_Score),
      BusEff_Rank = mean(BusEff_Rank),
      BusEff_Score = mean(BusEff_Score),
      Infra_Rank = mean(Infra_Rank),
      Infra_Score = mean(Infra_Score),
      GDP_2024 = sum(GDP_2024)
    )
  
  gcc_weighted <- WCR_data$factors_2025 %>%
    summarise(
      Country = "GCC (Weighted)",
      Year = 2025,
      Overall_Rank = weighted.mean(Overall_Rank, GDP_2024),
      Overall_Score = weighted.mean(Overall_Score, GDP_2024),
      EconPerf_Rank = weighted.mean(EconPerf_Rank, GDP_2024),
      EconPerf_Score = weighted.mean(EconPerf_Score, GDP_2024),
      GovEff_Rank = weighted.mean(GovEff_Rank, GDP_2024),
      GovEff_Score = weighted.mean(GovEff_Score, GDP_2024),
      BusEff_Rank = weighted.mean(BusEff_Rank, GDP_2024),
      BusEff_Score = weighted.mean(BusEff_Score, GDP_2024),
      Infra_Rank = weighted.mean(Infra_Rank, GDP_2024),
      Infra_Score = weighted.mean(Infra_Score, GDP_2024),
      GDP_2024 = sum(GDP_2024)
    )
  
  WCR_data$factors_2025 <- bind_rows(
    WCR_data$factors_2025, 
    gcc_simple, 
    gcc_weighted
  )
  
  # World Rankings 2025 (All 69 countries)
  WCR_data$world_rankings_2025 <- data.frame(
    Rank = 1:69,
    Country = c(
      "Switzerland", "Singapore", "Hong Kong SAR", "Denmark", "UAE",
      "Taiwan", "Ireland", "Sweden", "Qatar", "Netherlands",
      "Canada", "Norway", "USA", "Finland", "Iceland", 
      "China", "Saudi Arabia", "Australia", "Germany", "Luxembourg",
      "Lithuania", "Bahrain", "Malaysia", "Belgium", "Czech Republic",
      "Austria", "Korea Rep.", "Oman", "United Kingdom", "Thailand",
      "New Zealand", "France", "Estonia", "Kazakhstan", "Japan",
      "Kuwait", "Portugal", "Latvia", "Spain", "Indonesia",
      "India", "Chile", "Italy", "Cyprus", "Puerto Rico",
      "Slovenia", "Jordan", "Hungary", "Romania", "Greece",
      "Philippines", "Poland", "Croatia", "Colombia", "Mexico",
      "Kenya", "Bulgaria", "Brazil", "Botswana", "Peru",
      "Ghana", "Argentina", "Slovak Republic", "South Africa", "Mongolia",
      "Türkiye", "Nigeria", "Namibia", "Venezuela"
    ),
    Score = c(
      100.00, 99.44, 99.22, 97.51, 96.09,
      93.71, 91.31, 90.20, 89.93, 89.75,
      88.73, 86.17, 84.27, 83.83, 83.49,
      82.13, 82.09, 78.36, 78.24, 78.17,
      77.68, 76.56, 74.81, 74.57, 73.66,
      73.55, 73.39, 72.86, 71.95, 71.32,
      70.23, 69.93, 69.65, 68.99, 68.74,
      68.69, 67.84, 67.03, 65.80, 64.32,
      64.19, 62.52, 62.50, 61.80, 61.03,
      59.14, 57.79, 56.71, 56.64, 55.33,
      54.88, 53.91, 51.19, 49.66, 48.84,
      48.29, 47.96, 46.41, 46.12, 45.89,
      44.25, 42.84, 42.79, 41.98, 40.91,
      40.41, 39.73, 37.48, 25.47
    ),
    stringsAsFactors = FALSE
  ) %>%
    mutate(
      Region = case_when(
        Country %in% c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Oman", "Kuwait") ~ "GCC Member",
        TRUE ~ "Other"
      )
    )
  
  # Add GCC aggregates to world rankings
  gcc_aggregate_world <- data.frame(
    Rank = NA,
    Country = c("GCC (Simple)", "GCC (Weighted)"),
    Score = c(
      WCR_data$factors_2025$Overall_Score[WCR_data$factors_2025$Country == "GCC (Simple)"],
      WCR_data$factors_2025$Overall_Score[WCR_data$factors_2025$Country == "GCC (Weighted)"]
    ),
    Region = "GCC Aggregate",
    stringsAsFactors = FALSE
  )
  
  WCR_data$world_rankings_with_gcc <- bind_rows(
    WCR_data$world_rankings_2025,
    gcc_aggregate_world
  ) %>%
    arrange(desc(Score)) %>%
    mutate(Rank = row_number())
  
  # 5-Year Factor Rankings
  WCR_data$rankings_5yr <- data.frame(
    Country = rep(c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Kuwait", "Oman"), each = 5),
    Factor = rep(c("Overall", "Econ Perf", "Gov Eff", "Bus Eff", "Infra"), 6),
    Y2021 = c(
      9, 30, 3, 8, 28,     # UAE
      17, 6, 6, 15, 40,    # Qatar
      32, 24, 26, 15, 36,  # Saudi Arabia
      NA, NA, NA, NA, NA,  # Bahrain
      NA, NA, NA, NA, NA,  # Kuwait
      NA, NA, NA, NA, NA   # Oman
    ),
    Y2022 = c(
      12, 15, 17, 6, 26,   # UAE
      18, 7, 7, 14, 38,    # Qatar
      24, 19, 16, 9, 34,   # Saudi Arabia
      30, 39, 20, 24, 39,  # Bahrain
      NA, NA, NA, NA, NA,  # Kuwait
      NA, NA, NA, NA, NA   # Oman
    ),
    Y2023 = c(
      10, 36, 16, 4, 26,   # UAE
      12, 4, 4, 12, 33,    # Qatar
      17, 11, 13, 6, 34,   # Saudi Arabia
      25, 23, 20, 22, 37,  # Bahrain
      38, 19, 42, 42, 49,  # Kuwait
      NA, NA, NA, NA, NA   # Oman
    ),
    Y2024 = c(
      7, 11, 10, 2, 25,    # UAE
      11, 4, 4, 11, 33,    # Qatar
      16, 12, 12, 4, 34,   # Saudi Arabia
      21, 18, 21, 16, 39,  # Bahrain
      37, 31, 36, 36, 46,  # Kuwait
      NA, NA, NA, NA, NA   # Oman
    ),
    Y2025 = c(
      5, 2, 4, 3, 23,      # UAE
      9, 7, 7, 5, 30,      # Qatar
      17, 17, 17, 12, 31,  # Saudi Arabia
      22, 18, 28, 14, 36,  # Bahrain
      36, 43, 19, 31, 43,  # Kuwait
      28, 48, 16, 21, 38   # Oman
    ),
    stringsAsFactors = FALSE
  )
  
  # Country colors (official GCC country palette)
  WCR_data$country_colors <- c(
    "UAE" = "#000000",
    "Qatar" = "#99154C",
    "Saudi Arabia" = "#008035",
    "Bahrain" = "#E20000",
    "Oman" = "#a3a3a3",
    "Kuwait" = "#00B1E6",
    "GCC (Simple)" = "#B8A358",
    "GCC (Weighted)" = "#1a5276",
    "GCC Aggregate" = "#B8A358",
    "GCC Member" = "#2980b9",
    "Other" = "#bdc3c7"
  )
  
  return(WCR_data)
}


# ============================================================================
# FUTURE: FUSION REGISTRY LOADER
# ============================================================================

#' Load WCR Data from Fusion Registry (PLACEHOLDER)
#' 
#' @param base_url Fusion Registry base URL
#' @param dataflow Dataflow ID for WCR data
#' @return List containing all WCR datasets
#' 
load_wcr_data_fusion <- function(
    base_url = "https://fusion.gccstat.org/sdmx/v2",
    dataflow = "WCR_GCC"
) {
  
  # Placeholder for future implementation
  # 
  # library(rsdmx)
  # 
  # # Query individual country scores
  # country_data <- readSDMX(paste0(
  #   base_url, "/data/", dataflow, 
  #   "/A.ARE+BHR+KWT+OMN+QAT+SAU.ALL.ALL"
  # ))
  # 
  # # Query GCC aggregates
  # gcc_data <- readSDMX(paste0(
  #   base_url, "/data/", dataflow, "_AGG",
  #   "/A.GCC.ALL.ALL"
  # ))
  # 
  # # Transform to expected format
  # WCR_data <- transform_sdmx_to_wcr(country_data, gcc_data)
  # 
  # return(WCR_data)
  
  stop("Fusion Registry integration not yet implemented. Use load_wcr_data() instead.")
}


# ============================================================================
# HELPER: Transform overall rankings to trajectory format
# ============================================================================

#' Get trajectory data for line chart
#' @param wcr_data WCR data list
#' @return Data frame in long format for trajectory plotting
get_trajectory_data <- function(wcr_data) {
  
  trajectory <- wcr_data$overall_rankings %>%
    filter(Year >= 2021) %>%
    filter(!is.na(Overall_Rank))
  
  # Calculate GCC average by year
  gcc_avg <- trajectory %>%
    group_by(Year) %>%
    summarise(
      Overall_Rank = mean(Overall_Rank, na.rm = TRUE),
      .groups = "drop"
    ) %>%
    mutate(Country = "GCC Average")
  
  bind_rows(trajectory, gcc_avg)
}


# ============================================================================
# HELPER: Get dimension comparison data
# ============================================================================

#' Get dimension scores for GDP-weighted GCC
#' @param wcr_data WCR data list
#' @return Data frame with dimension scores
get_dimension_data <- function(wcr_data) {
  
  wcr_data$factors_2025 %>%
    filter(Country == "GCC (Weighted)") %>%
    select(
      Overall = Overall_Score,
      `Economic Performance` = EconPerf_Score,
      `Government Efficiency` = GovEff_Score,
      `Business Efficiency` = BusEff_Score,
      Infrastructure = Infra_Score
    ) %>%
    pivot_longer(
      cols = everything(),
      names_to = "Dimension",
      values_to = "Score"
    ) %>%
    mutate(
      Gap = 100 - Score,
      Dimension = factor(Dimension, levels = c(
        "Infrastructure", "Economic Performance", 
        "Government Efficiency", "Business Efficiency", "Overall"
      ))
    )
}
