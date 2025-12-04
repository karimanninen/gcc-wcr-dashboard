# ============================================================================
# CHARTS MODULE
# ============================================================================
# All Plotly chart functions for the WCR Scrollytelling Dashboard
# ============================================================================

library(plotly)
library(dplyr)
library(tidyr)
library(scales)

# ============================================================================
# CHART 1: WORLD RANKING BAR CHART (ALL COUNTRIES WITH SLIDER)
# ============================================================================

#' Create World Ranking Chart
#' Shows all countries with GCC aggregate inserted, with range slider
#' 
#' @param wcr_data WCR data list
#' @param gcc_method Either "GCC (Weighted)" or "GCC (Simple)"
#' @return Plotly object
create_world_ranking_chart <- function(wcr_data, gcc_method = "GCC (Weighted)") {
  
  # GCC country colors
  gcc_colors <- c(
    "UAE" = "#000000",
    "Qatar" = "#99154C",
    "Saudi Arabia" = "#008035",
    "Bahrain" = "#E20000",
    "Oman" = "#a3a3a3",
    "Kuwait" = "#00B1E6"
  )

  # Get GCC aggregate score
  gcc_score <- wcr_data$factors_2025 %>%
    filter(Country == gcc_method) %>%
    pull(Overall_Score)
  
  # Create GCC aggregate row
  gcc_aggregate <- data.frame(
    Rank = NA,
    Country = gcc_method,
    Score = gcc_score,
    Region = "GCC Aggregate",
    stringsAsFactors = FALSE
  )
  
  # Combine all data
  plot_data <- bind_rows(wcr_data$world_rankings_2025, gcc_aggregate) %>%
    arrange(desc(Score)) %>%
    mutate(
      Rank = row_number(),
      display_name = case_when(
        Country == "GCC (Weighted)" ~ "GCC (GDP-Weighted)",
        Country == "GCC (Simple)" ~ "GCC (Simple Avg)",
        TRUE ~ Country
      ),
      # Assign colors: GCC countries get their specific colors, aggregate gets gold, others grey
      color = case_when(
        Country == "UAE" ~ gcc_colors["UAE"],
        Country == "Qatar" ~ gcc_colors["Qatar"],
        Country == "Saudi Arabia" ~ gcc_colors["Saudi Arabia"],
        Country == "Bahrain" ~ gcc_colors["Bahrain"],
        Country == "Oman" ~ gcc_colors["Oman"],
        Country == "Kuwait" ~ gcc_colors["Kuwait"],
        Region == "GCC Aggregate" ~ "#B8A358",
        TRUE ~ "#95a5a6"
      ),
      is_gcc = Region %in% c("GCC Aggregate", "GCC Member")
    )
  
  # Get GCC rank for annotation
  gcc_rank <- plot_data %>% 
    filter(Country == gcc_method) %>% 
    pull(Rank)
  
  # Create bar chart with all countries
 p <- plot_ly(
    data = plot_data,
    x = ~reorder(display_name, Rank), # Let's put the countries in reverse order
    y = ~Score,
    type = "bar",
    marker = list(
      color = ~color,
      line = list(
        color = ifelse(plot_data$Region == "GCC Aggregate", "#8B7355", "transparent"),
        width = ifelse(plot_data$Region == "GCC Aggregate", 2, 0)
      )
    ),
    text = ~paste0(display_name, "<br>Score: ", round(Score, 1), "<br>Rank: #", Rank),
    hoverinfo = "text"
  ) %>%
    layout(
      title = list(
        text = "<b>GCC as a Unified Entity: World Ranking Position</b><br><sup>All 69 countries + GCC aggregate (use slider to explore)</sup>",
        font = list(size = 16)
      ),
      xaxis = list(
        title = "",
        tickangle = -45,
        tickfont = list(size = 9),
        rangeslider = list(
          visible = TRUE,
          thickness = 0.1
        ),
        range = c(-0.5, 24.5)  # Show first 25 countries initially
      ),
      yaxis = list(
        title = "Competitiveness Score",
        range = c(0, 105)
      ),
      showlegend = FALSE,
      margin = list(b = 150),
      annotations = list(
        list(
          x = gcc_method,
          y = gcc_score + 3,
          text = paste0("<b>#", gcc_rank, "</b>"),
          showarrow = FALSE,
          font = list(size = 14, color = "#B8A358")
        )
      )
    ) %>%
    config(displayModeBar = TRUE, displaylogo = FALSE)
  
  return(p)
}


