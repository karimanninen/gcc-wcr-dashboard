# =============================================================================
# R/translations.R
# GCC WCR Dashboard – Bilingual Translation Dictionary (English / Arabic)
# =============================================================================
# Follows the same pattern as the GCCEII dashboard.
#
# Usage:
#   source("R/translations.R")
#   t("hero_title", lang)                     # scalar string
#   translate_country("Saudi Arabia", lang)    # translated country name
#   get_direction(lang)                        # "ltr" | "rtl"
#   get_font(lang)                             # CSS font-family string
# =============================================================================

# -- Core translation dictionary ----------------------------------------------

.translations <- list(

  # ---------------------------------------------------------------------------
  # Section 1: Hero
  # ---------------------------------------------------------------------------

  hero_title = list(
    en = "STRONGER TOGETHER",
    ar = "\u0623\u0642\u0648\u0649 \u0645\u0639\u0627\u064b"
  ),
  hero_subtitle = list(
    en = "How the GCC Became a Global Economic Force",
    ar = "\u0643\u064a\u0641 \u0623\u0635\u0628\u062d \u0645\u062c\u0644\u0633 \u0627\u0644\u062a\u0639\u0627\u0648\u0646 \u0627\u0644\u062e\u0644\u064a\u062c\u064a \u0642\u0648\u0629 \u0627\u0642\u062a\u0635\u0627\u062f\u064a\u0629 \u0639\u0627\u0644\u0645\u064a\u0629"
  ),
  hero_source = list(
    en = "IMD World Competitiveness Ranking 2025",
    ar = "\u062a\u0635\u0646\u064a\u0641 IMD \u0644\u0644\u062a\u0646\u0627\u0641\u0633\u064a\u0629 \u0627\u0644\u0639\u0627\u0644\u0645\u064a\u0629 2025"
  ),
  hero_scroll = list(
    en = "Scroll to explore the data story",
    ar = "\u0645\u0631\u0631 \u0644\u0623\u0633\u0641\u0644 \u0644\u0627\u0633\u062a\u0643\u0634\u0627\u0641 \u0642\u0635\u0629 \u0627\u0644\u0628\u064a\u0627\u0646\u0627\u062a"
  ),

  # ---------------------------------------------------------------------------
  # Section 2: Global Ranking
  # ---------------------------------------------------------------------------
  sec2_title = list(
    en = "If the GCC Were a Single Country...",
    ar = "\u0644\u0648 \u0643\u0627\u0646 \u0645\u062c\u0644\u0633 \u0627\u0644\u062a\u0639\u0627\u0648\u0646 \u0627\u0644\u062e\u0644\u064a\u062c\u064a \u062f\u0648\u0644\u0629 \u0648\u0627\u062d\u062f\u0629..."
  ),
  sec2_body = list(
    en = "With a combined GDP of $2.2 trillion, the six Gulf Cooperation Council nations have achieved what few regional blocs can claim: competitiveness that rivals established economic powerhouses.",
    ar = "\u0628\u0646\u0627\u062a\u062c \u0645\u062d\u0644\u064a \u0625\u062c\u0645\u0627\u0644\u064a \u064a\u0628\u0644\u063a 2.2 \u062a\u0631\u064a\u0644\u064a\u0648\u0646 \u062f\u0648\u0644\u0627\u0631\u060c \u062d\u0642\u0642\u062a \u062f\u0648\u0644 \u0645\u062c\u0644\u0633 \u0627\u0644\u062a\u0639\u0627\u0648\u0646 \u0627\u0644\u062e\u0644\u064a\u062c\u064a \u0627\u0644\u0633\u062a \u0645\u0627 \u064a\u0639\u062c\u0632 \u0639\u0646\u0647 \u0643\u062b\u064a\u0631 \u0645\u0646 \u0627\u0644\u062a\u0643\u062a\u0644\u0627\u062a \u0627\u0644\u0625\u0642\u0644\u064a\u0645\u064a\u0629: \u062a\u0646\u0627\u0641\u0633\u064a\u0629 \u062a\u0636\u0627\u0647\u064a \u0627\u0644\u0642\u0648\u0649 \u0627\u0644\u0627\u0642\u062a\u0635\u0627\u062f\u064a\u0629 \u0627\u0644\u0631\u0627\u0633\u062e\u0629."
  ),
  sec2_callout = list(
    en = "Our analysis reveals that when treated as a unified entity, the GCC scores 84.9 out of 100\u2014placing it ahead of the United States, Finland, and Iceland.",
    ar = "\u064a\u0643\u0634\u0641 \u062a\u062d\u0644\u064a\u0644\u0646\u0627 \u0623\u0646 \u062f\u0648\u0644 \u0627\u0644\u0645\u062c\u0644\u0633 \u0645\u062c\u062a\u0645\u0639\u0629\u064b \u062a\u062d\u0642\u0642 84.9 \u0645\u0646 100\u060c \u0645\u0645\u0627 \u064a\u0636\u0639\u0647\u0627 \u0641\u064a \u0645\u0631\u062a\u0628\u0629 \u0623\u0639\u0644\u0649 \u0645\u0646 \u0627\u0644\u0648\u0644\u0627\u064a\u0627\u062a \u0627\u0644\u0645\u062a\u062d\u062f\u0629 \u0648\u0641\u0646\u0644\u0646\u062f\u0627 \u0648\u0622\u064a\u0633\u0644\u0646\u062f\u0627."
  ),
  sec2_agg_method = list(
    en = "Aggregation Method:",
    ar = "\u0637\u0631\u064a\u0642\u0629 \u0627\u0644\u062a\u062c\u0645\u064a\u0639:"
  ),
  sec2_simple_avg = list(
    en = "Simple Average",
    ar = "\u0627\u0644\u0645\u062a\u0648\u0633\u0637 \u0627\u0644\u0628\u0633\u064a\u0637"
  ),
  sec2_gdp_weighted = list(
    en = "GDP-Weighted",
    ar = "\u0645\u0631\u062c\u062d \u0628\u0627\u0644\u0646\u0627\u062a\u062c \u0627\u0644\u0645\u062d\u0644\u064a"
  ),
  sec2_slider_hint = list(
    en = "Use the slider below the chart to explore all 69 countries",
    ar = "\u0627\u0633\u062a\u062e\u062f\u0645 \u0634\u0631\u064a\u0637 \u0627\u0644\u062a\u0645\u0631\u064a\u0631 \u0623\u0633\u0641\u0644 \u0627\u0644\u0631\u0633\u0645 \u0644\u0627\u0633\u062a\u0643\u0634\u0627\u0641 \u062c\u0645\u064a\u0639 \u0627\u0644\u062f\u0648\u0644 \u0627\u0644\u0640 69"
  ),

  # Method explanations
  method_gdp_weights = list(
    en = "<b>GDP weights:</b> SAU 50% | UAE 25% | QAT 10% | KWT 7% | OMN 5% | BHR 2%",
    ar = "<b>\u0623\u0648\u0632\u0627\u0646 \u0627\u0644\u0646\u0627\u062a\u062c \u0627\u0644\u0645\u062d\u0644\u064a:</b> \u0627\u0644\u0633\u0639\u0648\u062f\u064a\u0629 50% | \u0627\u0644\u0625\u0645\u0627\u0631\u0627\u062a 25% | \u0642\u0637\u0631 10% | \u0627\u0644\u0643\u0648\u064a\u062a 7% | \u0639\u064f\u0645\u0627\u0646 5% | \u0627\u0644\u0628\u062d\u0631\u064a\u0646 2%"
  ),
  method_gdp_desc = list(
    en = "Saudi Arabia's $1.1 trillion economy significantly influences the regional aggregate.",
    ar = "\u064a\u0624\u062b\u0631 \u0627\u0642\u062a\u0635\u0627\u062f \u0627\u0644\u0645\u0645\u0644\u0643\u0629 \u0627\u0644\u0639\u0631\u0628\u064a\u0629 \u0627\u0644\u0633\u0639\u0648\u062f\u064a\u0629 \u0627\u0644\u0628\u0627\u0644\u063a 1.1 \u062a\u0631\u064a\u0644\u064a\u0648\u0646 \u062f\u0648\u0644\u0627\u0631 \u0628\u0634\u0643\u0644 \u0643\u0628\u064a\u0631 \u0641\u064a \u0627\u0644\u0645\u062c\u0645\u0648\u0639 \u0627\u0644\u0625\u0642\u0644\u064a\u0645\u064a."
  ),
  method_simple_weights = list(
    en = "<b>Simple average:</b> All 6 countries weighted equally",
    ar = "<b>\u0627\u0644\u0645\u062a\u0648\u0633\u0637 \u0627\u0644\u0628\u0633\u064a\u0637:</b> \u062c\u0645\u064a\u0639 \u0627\u0644\u062f\u0648\u0644 \u0627\u0644\u0633\u062a \u0628\u0623\u0648\u0632\u0627\u0646 \u0645\u062a\u0633\u0627\u0648\u064a\u0629"
  ),
  method_simple_desc = list(
    en = "Smaller high-performers (UAE, Qatar) have equal influence to larger economies.",
    ar = "\u0627\u0644\u062f\u0648\u0644 \u0627\u0644\u0623\u0635\u063a\u0631 \u0639\u0627\u0644\u064a\u0629 \u0627\u0644\u0623\u062f\u0627\u0621 (\u0627\u0644\u0625\u0645\u0627\u0631\u0627\u062a\u060c \u0642\u0637\u0631) \u0644\u0647\u0627 \u0646\u0641\u0633 \u0627\u0644\u062a\u0623\u062b\u064a\u0631 \u0639\u0644\u0649 \u0627\u0644\u0627\u0642\u062a\u0635\u0627\u062f\u0627\u062a \u0627\u0644\u0623\u0643\u0628\u0631."
  ),

  # ---------------------------------------------------------------------------
  # Section 3: The Journey
  # ---------------------------------------------------------------------------
  sec3_title = list(
    en = "Remarkable Trajectories",
    ar = "\u0645\u0633\u0627\u0631\u0627\u062a \u0627\u0633\u062a\u062b\u0646\u0627\u0626\u064a\u0629"
  ),
  sec3_body = list(
    en = "Between 2021 and 2025, the GCC demonstrated unprecedented upward momentum.",
    ar = "\u0628\u064a\u0646 \u0639\u0627\u0645\u064a 2021 \u06482025\u060c \u0623\u0638\u0647\u0631 \u0645\u062c\u0644\u0633 \u0627\u0644\u062a\u0639\u0627\u0648\u0646 \u0627\u0644\u062e\u0644\u064a\u062c\u064a \u0632\u062e\u0645\u0627\u064b \u062a\u0635\u0627\u0639\u062f\u064a\u0627\u064b \u063a\u064a\u0631 \u0645\u0633\u0628\u0648\u0642."
  ),
  sec3_uae = list(
    en = " climbed from 9th to 5th place",
    ar = " \u0635\u0639\u062f\u062a \u0645\u0646 \u0627\u0644\u0645\u0631\u0643\u0632 \u0627\u0644\u062a\u0627\u0633\u0639 \u0625\u0644\u0649 \u0627\u0644\u062e\u0627\u0645\u0633"
  ),
  sec3_qatar = list(
    en = " surged eight positions to reach 9th globally",
    ar = " \u0642\u0641\u0632\u062a \u062b\u0645\u0627\u0646\u064a \u0645\u0631\u0627\u0643\u0632 \u0644\u062a\u0628\u0644\u063a \u0627\u0644\u0645\u0631\u0643\u0632 \u0627\u0644\u062a\u0627\u0633\u0639 \u0639\u0627\u0644\u0645\u064a\u0627\u064b"
  ),
  sec3_saudi = list(
    en = " achieved the region's most dramatic transformation\u2014leaping 15 positions from 32nd to 17th",
    ar = " \u062d\u0642\u0642\u062a \u0623\u0643\u0628\u0631 \u062a\u062d\u0648\u0644 \u0641\u064a \u0627\u0644\u0645\u0646\u0637\u0642\u0629\u2014\u0642\u0641\u0632\u062a 15 \u0645\u0631\u0643\u0632\u0627\u064b \u0645\u0646 \u0627\u0644\u0640 32 \u0625\u0644\u0649 \u0627\u0644\u0640 17"
  ),
  sec3_others = list(
    en = "Even relative newcomers to the survey like Bahrain, Kuwait, and Oman have quickly established themselves in the global top 40.",
    ar = "\u062d\u062a\u0649 \u0627\u0644\u062f\u0648\u0644 \u0627\u0644\u062c\u062f\u064a\u062f\u0629 \u0646\u0633\u0628\u064a\u0627\u064b \u0641\u064a \u0627\u0644\u0645\u0633\u062d \u0645\u062b\u0644 \u0627\u0644\u0628\u062d\u0631\u064a\u0646 \u0648\u0627\u0644\u0643\u0648\u064a\u062a \u0648\u0639\u064f\u0645\u0627\u0646 \u0631\u0633\u0651\u062e\u062a \u0645\u0643\u0627\u0646\u062a\u0647\u0627 \u0628\u0633\u0631\u0639\u0629 \u0636\u0645\u0646 \u0623\u0641\u0636\u0644 40 \u062f\u0648\u0644\u0629 \u0639\u0627\u0644\u0645\u064a\u0627\u064b."
  ),
  sec3_highlight_label = list(
    en = "Highlight Countries:",
    ar = "\u062a\u0645\u064a\u064a\u0632 \u0627\u0644\u062f\u0648\u0644:"
  ),
  sec3_count_selected = list(
    en = "{0} countries selected",
    ar = "{0} \u062f\u0648\u0644 \u0645\u062e\u062a\u0627\u0631\u0629"
  ),

  # ---------------------------------------------------------------------------
  # Section 4: Key Fact
  # ---------------------------------------------------------------------------
  sec4_did_you_know = list(
    en = "Did You Know?",
    ar = "\u0647\u0644 \u062a\u0639\u0644\u0645\u061f"
  ),
  sec4_label = list(
    en = "GCC Countries in the Global Top 20",
    ar = "\u062f\u0648\u0644 \u062e\u0644\u064a\u062c\u064a\u0629 \u0636\u0645\u0646 \u0623\u0641\u0636\u0644 20 \u062f\u0648\u0644\u0629 \u0639\u0627\u0644\u0645\u064a\u0627\u064b"
  ),
  sec4_detail = list(
    en = "UAE, Qatar, and Saudi Arabia now rank in the global top 20\u2014a remarkable concentration of competitiveness in a region of just 60 million people.",
    ar = "\u062a\u062d\u062a\u0644 \u0627\u0644\u0625\u0645\u0627\u0631\u0627\u062a \u0648\u0642\u0637\u0631 \u0648\u0627\u0644\u0633\u0639\u0648\u062f\u064a\u0629 \u0645\u0631\u0627\u0643\u0632 \u0636\u0645\u0646 \u0623\u0641\u0636\u0644 20 \u062f\u0648\u0644\u0629 \u0639\u0627\u0644\u0645\u064a\u0627\u064b\u2014\u062a\u0631\u0643\u064a\u0632 \u0627\u0633\u062a\u062b\u0646\u0627\u0626\u064a \u0644\u0644\u062a\u0646\u0627\u0641\u0633\u064a\u0629 \u0641\u064a \u0645\u0646\u0637\u0642\u0629 \u0644\u0627 \u064a\u062a\u062c\u0627\u0648\u0632 \u0639\u062f\u062f \u0633\u0643\u0627\u0646\u0647\u0627 60 \u0645\u0644\u064a\u0648\u0646 \u0646\u0633\u0645\u0629."
  ),

  # ---------------------------------------------------------------------------
  # Section 5: Strengths
  # ---------------------------------------------------------------------------
  sec5_title = list(
    en = "Business Efficiency & Government Effectiveness",
    ar = "\u0643\u0641\u0627\u0621\u0629 \u0627\u0644\u0623\u0639\u0645\u0627\u0644 \u0648\u0641\u0639\u0627\u0644\u064a\u0629 \u0627\u0644\u062d\u0643\u0648\u0645\u0629"
  ),
  sec5_lead = list(
    en = "The GCC's Secret Weapons",
    ar = "\u0627\u0644\u0623\u0633\u0644\u062d\u0629 \u0627\u0644\u0633\u0631\u064a\u0629 \u0644\u062f\u0648\u0644 \u0627\u0644\u062e\u0644\u064a\u062c"
  ),
  sec5_body1 = list(
    en = "The GCC's success isn't uniform\u2014it's strategic. The region scores highest in Business Efficiency (82.6, ranking 11th globally) and Government Efficiency (74.9, ranking 13th).",
    ar = "\u0646\u062c\u0627\u062d \u062f\u0648\u0644 \u0627\u0644\u0645\u062c\u0644\u0633 \u0644\u064a\u0633 \u0645\u0648\u062d\u062f\u0627\u064b\u2014\u0628\u0644 \u0627\u0633\u062a\u0631\u0627\u062a\u064a\u062c\u064a. \u062a\u062d\u0642\u0642 \u0627\u0644\u0645\u0646\u0637\u0642\u0629 \u0623\u0639\u0644\u0649 \u0627\u0644\u062f\u0631\u062c\u0627\u062a \u0641\u064a \u0643\u0641\u0627\u0621\u0629 \u0627\u0644\u0623\u0639\u0645\u0627\u0644 (82.6\u060c \u0627\u0644\u0645\u0631\u0643\u0632 11 \u0639\u0627\u0644\u0645\u064a\u0627\u064b) \u0648\u0643\u0641\u0627\u0621\u0629 \u0627\u0644\u062d\u0643\u0648\u0645\u0629 (74.9\u060c \u0627\u0644\u0645\u0631\u0643\u0632 13)."
  ),
  sec5_body2 = list(
    en = "This reflects decades of investment in streamlined regulations, low corporate taxation, and adaptive governance. These are the foundations that have attracted trillion-dollar foreign investment and positioned the GCC as a global business hub.",
    ar = "\u064a\u0639\u0643\u0633 \u0647\u0630\u0627 \u0639\u0642\u0648\u062f\u0627\u064b \u0645\u0646 \u0627\u0644\u0627\u0633\u062a\u062b\u0645\u0627\u0631 \u0641\u064a \u062a\u0628\u0633\u064a\u0637 \u0627\u0644\u0623\u0646\u0638\u0645\u0629\u060c \u0648\u062e\u0641\u0636 \u0627\u0644\u0636\u0631\u0627\u0626\u0628 \u0639\u0644\u0649 \u0627\u0644\u0634\u0631\u0643\u0627\u062a\u060c \u0648\u0627\u0644\u062d\u0648\u0643\u0645\u0629 \u0627\u0644\u0645\u0631\u0646\u0629. \u0647\u0630\u0647 \u0647\u064a \u0627\u0644\u0631\u0643\u0627\u0626\u0632 \u0627\u0644\u062a\u064a \u0627\u0633\u062a\u0642\u0637\u0628\u062a \u0627\u0633\u062a\u062b\u0645\u0627\u0631\u0627\u062a \u0623\u062c\u0646\u0628\u064a\u0629 \u0628\u0627\u0644\u062a\u0631\u064a\u0644\u064a\u0648\u0646\u0627\u062a \u0648\u062c\u0639\u0644\u062a \u0627\u0644\u062e\u0644\u064a\u062c \u0645\u0631\u0643\u0632\u0627\u064b \u0639\u0627\u0644\u0645\u064a\u0627\u064b \u0644\u0644\u0623\u0639\u0645\u0627\u0644."
  ),

  # ---------------------------------------------------------------------------
  # Section 5B: Radar Comparison
  # ---------------------------------------------------------------------------
  sec5b_title = list(
    en = "Dimension Deep Dive",
    ar = "\u062a\u062d\u0644\u064a\u0644 \u0645\u0639\u0645\u0642 \u0644\u0644\u0623\u0628\u0639\u0627\u062f"
  ),
  sec5b_lead = list(
    en = "Compare GCC with Individual Countries",
    ar = "\u0642\u0627\u0631\u0646 \u0628\u064a\u0646 \u0627\u0644\u0645\u062c\u0644\u0633 \u0648\u0627\u0644\u062f\u0648\u0644 \u0645\u0646\u0641\u0631\u062f\u0629\u064b"
  ),
  sec5b_body1 = list(
    en = "Explore how individual GCC countries perform across the four competitiveness dimensions compared to the regional aggregate.",
    ar = "\u0627\u0633\u062a\u0643\u0634\u0641 \u0623\u062f\u0627\u0621 \u062f\u0648\u0644 \u0627\u0644\u0645\u062c\u0644\u0633 \u0641\u064a \u0623\u0628\u0639\u0627\u062f \u0627\u0644\u062a\u0646\u0627\u0641\u0633\u064a\u0629 \u0627\u0644\u0623\u0631\u0628\u0639\u0629 \u0645\u0642\u0627\u0631\u0646\u0629 \u0628\u0627\u0644\u0645\u062c\u0645\u0648\u0639 \u0627\u0644\u0625\u0642\u0644\u064a\u0645\u064a."
  ),
  sec5b_body2 = list(
    en = "Select a country to see its strengths and areas for improvement relative to the GDP-weighted GCC benchmark.",
    ar = "\u0627\u062e\u062a\u0631 \u062f\u0648\u0644\u0629 \u0644\u0639\u0631\u0636 \u0646\u0642\u0627\u0637 \u0642\u0648\u062a\u0647\u0627 \u0648\u0645\u062c\u0627\u0644\u0627\u062a \u0627\u0644\u062a\u062d\u0633\u064a\u0646 \u0645\u0642\u0627\u0631\u0646\u0629 \u0628\u0645\u0639\u064a\u0627\u0631 \u0627\u0644\u0645\u062c\u0644\u0633 \u0627\u0644\u0645\u0631\u062c\u062d \u0628\u0627\u0644\u0646\u0627\u062a\u062c \u0627\u0644\u0645\u062d\u0644\u064a."
  ),
  sec5b_select_country = list(
    en = "Select Country to Compare:",
    ar = "\u0627\u062e\u062a\u0631 \u062f\u0648\u0644\u0629 \u0644\u0644\u0645\u0642\u0627\u0631\u0646\u0629:"
  ),

  # Radar comparison summary
  radar_vs = list(en = " vs ", ar = " \u0645\u0642\u0627\u0628\u0644 "),
  radar_overall = list(en = "Overall: ", ar = "\u0627\u0644\u0625\u062c\u0645\u0627\u0644\u064a: "),
  radar_points = list(en = " points", ar = " \u0646\u0642\u0637\u0629"),
  radar_strongest = list(en = "Strongest: ", ar = "\u0627\u0644\u0623\u0642\u0648\u0649: "),
  radar_gap = list(en = "Gap: ", ar = "\u0627\u0644\u0641\u062c\u0648\u0629: "),

  # ---------------------------------------------------------------------------
  # Section 6: Country Profiles
  # ---------------------------------------------------------------------------
  sec6_title = list(
    en = "Six Nations, Complementary Strengths",
    ar = "\u0633\u062a \u062f\u0648\u0644\u060c \u0646\u0642\u0627\u0637 \u0642\u0648\u0629 \u0645\u062a\u0643\u0627\u0645\u0644\u0629"
  ),
  sec6_body = list(
    en = "While united in upward trajectory, each GCC country brings unique strengths to the regional competitiveness profile.",
    ar = "\u0631\u063a\u0645 \u0627\u062a\u062d\u0627\u062f\u0647\u0627 \u0641\u064a \u0627\u0644\u0645\u0633\u0627\u0631 \u0627\u0644\u062a\u0635\u0627\u0639\u062f\u064a\u060c \u062a\u0642\u062f\u0645 \u0643\u0644 \u062f\u0648\u0644\u0629 \u062e\u0644\u064a\u062c\u064a\u0629 \u0646\u0642\u0627\u0637 \u0642\u0648\u0629 \u0641\u0631\u064a\u062f\u0629 \u0644\u0645\u0644\u0641 \u0627\u0644\u062a\u0646\u0627\u0641\u0633\u064a\u0629 \u0627\u0644\u0625\u0642\u0644\u064a\u0645\u064a."
  ),
  sec6_uae = list(
    en = " leads in overall performance and economic dynamism",
    ar = " \u062a\u062a\u0635\u062f\u0631 \u0641\u064a \u0627\u0644\u0623\u062f\u0627\u0621 \u0627\u0644\u0639\u0627\u0645 \u0648\u0627\u0644\u062f\u064a\u0646\u0627\u0645\u064a\u0643\u064a\u0629 \u0627\u0644\u0627\u0642\u062a\u0635\u0627\u062f\u064a\u0629"
  ),
  sec6_qatar = list(
    en = " excels in business efficiency and government effectiveness",
    ar = " \u062a\u062a\u0641\u0648\u0642 \u0641\u064a \u0643\u0641\u0627\u0621\u0629 \u0627\u0644\u0623\u0639\u0645\u0627\u0644 \u0648\u0641\u0639\u0627\u0644\u064a\u0629 \u0627\u0644\u062d\u0643\u0648\u0645\u0629"
  ),
  sec6_saudi = list(
    en = "'s massive economy provides scale and diversification",
    ar = " \u062a\u0648\u0641\u0631 \u0628\u0627\u0642\u062a\u0635\u0627\u062f\u0647\u0627 \u0627\u0644\u0636\u062e\u0645 \u0627\u0644\u062d\u062c\u0645 \u0648\u0627\u0644\u062a\u0646\u0648\u064a\u0639"
  ),
  sec6_complement = list(
    en = "Together, they create a complementary ecosystem where investors can find exactly the competitive advantages they need.",
    ar = "\u0645\u0639\u0627\u064b\u060c \u062a\u0634\u0643\u0644 \u0645\u0646\u0638\u0648\u0645\u0629 \u0645\u062a\u0643\u0627\u0645\u0644\u0629 \u064a\u062c\u062f \u0641\u064a\u0647\u0627 \u0627\u0644\u0645\u0633\u062a\u062b\u0645\u0631\u0648\u0646 \u0628\u0627\u0644\u0636\u0628\u0637 \u0627\u0644\u0645\u0632\u0627\u064a\u0627 \u0627\u0644\u062a\u0646\u0627\u0641\u0633\u064a\u0629 \u0627\u0644\u062a\u064a \u064a\u062d\u062a\u0627\u062c\u0648\u0646\u0647\u0627."
  ),

  # ---------------------------------------------------------------------------
  # Section 7: Gap Analysis
  # ---------------------------------------------------------------------------
  sec7_title = list(
    en = "GCC Scores by Dimension",
    ar = "\u062f\u0631\u062c\u0627\u062a \u062f\u0648\u0644 \u0627\u0644\u0645\u062c\u0644\u0633 \u062d\u0633\u0628 \u0627\u0644\u0628\u064f\u0639\u062f"
  ),
  sec7_body1 = list(
    en = "When we weight countries by their economic size, Saudi Arabia's massive $1.1 trillion economy significantly influences the regional picture.",
    ar = "\u0639\u0646\u062f \u062a\u0631\u062c\u064a\u062d \u0627\u0644\u062f\u0648\u0644 \u062d\u0633\u0628 \u062d\u062c\u0645 \u0627\u0642\u062a\u0635\u0627\u062f\u0647\u0627\u060c \u064a\u0624\u062b\u0631 \u0627\u0642\u062a\u0635\u0627\u062f \u0627\u0644\u0633\u0639\u0648\u062f\u064a\u0629 \u0627\u0644\u0636\u062e\u0645 \u0627\u0644\u0628\u0627\u0644\u063a 1.1 \u062a\u0631\u064a\u0644\u064a\u0648\u0646 \u062f\u0648\u0644\u0627\u0631 \u0628\u0634\u0643\u0644 \u0643\u0628\u064a\u0631 \u0641\u064a \u0627\u0644\u0635\u0648\u0631\u0629 \u0627\u0644\u0625\u0642\u0644\u064a\u0645\u064a\u0629."
  ),
  sec7_body2 = list(
    en = "This GDP-weighted analysis shows that while smaller nations like UAE and Qatar punch above their weight in rankings, Saudi Arabia's scale and improving performance define the region's aggregate competitiveness.",
    ar = "\u064a\u0638\u0647\u0631 \u0647\u0630\u0627 \u0627\u0644\u062a\u062d\u0644\u064a\u0644 \u0627\u0644\u0645\u0631\u062c\u062d \u0628\u0627\u0644\u0646\u0627\u062a\u062c \u0627\u0644\u0645\u062d\u0644\u064a \u0623\u0646 \u0627\u0644\u062f\u0648\u0644 \u0627\u0644\u0623\u0635\u063a\u0631 \u0643\u0627\u0644\u0625\u0645\u0627\u0631\u0627\u062a \u0648\u0642\u0637\u0631 \u062a\u062a\u0641\u0648\u0642 \u0639\u0644\u0649 \u062d\u062c\u0645\u0647\u0627 \u0641\u064a \u0627\u0644\u062a\u0635\u0646\u064a\u0641\u0627\u062a\u060c \u0628\u064a\u0646\u0645\u0627 \u064a\u0634\u0643\u0644 \u062d\u062c\u0645 \u0627\u0644\u0633\u0639\u0648\u062f\u064a\u0629 \u0648\u0623\u062f\u0627\u0624\u0647\u0627 \u0627\u0644\u0645\u062a\u062d\u0633\u0646 \u0627\u0644\u062a\u0646\u0627\u0641\u0633\u064a\u0629 \u0627\u0644\u0625\u062c\u0645\u0627\u0644\u064a\u0629 \u0644\u0644\u0645\u0646\u0637\u0642\u0629."
  ),
  sec7_callout = list(
    en = "The gap analysis reveals clear opportunities: infrastructure development and continued economic diversification could push the unified GCC score above 90.",
    ar = "\u064a\u0643\u0634\u0641 \u062a\u062d\u0644\u064a\u0644 \u0627\u0644\u0641\u062c\u0648\u0627\u062a \u0639\u0646 \u0641\u0631\u0635 \u0648\u0627\u0636\u062d\u0629: \u062a\u0637\u0648\u064a\u0631 \u0627\u0644\u0628\u0646\u064a\u0629 \u0627\u0644\u062a\u062d\u062a\u064a\u0629 \u0648\u0645\u0648\u0627\u0635\u0644\u0629 \u0627\u0644\u062a\u0646\u0648\u064a\u0639 \u0627\u0644\u0627\u0642\u062a\u0635\u0627\u062f\u064a \u0642\u062f \u064a\u0631\u0641\u0639\u0627\u0646 \u062f\u0631\u062c\u0629 \u0627\u0644\u0645\u062c\u0644\u0633 \u0627\u0644\u0645\u0648\u062d\u062f\u0629 \u0641\u0648\u0642 90."
  ),

  # ---------------------------------------------------------------------------
  # Section 8: 2030 Horizon
  # ---------------------------------------------------------------------------
  sec8_title = list(
    en = "The 2030 Horizon",
    ar = "\u0623\u0641\u0642 2030"
  ),
  sec8_lead = list(
    en = "Can the GCC Break Into the Global Top 10?",
    ar = "\u0647\u0644 \u064a\u0633\u062a\u0637\u064a\u0639 \u0627\u0644\u0645\u062c\u0644\u0633 \u062f\u062e\u0648\u0644 \u0642\u0627\u0626\u0645\u0629 \u0623\u0641\u0636\u0644 10 \u0639\u0627\u0644\u0645\u064a\u0627\u064b\u061f"
  ),
  sec8_body1 = list(
    en = "Current trajectories suggest the GCC isn't finished climbing. With strategic focus on three areas\u2014infrastructure modernization, R&D investment, and sustainable development\u2014the region could achieve a unified score above 90 by 2030.",
    ar = "\u062a\u0634\u064a\u0631 \u0627\u0644\u0645\u0633\u0627\u0631\u0627\u062a \u0627\u0644\u062d\u0627\u0644\u064a\u0629 \u0625\u0644\u0649 \u0623\u0646 \u062f\u0648\u0644 \u0627\u0644\u0645\u062c\u0644\u0633 \u0644\u0645 \u062a\u0646\u062a\u0647\u0650 \u0645\u0646 \u0627\u0644\u0635\u0639\u0648\u062f. \u0628\u0627\u0644\u062a\u0631\u0643\u064a\u0632 \u0627\u0644\u0627\u0633\u062a\u0631\u0627\u062a\u064a\u062c\u064a \u0639\u0644\u0649 \u062b\u0644\u0627\u062b\u0629 \u0645\u062c\u0627\u0644\u0627\u062a\u2014\u062a\u062d\u062f\u064a\u062b \u0627\u0644\u0628\u0646\u064a\u0629 \u0627\u0644\u062a\u062d\u062a\u064a\u0629\u060c \u0648\u0627\u0644\u0627\u0633\u062a\u062b\u0645\u0627\u0631 \u0641\u064a \u0627\u0644\u0628\u062d\u062b \u0648\u0627\u0644\u062a\u0637\u0648\u064a\u0631\u060c \u0648\u0627\u0644\u062a\u0646\u0645\u064a\u0629 \u0627\u0644\u0645\u0633\u062a\u062f\u0627\u0645\u0629\u2014\u064a\u0645\u0643\u0646 \u0644\u0644\u0645\u0646\u0637\u0642\u0629 \u062a\u062d\u0642\u064a\u0642 \u062f\u0631\u062c\u0629 \u0645\u0648\u062d\u062f\u0629 \u062a\u062a\u062c\u0627\u0648\u0632 90 \u0628\u062d\u0644\u0648\u0644 2030."
  ),
  sec8_body2 = list(
    en = "The foundation is solid: world-class business environments, efficient governments, and the financial resources to invest in future competitiveness.",
    ar = "\u0627\u0644\u0623\u0633\u0627\u0633 \u0645\u062a\u064a\u0646: \u0628\u064a\u0626\u0627\u062a \u0623\u0639\u0645\u0627\u0644 \u0639\u0627\u0644\u0645\u064a\u0629 \u0627\u0644\u0645\u0633\u062a\u0648\u0649\u060c \u0648\u062d\u0643\u0648\u0645\u0627\u062a \u0643\u0641\u0624\u0629\u060c \u0648\u0645\u0648\u0627\u0631\u062f \u0645\u0627\u0644\u064a\u0629 \u0644\u0644\u0627\u0633\u062a\u062b\u0645\u0627\u0631 \u0641\u064a \u062a\u0646\u0627\u0641\u0633\u064a\u0629 \u0627\u0644\u0645\u0633\u062a\u0642\u0628\u0644."
  ),
  sec8_recs_title = list(
    en = "Strategic Recommendations",
    ar = "\u062a\u0648\u0635\u064a\u0627\u062a \u0627\u0633\u062a\u0631\u0627\u062a\u064a\u062c\u064a\u0629"
  ),
  rec_infra_title = list(
    en = "Infrastructure Investment",
    ar = "\u0627\u0644\u0627\u0633\u062a\u062b\u0645\u0627\u0631 \u0641\u064a \u0627\u0644\u0628\u0646\u064a\u0629 \u0627\u0644\u062a\u062d\u062a\u064a\u0629"
  ),
  rec_infra_body = list(
    en = "\"Close the 15-point gap by accelerating R&D spending, digital infrastructure, and green energy transitions\"",
    ar = "\"\u0633\u062f \u0641\u062c\u0648\u0629 \u0627\u0644\u0640 15 \u0646\u0642\u0637\u0629 \u0639\u0628\u0631 \u062a\u0633\u0631\u064a\u0639 \u0627\u0644\u0625\u0646\u0641\u0627\u0642 \u0639\u0644\u0649 \u0627\u0644\u0628\u062d\u062b \u0648\u0627\u0644\u062a\u0637\u0648\u064a\u0631 \u0648\u0627\u0644\u0628\u0646\u064a\u0629 \u0627\u0644\u062a\u062d\u062a\u064a\u0629 \u0627\u0644\u0631\u0642\u0645\u064a\u0629 \u0648\u0627\u0644\u062a\u062d\u0648\u0644 \u0625\u0644\u0649 \u0627\u0644\u0637\u0627\u0642\u0629 \u0627\u0644\u062e\u0636\u0631\u0627\u0621\""
  ),
  rec_sustain_title = list(
    en = "Sustainability Leadership",
    ar = "\u0627\u0644\u0631\u064a\u0627\u062f\u0629 \u0641\u064a \u0627\u0644\u0627\u0633\u062a\u062f\u0627\u0645\u0629"
  ),
  rec_sustain_body = list(
    en = "\"Transform environmental challenges into competitive advantages through aggressive renewable energy deployment\"",
    ar = "\"\u062a\u062d\u0648\u064a\u0644 \u0627\u0644\u062a\u062d\u062f\u064a\u0627\u062a \u0627\u0644\u0628\u064a\u0626\u064a\u0629 \u0625\u0644\u0649 \u0645\u0632\u0627\u064a\u0627 \u062a\u0646\u0627\u0641\u0633\u064a\u0629 \u0639\u0628\u0631 \u0646\u0634\u0631 \u0627\u0644\u0637\u0627\u0642\u0629 \u0627\u0644\u0645\u062a\u062c\u062f\u062f\u0629 \u0628\u0642\u0648\u0629\""
  ),
  rec_human_title = list(
    en = "Human Capital Development",
    ar = "\u062a\u0646\u0645\u064a\u0629 \u0627\u0644\u0631\u0623\u0633\u0645\u0627\u0644 \u0627\u0644\u0628\u0634\u0631\u064a"
  ),
  rec_human_body = list(
    en = "\"Strengthen higher education systems and STEM capabilities to reduce dependency on imported talent\"",
    ar = "\"\u062a\u0639\u0632\u064a\u0632 \u0645\u0646\u0638\u0648\u0645\u0627\u062a \u0627\u0644\u062a\u0639\u0644\u064a\u0645 \u0627\u0644\u0639\u0627\u0644\u064a \u0648\u0642\u062f\u0631\u0627\u062a \u0627\u0644\u0639\u0644\u0648\u0645 \u0648\u0627\u0644\u062a\u0643\u0646\u0648\u0644\u0648\u062c\u064a\u0627 \u0648\u0627\u0644\u0647\u0646\u062f\u0633\u0629 \u0648\u0627\u0644\u0631\u064a\u0627\u0636\u064a\u0627\u062a \u0644\u062a\u0642\u0644\u064a\u0644 \u0627\u0644\u0627\u0639\u062a\u0645\u0627\u062f \u0639\u0644\u0649 \u0627\u0644\u0643\u0641\u0627\u0621\u0627\u062a \u0627\u0644\u0645\u0633\u062a\u0648\u0631\u062f\u0629\""
  ),
  rec_integration_title = list(
    en = "Regional Integration",
    ar = "\u0627\u0644\u062a\u0643\u0627\u0645\u0644 \u0627\u0644\u0625\u0642\u0644\u064a\u0645\u064a"
  ),
  rec_integration_body = list(
    en = "\"Deepen economic cooperation to create true economies of scale across the $2.2 trillion GCC market\"",
    ar = "\"\u062a\u0639\u0645\u064a\u0642 \u0627\u0644\u062a\u0639\u0627\u0648\u0646 \u0627\u0644\u0627\u0642\u062a\u0635\u0627\u062f\u064a \u0644\u062e\u0644\u0642 \u0648\u0641\u0648\u0631\u0627\u062a \u062d\u0642\u064a\u0642\u064a\u0629 \u0641\u064a \u0627\u0644\u062d\u062c\u0645 \u0639\u0628\u0631 \u0633\u0648\u0642 \u0627\u0644\u0645\u062c\u0644\u0633 \u0627\u0644\u0628\u0627\u0644\u063a 2.2 \u062a\u0631\u064a\u0644\u064a\u0648\u0646 \u062f\u0648\u0644\u0627\u0631\""
  ),

  # ---------------------------------------------------------------------------
  # Footer
  # ---------------------------------------------------------------------------
  footer_org = list(
    en = "GCC Statistical Center | IMD World Competitiveness Ranking 2025",
    ar = "\u0627\u0644\u0645\u0631\u0643\u0632 \u0627\u0644\u0625\u062d\u0635\u0627\u0626\u064a \u0644\u062f\u0648\u0644 \u0645\u062c\u0644\u0633 \u0627\u0644\u062a\u0639\u0627\u0648\u0646 | \u062a\u0635\u0646\u064a\u0641 IMD \u0644\u0644\u062a\u0646\u0627\u0641\u0633\u064a\u0629 \u0627\u0644\u0639\u0627\u0644\u0645\u064a\u0629 2025"
  ),
  footer_dept = list(
    en = "Data story prepared by the Economic Statistics Department",
    ar = "\u0642\u0635\u0629 \u0627\u0644\u0628\u064a\u0627\u0646\u0627\u062a \u0645\u0646 \u0625\u0639\u062f\u0627\u062f \u0625\u062f\u0627\u0631\u0629 \u0627\u0644\u0625\u062d\u0635\u0627\u0621\u0627\u062a \u0627\u0644\u0627\u0642\u062a\u0635\u0627\u062f\u064a\u0629"
  ),

  # ---------------------------------------------------------------------------
  # Navigation dot tooltips
  # ---------------------------------------------------------------------------
  nav_intro = list(en = "Introduction", ar = "\u0627\u0644\u0645\u0642\u062f\u0645\u0629"),
  nav_ranking = list(en = "Global Ranking", ar = "\u0627\u0644\u062a\u0635\u0646\u064a\u0641 \u0627\u0644\u0639\u0627\u0644\u0645\u064a"),
  nav_journey = list(en = "The Journey", ar = "\u0627\u0644\u0645\u0633\u064a\u0631\u0629"),
  nav_fact = list(en = "Key Fact", ar = "\u062d\u0642\u064a\u0642\u0629 \u0631\u0626\u064a\u0633\u064a\u0629"),
  nav_strengths = list(en = "Strengths", ar = "\u0646\u0642\u0627\u0637 \u0627\u0644\u0642\u0648\u0629"),
  nav_dimensions = list(en = "Dimension Comparison", ar = "\u0645\u0642\u0627\u0631\u0646\u0629 \u0627\u0644\u0623\u0628\u0639\u0627\u062f"),
  nav_profiles = list(en = "Country Profiles", ar = "\u0645\u0644\u0641\u0627\u062a \u0627\u0644\u062f\u0648\u0644"),
  nav_gap = list(en = "Gap Analysis", ar = "\u062a\u062d\u0644\u064a\u0644 \u0627\u0644\u0641\u062c\u0648\u0627\u062a"),
  nav_horizon = list(en = "2030 Horizon", ar = "\u0623\u0641\u0642 2030"),

  # ---------------------------------------------------------------------------
  # Chart labels (used in R/charts.R)
  # ---------------------------------------------------------------------------
  chart_world_title = list(
    en = "<b>GCC as a Unified Entity: World Ranking Position</b><br><sup>All 69 countries + GCC aggregate (use slider to explore)</sup>",
    ar = "<b>\u062f\u0648\u0644 \u0627\u0644\u0645\u062c\u0644\u0633 \u0643\u0643\u064a\u0627\u0646 \u0645\u0648\u062d\u062f: \u0627\u0644\u062a\u0631\u062a\u064a\u0628 \u0627\u0644\u0639\u0627\u0644\u0645\u064a</b><br><sup>\u062c\u0645\u064a\u0639 \u0627\u0644\u062f\u0648\u0644 \u0627\u0644\u0640 69 + \u0627\u0644\u0645\u062c\u0645\u0648\u0639 \u0627\u0644\u062e\u0644\u064a\u062c\u064a (\u0627\u0633\u062a\u062e\u062f\u0645 \u0634\u0631\u064a\u0637 \u0627\u0644\u062a\u0645\u0631\u064a\u0631 \u0644\u0644\u0627\u0633\u062a\u0643\u0634\u0627\u0641)</sup>"
  ),
  chart_world_yaxis = list(
    en = "Competitiveness Score",
    ar = "\u062f\u0631\u062c\u0629 \u0627\u0644\u062a\u0646\u0627\u0641\u0633\u064a\u0629"
  ),
  chart_trajectory_title = list(
    en = "<b>GCC Competitiveness Journey: 2021-2025</b>",
    ar = "<b>\u0645\u0633\u064a\u0631\u0629 \u062a\u0646\u0627\u0641\u0633\u064a\u0629 \u062f\u0648\u0644 \u0627\u0644\u0645\u062c\u0644\u0633: 2021-2025</b>"
  ),
  chart_trajectory_yaxis = list(
    en = "Global Rank (lower is better)",
    ar = "\u0627\u0644\u062a\u0631\u062a\u064a\u0628 \u0627\u0644\u0639\u0627\u0644\u0645\u064a (\u0627\u0644\u0623\u0642\u0644 \u0623\u0641\u0636\u0644)"
  ),
  chart_dimensions_title = list(
    en = "<b>GCC GDP-Weighted Performance by Dimension</b>",
    ar = "<b>\u0623\u062f\u0627\u0621 \u062f\u0648\u0644 \u0627\u0644\u0645\u062c\u0644\u0633 \u0627\u0644\u0645\u0631\u062c\u062d \u0628\u0627\u0644\u0646\u0627\u062a\u062c \u0627\u0644\u0645\u062d\u0644\u064a \u062d\u0633\u0628 \u0627\u0644\u0628\u064f\u0639\u062f</b>"
  ),
  chart_dimensions_xaxis = list(
    en = "Score (0-100)",
    ar = "\u0627\u0644\u062f\u0631\u062c\u0629 (0-100)"
  ),
  chart_heatmap_title = list(
    en = "<b>GCC Countries: Competitiveness Heatmap 2025</b>",
    ar = "<b>\u062f\u0648\u0644 \u0627\u0644\u0645\u062c\u0644\u0633: \u062e\u0631\u064a\u0637\u0629 \u062d\u0631\u0627\u0631\u064a\u0629 \u0644\u0644\u062a\u0646\u0627\u0641\u0633\u064a\u0629 2025</b>"
  ),
  chart_heatmap_colorbar = list(
    en = "Score",
    ar = "\u0627\u0644\u062f\u0631\u062c\u0629"
  ),
  chart_gap_title = list(
    en = "<b>GCC Performance Gap Analysis</b>",
    ar = "<b>\u062a\u062d\u0644\u064a\u0644 \u0641\u062c\u0648\u0627\u062a \u0623\u062f\u0627\u0621 \u062f\u0648\u0644 \u0627\u0644\u0645\u062c\u0644\u0633</b>"
  ),
  chart_gap_subtitle = list(
    en = "Achieved scores vs. potential improvement",
    ar = "\u0627\u0644\u062f\u0631\u062c\u0627\u062a \u0627\u0644\u0645\u062d\u0642\u0642\u0629 \u0645\u0642\u0627\u0628\u0644 \u0625\u0645\u0643\u0627\u0646\u064a\u0629 \u0627\u0644\u062a\u062d\u0633\u064a\u0646"
  ),
  chart_gap_achieved = list(en = "Achieved", ar = "\u0627\u0644\u0645\u062d\u0642\u0642"),
  chart_gap_gap = list(en = "Gap to 100", ar = "\u0627\u0644\u0641\u062c\u0648\u0629 \u0625\u0644\u0649 100"),
  chart_gap_xaxis = list(en = "Percentage", ar = "\u0627\u0644\u0646\u0633\u0628\u0629 \u0627\u0644\u0645\u0626\u0648\u064a\u0629"),
  chart_gap_opportunity = list(en = "-point<br>opportunity", ar = " \u0646\u0642\u0637\u0629<br>\u0641\u0631\u0635\u0629"),
  chart_radar_title = list(
    en = "<b>Competitiveness Profile Comparison</b>",
    ar = "<b>\u0645\u0642\u0627\u0631\u0646\u0629 \u0645\u0644\u0641\u0627\u062a \u0627\u0644\u062a\u0646\u0627\u0641\u0633\u064a\u0629</b>"
  ),

  # Dimension labels for charts
  dim_econ_perf = list(
    en = "Economic\nPerformance",
    ar = "\u0627\u0644\u0623\u062f\u0627\u0621\n\u0627\u0644\u0627\u0642\u062a\u0635\u0627\u062f\u064a"
  ),
  dim_gov_eff = list(
    en = "Government\nEfficiency",
    ar = "\u0643\u0641\u0627\u0621\u0629\n\u0627\u0644\u062d\u0643\u0648\u0645\u0629"
  ),
  dim_bus_eff = list(
    en = "Business\nEfficiency",
    ar = "\u0643\u0641\u0627\u0621\u0629\n\u0627\u0644\u0623\u0639\u0645\u0627\u0644"
  ),
  dim_infra = list(
    en = "Infrastructure",
    ar = "\u0627\u0644\u0628\u0646\u064a\u0629 \u0627\u0644\u062a\u062d\u062a\u064a\u0629"
  ),
  dim_overall = list(en = "Overall", ar = "\u0627\u0644\u0625\u062c\u0645\u0627\u0644\u064a"),

  # Dimension labels for charts (with <br> for radar)
  dim_econ_perf_br = list(
    en = "Economic<br>Performance",
    ar = "\u0627\u0644\u0623\u062f\u0627\u0621<br>\u0627\u0644\u0627\u0642\u062a\u0635\u0627\u062f\u064a"
  ),
  dim_gov_eff_br = list(
    en = "Government<br>Efficiency",
    ar = "\u0643\u0641\u0627\u0621\u0629<br>\u0627\u0644\u062d\u0643\u0648\u0645\u0629"
  ),
  dim_bus_eff_br = list(
    en = "Business<br>Efficiency",
    ar = "\u0643\u0641\u0627\u0621\u0629<br>\u0627\u0644\u0623\u0639\u0645\u0627\u0644"
  ),

  # Full dimension names (for bar charts / heatmap)
  dim_economic_performance = list(
    en = "Economic Performance",
    ar = "\u0627\u0644\u0623\u062f\u0627\u0621 \u0627\u0644\u0627\u0642\u062a\u0635\u0627\u062f\u064a"
  ),
  dim_government_efficiency = list(
    en = "Government Efficiency",
    ar = "\u0643\u0641\u0627\u0621\u0629 \u0627\u0644\u062d\u0643\u0648\u0645\u0629"
  ),
  dim_business_efficiency = list(
    en = "Business Efficiency",
    ar = "\u0643\u0641\u0627\u0621\u0629 \u0627\u0644\u0623\u0639\u0645\u0627\u0644"
  ),
  dim_infrastructure = list(
    en = "Infrastructure",
    ar = "\u0627\u0644\u0628\u0646\u064a\u0629 \u0627\u0644\u062a\u062d\u062a\u064a\u0629"
  ),

  # Performance levels
  perf_strong = list(en = "Strong", ar = "\u0642\u0648\u064a"),
  perf_good = list(en = "Good", ar = "\u062c\u064a\u062f"),
  perf_moderate = list(en = "Moderate", ar = "\u0645\u062a\u0648\u0633\u0637"),

  # Language toggle
  lang_toggle_label = list(en = "\u0639\u0631\u0628\u064a", ar = "English"),

  # GCC Average label
  gcc_average = list(en = "GCC Average", ar = "\u0645\u062a\u0648\u0633\u0637 \u0627\u0644\u0645\u062c\u0644\u0633"),
  gcc_weighted_label = list(en = "GCC (Weighted)", ar = "\u0627\u0644\u0645\u062c\u0644\u0633 (\u0645\u0631\u062c\u062d)"),
  gcc_simple_label = list(en = "GCC (Simple)", ar = "\u0627\u0644\u0645\u062c\u0644\u0633 (\u0628\u0633\u064a\u0637)"),
  gcc_gdp_weighted_display = list(en = "GCC (GDP-Weighted)", ar = "\u0627\u0644\u0645\u062c\u0644\u0633 (\u0645\u0631\u062c\u062d \u0628\u0627\u0644\u0646\u0627\u062a\u062c)"),
  gcc_simple_avg_display = list(en = "GCC (Simple Avg)", ar = "\u0627\u0644\u0645\u062c\u0644\u0633 (\u0645\u062a\u0648\u0633\u0637 \u0628\u0633\u064a\u0637)")
)