# ============================================================================
# CHART 2: TRAJECTORY / JOURNEY LINE CHART
# ============================================================================

#' Create Trajectory Chart
#' Multi-line chart showing country ranking evolution 2021-2025
#' 
#' @param wcr_data WCR data list
#' @param highlight Vector of countries to highlight, or "All"
#' @return Plotly object
create_trajectory_chart <- function(wcr_data, highlight = "All") {
  
  # Prepare data
  trajectory <- wcr_data$overall_rankings %>%
    filter(Year >= 2021, !is.na(Overall_Rank)) %>%
    mutate(
      Country = factor(Country, levels = c(
        "UAE", "Qatar", "Saudi Arabia", "Bahrain", "Kuwait", "Oman"
      ))
    )
  
  # Calculate GCC average
  gcc_avg <- trajectory %>%
    group_by(Year) %>%
    summarise(Overall_Rank = mean(Overall_Rank), .groups = "drop") %>%
    mutate(Country = "GCC Average")
  
  all_data <- bind_rows(trajectory, gcc_avg)
  
  # Define colors (official GCC country palette)
  colors <- c(
    "UAE" = "#000000",
    "Qatar" = "#99154C",
    "Saudi Arabia" = "#008035",
    "Bahrain" = "#E20000",
    "Oman" = "#a3a3a3",
    "Kuwait" = "#00B1E6",
    "GCC Average" = "#B8A358"
  )
  
  # Determine highlighting
  highlight_all <- "All" %in% highlight || length(highlight) == 0
  
  # Create plot
  p <- plot_ly()
  
 # Add background zones
  p <- p %>%
    add_trace(
      x = c(2021, 2025, 2025, 2021),
      y = c(0, 0, 10, 10),
      type = "scatter",
      mode = "none",
      fill = "toself",
      fillcolor = "rgba(26, 188, 156, 0.1)",
      showlegend = FALSE,
      hoverinfo = "none"
    ) %>%
    add_trace(
      x = c(2021, 2025, 2025, 2021),
      y = c(10, 10, 20, 20),
      type = "scatter",
      mode = "none",
      fill = "toself",
      fillcolor = "rgba(46, 204, 113, 0.08)",
      showlegend = FALSE,
      hoverinfo = "none"
    ) %>%
    add_trace(
      x = c(2021, 2025, 2025, 2021),
      y = c(20, 20, 30, 30),
      type = "scatter",
      mode = "none",
      fill = "toself",
      fillcolor = "rgba(241, 196, 15, 0.08)",
      showlegend = FALSE,
      hoverinfo = "none"
    )
  
  # Add country lines
  for (country in unique(all_data$Country)) {
    country_data <- all_data %>% filter(Country == country)
    
    # Determine if this country should be highlighted
    is_highlighted <- highlight_all || country %in% highlight
    
    # Base styling
    base_width <- if(country == "GCC Average") 4 else 2
    base_dash <- if(country == "GCC Average") "dash" else "solid"
    
    # Apply highlighting
    line_width <- if(is_highlighted) base_width else 1
    line_opacity <- if(is_highlighted) 1 else 0.2
    marker_size <- if(is_highlighted) 10 else 5
    
    # Color with opacity
    base_color <- colors[country]
    line_color <- if(is_highlighted) base_color else paste0(base_color, "33")  # 20% opacity hex
    
    p <- p %>%
      add_trace(
        data = country_data,
        x = ~Year,
        y = ~Overall_Rank,
        type = "scatter",
        mode = "lines+markers",
        name = country,
        line = list(
          color = base_color,
          width = line_width,
          dash = base_dash
        ),
        marker = list(
          color = base_color,
          size = marker_size
        ),
        opacity = line_opacity,
        text = ~paste0(Country, " (", Year, ")<br>Rank: #", round(Overall_Rank, 1)),
        hoverinfo = "text"
      )
  }
  
  # Add annotations for highlighted countries (2025 position)
  if (!highlight_all && length(highlight) > 0) {
    for (country in highlight) {
      country_2025 <- all_data %>% 
        filter(Country == country, Year == 2025)
      
      if (nrow(country_2025) > 0) {
        p <- p %>%
          add_annotations(
            x = 2025,
            y = country_2025$Overall_Rank,
            text = paste0("<b>", country, " #", round(country_2025$Overall_Rank, 0), "</b>"),
            showarrow = TRUE,
            arrowhead = 2,
            arrowsize = 0.5,
            ax = 40,
            ay = 0,
            font = list(size = 11, color = colors[country])
          )
      }
    }
  }
  
  # Layout
  p <- p %>%
    layout(
      title = list(
        text = "<b>GCC Competitiveness Journey: 2021-2025</b>",
        font = list(size = 16)
      ),
      xaxis = list(
        title = "",
        tickvals = 2021:2025,
        ticktext = as.character(2021:2025),
        range = c(2020.5, 2025.5)
      ),
      yaxis = list(
        title = "Global Rank (lower is better)",
        autorange = "reversed",
        range = c(42, 0),
        tickvals = seq(0, 40, 10)
      ),
      legend = list(
        orientation = "h",
        y = -0.15,
        x = 0.5,
        xanchor = "center"
      ),
      margin = list(b = 100),
      hovermode = "closest"
    ) %>%
    config(displayModeBar = FALSE)
  
  return(p)
}


# ============================================================================
# CHART 3: DIMENSIONS LOLLIPOP/BAR CHART
# ============================================================================

#' Create Dimensions Chart
#' Shows GCC GDP-weighted scores across 4 dimensions
#' 
#' @param wcr_data WCR data list
#' @return Plotly object
create_dimensions_chart <- function(wcr_data) {
  
  # Get GDP-weighted GCC data
  gcc_weighted <- wcr_data$factors_2025 %>%
    filter(Country == "GCC (Weighted)")
  
  # Prepare dimension data
  dims <- data.frame(
    Dimension = c("Business Efficiency", "Government Efficiency", 
                  "Economic Performance", "Infrastructure"),
    Score = c(
      gcc_weighted$BusEff_Score,
      gcc_weighted$GovEff_Score,
      gcc_weighted$EconPerf_Score,
      gcc_weighted$Infra_Score
    ),
    Rank = c(
      gcc_weighted$BusEff_Rank,
      gcc_weighted$GovEff_Rank,
      gcc_weighted$EconPerf_Rank,
      gcc_weighted$Infra_Rank
    ),
    stringsAsFactors = FALSE
  ) %>%
    mutate(
      Performance = case_when(
        Score >= 80 ~ "Strong",
        Score >= 65 ~ "Good",
        TRUE ~ "Moderate"
      ),
      Color = case_when(
        Performance == "Strong" ~ "#27ae60",
        Performance == "Good" ~ "#f39c12",
        TRUE ~ "#e74c3c"
      )
    ) %>%
    arrange(Score)
  
  # Create horizontal bar chart
  p <- plot_ly(
    data = dims,
    y = ~reorder(Dimension, Score),
    x = ~Score,
    type = "bar",
    orientation = "h",
    marker = list(
      color = ~Color,
      line = list(color = "white", width = 1)
    ),
    text = ~paste0(round(Score, 1), " (Rank #", round(Rank, 0), ")"),
    textposition = "inside",
    insidetextanchor = "middle",
    textfont = list(color = "white", size = 14, family = "Inter"),
    hoverinfo = "text",
    hovertext = ~paste0(
      "<b>", Dimension, "</b><br>",
      "Score: ", round(Score, 1), "/100<br>",
      "Global Rank: #", round(Rank, 0)
    )
  ) %>%
    layout(
      title = list(
        text = "<b>GCC GDP-Weighted Performance by Dimension</b>",
        font = list(size = 16)
      ),
      xaxis = list(
        title = "Score (0-100)",
        range = c(0, 100),
        tickvals = seq(0, 100, 20)
      ),
      yaxis = list(
        title = ""
      ),
      showlegend = FALSE,
      margin = list(l = 150)
    ) %>%
    config(displayModeBar = FALSE)
  
  return(p)
}


# ============================================================================
# CHART 4: HEATMAP - 6 COUNTRIES x 5 DIMENSIONS
# ============================================================================