# -- Core lookup function -----------------------------------------------------

#' Translate a single key
#' @param key  Character. Key from .translations list.
#' @param lang Character. "en" or "ar".
#' @return     Character string in the requested language.
t <- function(key, lang = "en") {
  lang <- match.arg(lang, c("en", "ar"))
  entry <- .translations[[key]]
  if (is.null(entry)) {
    warning(sprintf("[translations] Key '%s' not found. Returning key as fallback.", key))
    return(key)
  }
  entry[[lang]]
}

# -- Country names -------------------------------------------------------------

.country_translations <- c(
  "Bahrain"      = "\u0627\u0644\u0628\u062d\u0631\u064a\u0646",
  "Kuwait"       = "\u0627\u0644\u0643\u0648\u064a\u062a",
  "Oman"         = "\u0639\u064f\u0645\u0627\u0646",
  "Qatar"        = "\u0642\u0637\u0631",
  "Saudi Arabia" = "\u0627\u0644\u0645\u0645\u0644\u0643\u0629 \u0627\u0644\u0639\u0631\u0628\u064a\u0629 \u0627\u0644\u0633\u0639\u0648\u062f\u064a\u0629",
  "UAE"          = "\u0627\u0644\u0625\u0645\u0627\u0631\u0627\u062a \u0627\u0644\u0639\u0631\u0628\u064a\u0629 \u0627\u0644\u0645\u062a\u062d\u062f\u0629",
  "GCC"          = "\u062f\u0648\u0644 \u0645\u062c\u0644\u0633 \u0627\u0644\u062a\u0639\u0627\u0648\u0646 \u0627\u0644\u062e\u0644\u064a\u062c\u064a",
  "GCC Average"  = "\u0645\u062a\u0648\u0633\u0637 \u0627\u0644\u0645\u062c\u0644\u0633"
)

#' Translate a country name
#' @param name Character. English country name.
#' @param lang Character. "en" or "ar".
#' @return     Character.
translate_country <- function(name, lang = "en") {
  if (lang == "en") return(name)
  ar <- .country_translations[name]
  if (is.na(ar)) {
    warning(sprintf("[translations] Country '%s' not in dictionary.", name))
    return(name)
  }
  unname(ar)
}

#' Translate a vector of country names
translate_countries <- function(names, lang = "en") {
  vapply(names, translate_country, character(1), lang = lang, USE.NAMES = FALSE)
}

# -- Layout helpers ------------------------------------------------------------

#' Return the text direction for CSS
get_direction <- function(lang = "en") {
  if (lang == "ar") "rtl" else "ltr"
}

#' Return the CSS font-family string appropriate for the language
get_font <- function(lang = "en") {
  if (lang == "ar") {
    "'Cairo', 'Tajawal', 'Noto Sans Arabic', Arial, sans-serif"
  } else {
    "'Inter', 'Playfair Display', Arial, sans-serif"
  }
}

#' Return the text-align value for the language
get_text_align <- function(lang = "en") {
  if (lang == "ar") "right" else "left"
}