#' Create Heatmap Chart
#' Shows all 6 GCC countries across dimensions
#' 
#' @param wcr_data WCR data list
#' @return Plotly object
create_heatmap_chart <- function(wcr_data) {
  
  # Prepare data
  heatmap_data <- wcr_data$factors_2025 %>%
    filter(!grepl("GCC", Country)) %>%
    select(Country, Overall_Score, EconPerf_Score, GovEff_Score, 
           BusEff_Score, Infra_Score) %>%
    pivot_longer(
      cols = -Country,
      names_to = "Dimension",
      values_to = "Score"
    ) %>%
    mutate(
      Dimension = case_when(
        Dimension == "Overall_Score" ~ "Overall",
        Dimension == "EconPerf_Score" ~ "Economic\nPerformance",
        Dimension == "GovEff_Score" ~ "Government\nEfficiency",
        Dimension == "BusEff_Score" ~ "Business\nEfficiency",
        Dimension == "Infra_Score" ~ "Infrastructure"
      ),
      Dimension = factor(Dimension, levels = c(
        "Overall", "Economic\nPerformance", "Government\nEfficiency",
        "Business\nEfficiency", "Infrastructure"
      )),
      Country = factor(Country, levels = c(
        "UAE", "Qatar", "Saudi Arabia", "Bahrain", "Oman", "Kuwait"
      ))
    )
  
  # Create matrix for heatmap
  heatmap_matrix <- heatmap_data %>%
    pivot_wider(names_from = Dimension, values_from = Score)
  
  # Create heatmap
  p <- plot_ly(
    data = heatmap_data,
    x = ~Dimension,
    y = ~Country,
    z = ~Score,
    type = "heatmap",
    colorscale = list(
      c(0, "#e74c3c"),
      c(0.5, "#f9e79f"),
      c(1, "#27ae60")
    ),
    zmin = 45,
    zmax = 100,
    text = ~round(Score, 1),
    texttemplate = "%{text}",
    textfont = list(size = 12, color = "white"),
    hovertemplate = paste0(
      "<b>%{y}</b><br>",
      "%{x}<br>",
      "Score: %{z:.1f}",
      "<extra></extra>"
    ),
    colorbar = list(
      title = "Score",
      tickvals = c(50, 60, 70, 80, 90, 100)
    )
  ) %>%
    layout(
      title = list(
        text = "<b>GCC Countries: Competitiveness Heatmap 2025</b>",
        font = list(size = 16)
      ),
      xaxis = list(
        title = "",
        tickangle = 0
      ),
      yaxis = list(
        title = "",
        autorange = "reversed"
      ),
      margin = list(l = 100, b = 80)
    ) %>%
    config(displayModeBar = FALSE)
  
  return(p)
}


# ============================================================================
# CHART 5: GAP ANALYSIS CHART
# ============================================================================

#' Create Gap Analysis Chart
#' Shows achieved scores vs. potential improvement
#' 
#' @param wcr_data WCR data list
#' @param gcc_method Either "GCC (Weighted)" or "GCC (Simple)"
#' @return Plotly object
create_gap_chart <- function(wcr_data, gcc_method = "GCC (Weighted)") {
  
  # Get selected GCC data
  gcc_data <- wcr_data$factors_2025 %>%
    filter(Country == gcc_method)
  
  # Prepare gap data
  gap_data <- data.frame(
    Dimension = c("Overall", "Economic Performance", 
                  "Government Efficiency", "Business Efficiency", 
                  "Infrastructure"),
    Score = c(
      gcc_data$Overall_Score,
      gcc_data$EconPerf_Score,
      gcc_data$GovEff_Score,
      gcc_data$BusEff_Score,
      gcc_data$Infra_Score
    ),
    stringsAsFactors = FALSE
  ) %>%
    mutate(
      Gap = 100 - Score,
      Dimension = factor(Dimension, levels = rev(c(
        "Overall", "Business Efficiency", "Government Efficiency",
        "Economic Performance", "Infrastructure"
      )))
    )
  
  # Calculate infrastructure gap for annotation
  infra_gap <- gap_data %>% filter(Dimension == "Infrastructure") %>% pull(Gap)
  
  # Create stacked bar chart
  p <- plot_ly() %>%
    # Achieved scores
    add_trace(
      data = gap_data,
      y = ~Dimension,
      x = ~Score,
      type = "bar",
      orientation = "h",
      name = "Achieved",
      marker = list(color = "#3498db"),
      text = ~paste0(round(Score, 1), "%"),
      textposition = "inside",
      insidetextanchor = "middle",
      textfont = list(color = "white", size = 12),
      hovertemplate = paste0(
        "<b>%{y}</b><br>",
        "Achieved: %{x:.1f}%",
        "<extra></extra>"
      )
    ) %>%
    # Gap to 100
    add_trace(
      data = gap_data,
      y = ~Dimension,
      x = ~Gap,
      type = "bar",
      orientation = "h",
      name = "Gap to 100",
      marker = list(color = "#bdc3c7"),
      hovertemplate = paste0(
        "<b>%{y}</b><br>",
        "Gap: %{x:.1f}%",
        "<extra></extra>"
      )
    ) %>%
    layout(
      title = list(
        text = paste0("<b>GCC Performance Gap Analysis</b><br><sup>", 
                      gcc_method, " - Achieved scores vs. potential improvement</sup>"),
        font = list(size = 16)
      ),
      barmode = "stack",
      xaxis = list(
        title = "Percentage",
        range = c(0, 100),
        tickvals = seq(0, 100, 25),
        ticksuffix = "%"
      ),
      yaxis = list(
        title = ""
      ),
      legend = list(
        orientation = "h",
        y = -0.15,
        x = 0.5,
        xanchor = "center"
      ),
      margin = list(l = 150, b = 80),
      annotations = list(
        list(
          x = 80,
          y = "Infrastructure",
          text = paste0("<b>", round(infra_gap, 0), "-point<br>opportunity</b>"),
          showarrow = TRUE,
          arrowhead = 2,
          ax = 40,
          ay = 0,
          font = list(size = 11, color = "#c0392b")
        )
      )
    ) %>%
    config(displayModeBar = FALSE)
  
  return(p)
}


# ============================================================================
# CHART 6: RADAR CHART (OPTIONAL ADDITION)
# ============================================================================

#' Create Radar Chart for a single country or GCC aggregate
#' 
#' @param wcr_data WCR data list
#' @param country Country name to plot
#' @return Plotly object
create_radar_chart <- function(wcr_data, country = "GCC (Weighted)") {
  
  # Get country data
 country_data <- wcr_data$factors_2025 %>%
    filter(Country == country)
  
  # Prepare radar data
  categories <- c("Economic\nPerformance", "Government\nEfficiency", 
                  "Business\nEfficiency", "Infrastructure")
  
  values <- c(
    country_data$EconPerf_Score,
    country_data$GovEff_Score,
    country_data$BusEff_Score,
    country_data$Infra_Score
  )
  
  # Close the polygon
  categories <- c(categories, categories[1])
  values <- c(values, values[1])
  
  # Create radar chart
  p <- plot_ly(
    type = "scatterpolar",
    r = values,
    theta = categories,
    fill = "toself",
    fillcolor = "rgba(26, 82, 118, 0.3)",
    line = list(color = "#1a5276", width = 2),
    marker = list(color = "#1a5276", size = 8),
    name = country,
    hovertemplate = paste0(
      "%{theta}<br>",
      "Score: %{r:.1f}",
      "<extra></extra>"
    )
  ) %>%
    layout(
      title = list(
        text = paste0("<b>", country, ": Competitiveness Profile</b>"),
        font = list(size = 16)
      ),
      polar = list(
        radialaxis = list(
          visible = TRUE,
          range = c(0, 100),
          tickvals = seq(0, 100, 25)
        ),
        angularaxis = list(
          tickfont = list(size = 11)
        )
      ),
      showlegend = FALSE
    ) %>%
    config(displayModeBar = FALSE)
  
  return(p)
}


# ============================================================================
# CHART 7: DUAL RADAR CHART - GCC vs COUNTRY COMPARISON
# ============================================================================

#' Create Dual Radar Chart comparing GCC aggregate with selected country
#' 
#' @param wcr_data WCR data list
#' @param selected_country Country to compare against GCC
#' @param gcc_method Either "GCC (Weighted)" or "GCC (Simple)"
#' @return Plotly object (subplot with 2 radar charts)
create_dual_radar_chart <- function(wcr_data, 
                                     selected_country = "UAE", 
                                     gcc_method = "GCC (Weighted)") {
  
  # GCC country colors
  gcc_colors <- c(
    "UAE" = "#000000",
    "Qatar" = "#99154C",
    "Saudi Arabia" = "#008035",
    "Bahrain" = "#E20000",
    "Oman" = "#a3a3a3",
    "Kuwait" = "#00B1E6",
    "GCC (Weighted)" = "#B8A358",
    "GCC (Simple)" = "#1a5276"
  )
  
  # Categories for radar
  categories <- c("Economic<br>Performance", "Government<br>Efficiency", 
                  "Business<br>Efficiency", "Infrastructure")
  
  # Get GCC data
  gcc_data <- wcr_data$factors_2025 %>%
    filter(Country == gcc_method)
  
  gcc_values <- c(
    gcc_data$EconPerf_Score,
    gcc_data$GovEff_Score,
    gcc_data$BusEff_Score,
    gcc_data$Infra_Score
  )
  
  # Get country data
  country_data <- wcr_data$factors_2025 %>%
    filter(Country == selected_country)
  
  country_values <- c(
    country_data$EconPerf_Score,
    country_data$GovEff_Score,
    country_data$BusEff_Score,
    country_data$Infra_Score
  )
  
  # Close the polygons
  categories_closed <- c(categories, categories[1])
  gcc_values_closed <- c(gcc_values, gcc_values[1])
  country_values_closed <- c(country_values, country_values[1])
  
  # Get colors
  gcc_color <- gcc_colors[gcc_method]
  country_color <- gcc_colors[selected_country]
  
  # Create GCC radar (left)
  gcc_radar <- plot_ly(
    type = "scatterpolar",
    r = gcc_values_closed,
    theta = categories_closed,
    fill = "toself",
    fillcolor = paste0(gcc_color, "33"),  # 20% opacity
    line = list(color = gcc_color, width = 3),
    marker = list(color = gcc_color, size = 10),
    name = gcc_method,
    hovertemplate = paste0(
      "<b>", gcc_method, "</b><br>",
      "%{theta}: %{r:.1f}",
      "<extra></extra>"
    )
  ) %>%
    layout(
      polar = list(
        domain = list(x = c(0, 0.45), y = c(0, 1)),
        radialaxis = list(
          visible = TRUE,
          range = c(0, 100),
          tickvals = seq(0, 100, 25),
          tickfont = list(size = 10)
        ),
        angularaxis = list(
          tickfont = list(size = 10),
          rotation = 90
        )
      ),
      annotations = list(
        list(
          x = 0.225,
          y = 1.12,
          text = paste0("<b>", gcc_method, "</b><br><sup>Score: ", 
                        round(gcc_data$Overall_Score, 1), "</sup>"),
          showarrow = FALSE,
          font = list(size = 14, color = gcc_color),
          xref = "paper",
          yref = "paper"
        )
      )
    )
  
  # Create Country radar (right)
  country_radar <- plot_ly(
    type = "scatterpolar",
    r = country_values_closed,
    theta = categories_closed,
    fill = "toself",
    fillcolor = paste0(country_color, "33"),
    line = list(color = country_color, width = 3),
    marker = list(color = country_color, size = 10),
    name = selected_country,
    hovertemplate = paste0(
      "<b>", selected_country, "</b><br>",
      "%{theta}: %{r:.1f}",
      "<extra></extra>"
    )
  ) %>%
    layout(
      polar2 = list(
        domain = list(x = c(0.55, 1), y = c(0, 1)),
        radialaxis = list(
          visible = TRUE,
          range = c(0, 100),
          tickvals = seq(0, 100, 25),
          tickfont = list(size = 10)
        ),
        angularaxis = list(
          tickfont = list(size = 10),
          rotation = 90
        )
      ),
      annotations = list(
        list(
          x = 0.775,
          y = 1.12,
          text = paste0("<b>", selected_country, "</b><br><sup>Score: ", 
                        round(country_data$Overall_Score, 1), "</sup>"),
          showarrow = FALSE,
          font = list(size = 14, color = country_color),
          xref = "paper",
          yref = "paper"
        )
      )
    )
  
  # Combine into subplot
  p <- subplot(gcc_radar, country_radar) %>%
    layout(
      title = list(
        text = "<b>Competitiveness Profile Comparison</b>",
        font = list(size = 18),
        y = 0.98
      ),
      showlegend = FALSE,
      margin = list(t = 80)
    ) %>%
    config(displayModeBar = FALSE)
  
  return(p)
}


# ============================================================================
# CHART 8: OVERLAID RADAR CHART - Multiple entities on same chart
# ============================================================================

#' Create Overlaid Radar Chart with GCC and selected country on same axes
#' 
#' @param wcr_data WCR data list
#' @param selected_country Country to compare against GCC
#' @param gcc_method Either "GCC (Weighted)" or "GCC (Simple)"
#' @return Plotly object
create_overlay_radar_chart <- function(wcr_data, 
                                        selected_country = "UAE", 
                                        gcc_method = "GCC (Weighted)") {
  
  # GCC country colors
  gcc_colors <- c(
    "UAE" = "#000000",
    "Qatar" = "#99154C",
    "Saudi Arabia" = "#008035",
    "Bahrain" = "#E20000",
    "Oman" = "#a3a3a3",
    "Kuwait" = "#00B1E6",
    "GCC (Weighted)" = "#B8A358",
    "GCC (Simple)" = "#1a5276"
  )
  
  # Categories for radar
  categories <- c("Economic<br>Performance", "Government<br>Efficiency", 
                  "Business<br>Efficiency", "Infrastructure")
  
  # Get GCC data
  gcc_data <- wcr_data$factors_2025 %>%
    filter(Country == gcc_method)
  
  gcc_values <- c(
    gcc_data$EconPerf_Score,
    gcc_data$GovEff_Score,
    gcc_data$BusEff_Score,
    gcc_data$Infra_Score
  )
  
  # Get country data
  country_data <- wcr_data$factors_2025 %>%
    filter(Country == selected_country)
  
  country_values <- c(
    country_data$EconPerf_Score,
    country_data$GovEff_Score,
    country_data$BusEff_Score,
    country_data$Infra_Score
  )
  
  # Close the polygons
  categories_closed <- c(categories, categories[1])
  gcc_values_closed <- c(gcc_values, gcc_values[1])
  country_values_closed <- c(country_values, country_values[1])
  
  # Get colors
  gcc_color <- gcc_colors[gcc_method]
  country_color <- gcc_colors[selected_country]
  
  # Create combined radar chart
  p <- plot_ly() %>%
    # GCC trace
    add_trace(
      type = "scatterpolar",
      r = gcc_values_closed,
      theta = categories_closed,
      fill = "toself",
      fillcolor = paste0(gcc_color, "22"),  # 13% opacity
      line = list(color = gcc_color, width = 3),
      marker = list(color = gcc_color, size = 10),
      name = paste0(gcc_method, " (", round(gcc_data$Overall_Score, 1), ")"),
      hovertemplate = paste0(
        "<b>", gcc_method, "</b><br>",
        "%{theta}: %{r:.1f}",
        "<extra></extra>"
      )
    ) %>%
    # Country trace
    add_trace(
      type = "scatterpolar",
      r = country_values_closed,
      theta = categories_closed,
      fill = "toself",
      fillcolor = paste0(country_color, "22"),
      line = list(color = country_color, width = 3),
      marker = list(color = country_color, size = 10),
      name = paste0(selected_country, " (", round(country_data$Overall_Score, 1), ")"),
      hovertemplate = paste0(
        "<b>", selected_country, "</b><br>",
        "%{theta}: %{r:.1f}",
        "<extra></extra>"
      )
    ) %>%
    layout(
      title = list(
        text = "<b>Competitiveness Profile Comparison</b>",
        font = list(size = 16)
      ),
      polar = list(
        radialaxis = list(
          visible = TRUE,
          range = c(0, 100),
          tickvals = seq(0, 100, 25),
          tickfont = list(size = 11),
          gridcolor = "rgba(0,0,0,0.1)"
        ),
        angularaxis = list(
          tickfont = list(size = 12),
          rotation = 90,
          direction = "clockwise"
        )
      ),
      legend = list(
        orientation = "h",
        y = -0.1,
        x = 0.5,
        xanchor = "center",
        font = list(size = 12)
      ),
      margin = list(t = 60, b = 60)
    ) %>%
    config(displayModeBar = FALSE)
  
  return(p)
}
