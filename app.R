# ============================================================================
# GCC COMPETITIVENESS DATA STORY - SCROLLYTELLING DASHBOARD
# "Stronger Together: How the GCC Became a Global Economic Force"
# 
# Structure:
#   app.R         - This file (UI + Server)
#   R/            - R modules (data_loader.R, charts.R)
#   www/css/      - Stylesheets (main.css, themes.css, components.css)
#   www/js/       - JavaScript (scroll.js)
#   www/images/   - Background images and assets
# ============================================================================

library(shiny)
library(bslib)
library(plotly)
library(dplyr)
library(tidyr)
library(scales)
library(shinyWidgets)

# ============================================================================
# LOAD MODULES
# ============================================================================
source("R/data_loader.R")
source("R/charts.R")

# ============================================================================
# LOGO URLS
# ============================================================================
logo_white <- "https://gccstat.org/images/gccstat/logo/GCC-MAIN-01-WHITE.png"
logo_black <- "https://gccstat.org/images/gccstat/logo/GCC-MAIN-01-BLACK.png"

# ============================================================================
# UI
# ============================================================================

ui <- page_fillable(
  theme = bs_theme(
    version = 5,
    bootswatch = "flatly",
    primary = "#1a5276",
    secondary = "#B8A358",
    base_font = font_google("Inter"),
    heading_font = font_google("Playfair Display")
  ),
  
  # Include embedded CSS (for reliable rendering on Posit Connect Cloud)
  tags$head(
    tags$style(HTML("
      /* ============================================================================
         EMBEDDED CSS - GCC Competitiveness Dashboard
         ============================================================================ */
      
      /* CSS Variables */
      :root {
        --color-primary: #1a5276;
        --color-secondary: #2980b9;
        --color-accent: #B8A358;
        --color-dark: #1a1a1a;
        --color-light: #f8f9fa;
        --color-text: #333333;
      }
      
      /* Reset and base */
      * { box-sizing: border-box; }
      
      /* Scrollytelling container */
      .story-container {
        scroll-snap-type: y mandatory;
        overflow-y: scroll;
        height: 100vh;
        scroll-behavior: smooth;
      }
      
      /* Story sections */
      .story-section {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2rem;
        scroll-snap-align: start;
        position: relative;
      }
      
      /* Section themes */
      .section-hero {
        background: linear-gradient(135deg, #1a5276 0%, #2980b9 100%);
        color: white;
      }
      
      .section-light {
        background: #f8f9fa;
      }
      
      .section-dark {
        background: #1a5276;
        color: white;
      }
      
      .section-dark h2 { color: white; }
      .section-dark p { color: rgba(255,255,255,0.9); }
      
      .section-gold {
        background: linear-gradient(135deg, #B8A358 0%, #d4c17a 100%);
        color: #1a1a1a;
      }
      
      /* Content wrapper */
      .content-wrapper {
        max-width: 1400px;
        width: 100%;
        display: grid;
        grid-template-columns: 1fr 1.5fr;
        gap: 3rem;
        align-items: center;
      }
      
      .content-wrapper.centered {
        grid-template-columns: 1fr;
        text-align: center;
        max-width: 900px;
      }
      
      .content-wrapper.reversed {
        grid-template-columns: 1.5fr 1fr;
      }
      
      /* Typography */
      .narrative-text {
        font-size: 1.2rem;
        line-height: 1.8;
      }
      
      .narrative-text h2 {
        font-size: 2.5rem;
        margin-bottom: 1.5rem;
        font-weight: 700;
        color: #1a5276;
      }
      
      .narrative-text .lead {
        font-size: 1.4rem;
        opacity: 0.9;
      }
      
      .narrative-text p {
        color: #333;
        margin-bottom: 1rem;
      }
      
      /* Hero section */
      .hero-title {
        font-size: 4rem;
        font-weight: 700;
        margin-bottom: 1rem;
        color: white !important;
      }
      
      .hero-subtitle {
        font-size: 1.5rem;
        opacity: 0.9;
        margin-bottom: 2rem;
      }
      
      /* Big number (key fact) */
      .big-number {
        font-size: 8rem;
        font-weight: 700;
        line-height: 1;
        color: #1a5276;
      }
      
      .big-number-label {
        font-size: 1.5rem;
        text-transform: uppercase;
        letter-spacing: 2px;
        margin-top: 1rem;
      }
      
      /* Chart container */
      .chart-container {
        background: white;
        border-radius: 12px;
        padding: 1.5rem;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
      }
      
      /* Callout box */
      .callout-box {
        background: rgba(184, 163, 88, 0.15);
        border-left: 4px solid #B8A358;
        padding: 1.5rem;
        margin: 1.5rem 0;
        border-radius: 0 8px 8px 0;
      }
      
      .callout-box p { margin: 0; color: #333; }
      
      /* Control panel */
      .control-panel {
        background: #f0f0f0;
        padding: 1rem;
        border-radius: 8px;
        margin-top: 1.5rem;
      }
      
      .control-panel-title {
        font-weight: 600;
        margin-bottom: 0.75rem;
      }
      
      .control-row {
        display: flex;
        align-items: center;
        gap: 1rem;
      }
      
      /* Recommendation cards */
      .recommendation-card {
        background: white;
        padding: 1.5rem;
        border-radius: 12px;
        margin-bottom: 1rem;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      }
      
      .recommendation-card h4 {
        color: #1a5276;
        margin-bottom: 0.5rem;
      }
      
      .recommendation-card p {
        margin: 0;
        color: #333 !important;
      }
      
      /* Country dots */
      .country-dot {
        display: inline-block;
        width: 12px;
        height: 12px;
        border-radius: 50%;
        margin-right: 8px;
      }
      
      .country-dot.uae { background: #000000; }
      .country-dot.qatar { background: #99154C; }
      .country-dot.saudi { background: #008035; }
      .country-dot.bahrain { background: #E20000; }
      .country-dot.oman { background: #a3a3a3; }
      .country-dot.kuwait { background: #00B1E6; }
      
      /* Navigation dots */
      .nav-dots {
        position: fixed;
        right: 2rem;
        top: 50%;
        transform: translateY(-50%);
        z-index: 1000;
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
      }
      
      .nav-dot {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background: rgba(255,255,255,0.4);
        border: 2px solid white;
        cursor: pointer;
        transition: all 0.3s ease;
      }
      
      .nav-dot:hover, .nav-dot.active {
        background: #B8A358;
        transform: scale(1.3);
      }
      
      /* Scroll indicator */
      .scroll-indicator {
        position: absolute;
        bottom: 2rem;
        left: 50%;
        transform: translateX(-50%);
        animation: bounce 2s infinite;
      }
      
      @keyframes bounce {
        0%, 20%, 50%, 80%, 100% { transform: translateX(-50%) translateY(0); }
        40% { transform: translateX(-50%) translateY(-10px); }
        60% { transform: translateX(-50%) translateY(-5px); }
      }
      
      /* Footer */
      .dashboard-footer {
        background: #1a1a1a;
        color: white;
        padding: 2rem;
        text-align: center;
        min-height: auto !important;
      }
      
      .footer-text {
        font-size: 0.9rem;
        opacity: 0.7;
        margin: 0;
      }
      
      /* Responsive */
      @media (max-width: 992px) {
        .content-wrapper {
          grid-template-columns: 1fr !important;
          gap: 2rem;
        }
        .hero-title { font-size: 2.5rem; }
        .big-number { font-size: 5rem; }
        .nav-dots { right: 1rem; }
      }
    "))
  ),
  
  # Include embedded JavaScript (for reliable rendering on Posit Connect Cloud)
  tags$script(HTML("
    $(document).ready(function() {
      // Update active nav dot on scroll
      $('.story-container').on('scroll', function() {
        var sections = $('.story-section');
        var scrollPos = $(this).scrollTop();
        var windowHeight = $(window).height();
        
        sections.each(function(i) {
          var top = $(this).position().top;
          if (top <= windowHeight/2 && top > -windowHeight/2) {
            $('.nav-dot').removeClass('active');
            $('.nav-dot').eq(i).addClass('active');
          }
        });
      });
      
      // Click nav dot to scroll to section
      $('.nav-dot').on('click', function() {
        var index = $(this).index();
        var target = $('.story-section').eq(index);
        $('.story-container').animate({
          scrollTop: target.position().top + $('.story-container').scrollTop()
        }, 800);
      });
      
      // Scroll indicator click
      $('.scroll-indicator').on('click', function() {
        $('.nav-dot').eq(1).click();
      });
    });
  ")),
  
  # Navigation dots
  div(class = "nav-dots",
      div(class = "nav-dot active", title = "Introduction"),
      div(class = "nav-dot", title = "Global Ranking"),
      div(class = "nav-dot", title = "The Journey"),
      div(class = "nav-dot", title = "Key Fact"),
      div(class = "nav-dot", title = "Strengths"),
      div(class = "nav-dot", title = "Dimension Comparison"),
      div(class = "nav-dot", title = "Country Profiles"),
      div(class = "nav-dot", title = "Gap Analysis"),
      div(class = "nav-dot", title = "2030 Horizon")
  ),
  
  # Main scrolling container
  div(class = "story-container",
      
      # ====== SECTION 1: HERO ======
      div(class = "story-section section-hero", id = "section-hero",
          # Logo - LARGE WHITE (dark background)
          div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
              tags$img(src = logo_white, style = "max-width: 200px; height: auto;", alt = "GCC-Stat Logo")
          ),
          div(class = "content-wrapper centered",
              div(class = "narrative-text",
                  h1(class = "hero-title", "STRONGER TOGETHER"),
                  p(class = "hero-subtitle", 
                    "How the GCC Became a Global Economic Force"),
                  hr(style = "border-color: rgba(255,255,255,0.3); width: 100px; margin: 2rem auto;"),
                  p(class = "lead", "IMD World Competitiveness Ranking 2025"),
                  p(style = "margin-top: 3rem; opacity: 0.7;", "Scroll to explore the data story"),
                  div(class = "scroll-indicator",
                      tags$svg(width = "40", height = "40", viewBox = "0 0 24 24", 
                               fill = "none", stroke = "currentColor", `stroke-width` = "2",
                               tags$path(d = "M12 5v14M19 12l-7 7-7-7")))
              )
          )
      ),
      
      # ====== SECTION 2: GLOBAL RANKING ======
      div(class = "story-section section-light", id = "section-ranking",
          # Logo - SMALL BLACK (light background)
          div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
              tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
          ),
          div(class = "content-wrapper",
              div(class = "narrative-text",
                  h2("If the GCC Were a Single Country..."),
                  p("With a combined GDP of $2.2 trillion, the six Gulf Cooperation 
                    Council nations have achieved what few regional blocs can claim: 
                    competitiveness that rivals established economic powerhouses."),
                  div(class = "callout-box",
                      p(style = "margin: 0; font-weight: 600;",
                        "Our analysis reveals that when treated as a unified entity, 
                        the GCC scores 84.9 out of 100—placing it ahead of the 
                        United States, Finland, and Iceland.")
                  ),
                  # Aggregation method toggle
                  div(class = "control-panel",
                      p(class = "control-panel-title", "Aggregation Method:"),
                      div(class = "control-row",
                          span("Simple Average", style = "font-size: 0.9rem;"),
                          switchInput(
                            inputId = "use_gdp_weighted",
                            value = TRUE,
                            onLabel = "GDP",
                            offLabel = "Avg",
                            onStatus = "primary",
                            size = "normal"
                          ),
                          span("GDP-Weighted", style = "font-size: 0.9rem;")
                      ),
                      uiOutput("method_explanation")
                  )
              ),
              div(class = "chart-container",
                  p(style = "font-size: 0.85rem; color: #666; margin-bottom: 0.5rem;",
                    "Use the slider below the chart to explore all 69 countries"),
                  plotlyOutput("chart_world_ranking", height = "500px")
              )
          )
      ),
      
      # ====== SECTION 3: THE JOURNEY ======
      div(class = "story-section section-light", id = "section-journey",
          # Logo - SMALL BLACK (light background)
          div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
              tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
          ),
          div(class = "content-wrapper reversed",
              div(class = "chart-container",
                  div(style = "margin-bottom: 1rem;",
                      pickerInput(
                        inputId = "highlight_countries",
                        label = "Highlight Countries:",
                        choices = c("UAE", "Qatar", "Saudi Arabia", 
                                    "Bahrain", "Kuwait", "Oman", "GCC Average"),
                        selected = c("UAE", "Qatar", "Saudi Arabia", 
                                     "Bahrain", "Kuwait", "Oman", "GCC Average"),
                        multiple = TRUE,
                        options = list(
                          `actions-box` = TRUE,
                          `selected-text-format` = "count > 2",
                          `count-selected-text` = "{0} countries selected"
                        ),
                        width = "100%"
                      )
                  ),
                  plotlyOutput("chart_trajectory", height = "450px")
              ),
              div(class = "narrative-text",
                  h2("Remarkable Trajectories"),
                  p("Between 2021 and 2025, the GCC demonstrated unprecedented upward momentum."),
                  tags$ul(style = "list-style: none; padding: 0;",
                          tags$li(style = "margin-bottom: 1rem;",
                                  span(class = "country-dot uae"),
                                  tags$strong("UAE"), " climbed from 9th to 5th place"),
                          tags$li(style = "margin-bottom: 1rem;",
                                  span(class = "country-dot qatar"),
                                  tags$strong("Qatar"), " surged eight positions to reach 9th globally"),
                          tags$li(style = "margin-bottom: 1rem;",
                                  span(class = "country-dot saudi"),
                                  tags$strong("Saudi Arabia"), " achieved the region's most dramatic 
                             transformation—leaping 15 positions from 32nd to 17th")
                  ),
                  p("Even relative newcomers to the survey like Bahrain, Kuwait, 
                    and Oman have quickly established themselves in the global top 40.")
              )
          )
      ),
      
      # ====== SECTION 4: KEY FACT ======
      div(class = "story-section section-gold", id = "section-fact",
          # Logo - SMALL BLACK (gold/light background)
          div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
              tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
          ),
          div(class = "content-wrapper centered",
              div(class = "narrative-text",
                  p(style = "text-transform: uppercase; letter-spacing: 3px; font-size: 1rem;",
                    "Did You Know?"),
                  div(class = "big-number", style = "color: #1a5276;", "3"),
                  p(class = "big-number-label", style = "color: #1a5276;",
                    "GCC Countries in the Global Top 20"),
                  hr(style = "border-color: rgba(0,0,0,0.2); width: 100px; margin: 2rem auto;"),
                  p(style = "font-size: 1.3rem; max-width: 600px; margin: 0 auto;",
                    "UAE, Qatar, and Saudi Arabia now rank in the global top 20—a 
                    remarkable concentration of competitiveness in a region of 
                    just 60 million people.")
              )
          )
      ),
      
      # ====== SECTION 5: SECRET WEAPONS ======
      div(class = "story-section section-light", id = "section-strengths",
          # Logo - SMALL BLACK (light background)
          div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
              tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
          ),
          div(class = "content-wrapper",
              div(class = "narrative-text",
                  h2("Business Efficiency & Government Effectiveness"),
                  p(class = "lead", "The GCC's Secret Weapons"),
                  p("The GCC's success isn't uniform—it's strategic. The region 
                    scores highest in Business Efficiency (82.6, ranking 11th 
                    globally) and Government Efficiency (74.9, ranking 13th)."),
                  p("This reflects decades of investment in streamlined regulations, 
                    low corporate taxation, and adaptive governance. These are the 
                    foundations that have attracted trillion-dollar foreign investment 
                    and positioned the GCC as a global business hub.")
              ),
              div(class = "chart-container",
                  plotlyOutput("chart_dimensions", height = "450px")
              )
          )
      ),
      
      # ====== SECTION 5B: RADAR COMPARISON ======
      div(class = "story-section section-light", id = "section-radar",
          # Logo - SMALL BLACK (light background)
          div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
              tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
          ),
          div(class = "content-wrapper",
              div(class = "narrative-text",
                  h2("Dimension Deep Dive"),
                  p(class = "lead", "Compare GCC with Individual Countries"),
                  p("Explore how individual GCC countries perform across the four 
                    competitiveness dimensions compared to the regional aggregate."),
                  p("Select a country to see its strengths and areas for improvement 
                    relative to the GDP-weighted GCC benchmark."),
                  div(class = "control-panel",
                      p(class = "control-panel-title", "Select Country to Compare:"),
                      selectInput(
                        inputId = "radar_country",
                        label = NULL,
                        choices = c("UAE", "Qatar", "Saudi Arabia", 
                                    "Bahrain", "Kuwait", "Oman"),
                        selected = "UAE",
                        width = "100%"
                      ),
                      uiOutput("radar_comparison_summary")
                  )
              ),
              div(class = "chart-container",
                  plotlyOutput("chart_radar_comparison", height = "450px")
              )
          )
      ),
      
      # ====== SECTION 6: COUNTRY PROFILES ======
      div(class = "story-section section-light", id = "section-profiles",
          # Logo - SMALL BLACK (light background)
          div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
              tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
          ),
          div(class = "content-wrapper reversed",
              div(class = "chart-container",
                  plotlyOutput("chart_heatmap", height = "500px")
              ),
              div(class = "narrative-text",
                  h2("Six Nations, Complementary Strengths"),
                  p("While united in upward trajectory, each GCC country brings 
                    unique strengths to the regional competitiveness profile."),
                  tags$ul(style = "list-style: none; padding: 0;",
                          tags$li(style = "margin-bottom: 1rem;",
                                  span(class = "country-dot uae"),
                                  tags$strong("UAE"), " leads in overall performance and economic dynamism"),
                          tags$li(style = "margin-bottom: 1rem;",
                                  span(class = "country-dot qatar"),
                                  tags$strong("Qatar"), " excels in business efficiency and government effectiveness"),
                          tags$li(style = "margin-bottom: 1rem;",
                                  span(class = "country-dot saudi"),
                                  tags$strong("Saudi Arabia's"), " massive economy provides scale and diversification")
                  ),
                  p("Together, they create a complementary ecosystem where investors 
                    can find exactly the competitive advantages they need.")
              )
          )
      ),
      
      # ====== SECTION 7: GAP ANALYSIS ======
      div(class = "story-section section-light", id = "section-gap",
          # Logo - SMALL BLACK (light background)
          div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
              tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
          ),
          div(class = "content-wrapper",
              div(class = "narrative-text",
                  h2("GCC Scores by Dimension"),
                  p("When we weight countries by their economic size, Saudi Arabia's 
                    massive $1.1 trillion economy significantly influences the 
                    regional picture."),
                  p("This GDP-weighted analysis shows that while smaller nations 
                    like UAE and Qatar punch above their weight in rankings, 
                    Saudi Arabia's scale and improving performance define the 
                    region's aggregate competitiveness."),
                  div(class = "callout-box",
                      p(style = "margin: 0;",
                        tags$strong("The gap analysis reveals clear opportunities: "),
                        "infrastructure development and continued economic 
                        diversification could push the unified GCC score above 90.")
                  )
              ),
              div(class = "chart-container",
                  plotlyOutput("chart_gap", height = "400px")
              )
          )
      ),
      
      # ====== SECTION 8: 2030 HORIZON ======
      div(class = "story-section section-dark", id = "section-future",
          # Logo - SMALL WHITE (dark background)
          div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
              tags$img(src = logo_white, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
          ),
          div(class = "content-wrapper",
              div(class = "narrative-text",
                  h2("The 2030 Horizon"),
                  p(class = "lead", "Can the GCC Break Into the Global Top 10?"),
                  p("Current trajectories suggest the GCC isn't finished climbing. 
                    With strategic focus on three areas—infrastructure modernization, 
                    R&D investment, and sustainable development—the region could 
                    achieve a unified score above 90 by 2030."),
                  p("The foundation is solid: world-class business environments, 
                    efficient governments, and the financial resources to invest 
                    in future competitiveness.")
              ),
              div(
                  h4(style = "color: #B8A358; margin-bottom: 1.5rem;", 
                     "Strategic Recommendations"),
                  div(class = "recommendation-card",
                      h4("🏗️ Infrastructure Investment"),
                      p(style = "margin: 0; font-style: italic; color: #333;", 
                        "\"Close the 15-point gap by accelerating R&D spending, 
                        digital infrastructure, and green energy transitions\"")
                  ),
                  div(class = "recommendation-card",
                      h4("🌱 Sustainability Leadership"),
                      p(style = "margin: 0; font-style: italic; color: #333;",
                        "\"Transform environmental challenges into competitive advantages 
                        through aggressive renewable energy deployment\"")
                  ),
                  div(class = "recommendation-card",
                      h4("🎓 Human Capital Development"),
                      p(style = "margin: 0; font-style: italic; color: #333;",
                        "\"Strengthen higher education systems and STEM capabilities 
                        to reduce dependency on imported talent\"")
                  ),
                  div(class = "recommendation-card",
                      h4("🤝 Regional Integration"),
                      p(style = "margin: 0; font-style: italic; color: #333;",
                        "\"Deepen economic cooperation to create true economies of 
                        scale across the $2.2 trillion GCC market\"")
                  )
              )
          )
      ),
      
      # ====== FOOTER ======
      div(class = "dashboard-footer", id = "section-footer",
          tags$img(src = logo_white, style = "max-width: 150px; height: auto; margin-bottom: 1rem;", alt = "GCC-Stat Logo"),
          p(class = "footer-text", "GCC Statistical Center | IMD World Competitiveness Ranking 2025"),
          p(class = "footer-text", style = "margin-top: 0.5rem;", "Data story prepared by the Economic Statistics Department")
      )
      
  ) # End story-container
) # End page_fillable


# ============================================================================
# SERVER
# ============================================================================

server <- function(input, output, session) {
  
  # Load data (reactive for future API integration)
  wcr_data <- reactive({
    load_wcr_data()
  })
  
  # Reactive: Get selected aggregation method
  gcc_method <- reactive({
    if(input$use_gdp_weighted) "GCC (Weighted)" else "GCC (Simple)"
  })
  
  # Chart 1: World Ranking (with aggregation toggle)
  output$chart_world_ranking <- renderPlotly({
    create_world_ranking_chart(wcr_data(), gcc_method = gcc_method())
  })
  
  # Method explanation text
  output$method_explanation <- renderUI({
    if(input$use_gdp_weighted) {
      div(style = "margin-top: 0.75rem; font-size: 0.85rem; color: #555;",
          HTML("<b>GDP weights:</b> SAU 50% | UAE 25% | QAT 10% | KWT 7% | OMN 5% | BHR 2%"),
          br(),
          "Saudi Arabia's $1.1 trillion economy significantly influences the regional aggregate."
      )
    } else {
      div(style = "margin-top: 0.75rem; font-size: 0.85rem; color: #555;",
          HTML("<b>Simple average:</b> All 6 countries weighted equally"),
          br(),
          "Smaller high-performers (UAE, Qatar) have equal influence to larger economies."
      )
    }
  })
  
  # Chart 2: Trajectory (with country highlight)
  output$chart_trajectory <- renderPlotly({
    selected <- input$highlight_countries
    if(is.null(selected) || length(selected) == 0 || length(selected) == 7) {
      selected <- "All"
    }
    create_trajectory_chart(wcr_data(), highlight = selected)
  })
  
  # Chart 3: Dimensions
  output$chart_dimensions <- renderPlotly({
    create_dimensions_chart(wcr_data())
  })
  
  # Chart 4: Heatmap
  output$chart_heatmap <- renderPlotly({
    create_heatmap_chart(wcr_data())
  })
  
  # Chart 5: Gap Analysis (with aggregation toggle)
  output$chart_gap <- renderPlotly({
    create_gap_chart(wcr_data(), gcc_method = gcc_method())
  })
  
  # Chart 6: Radar Comparison
  output$chart_radar_comparison <- renderPlotly({
    create_overlay_radar_chart(
      wcr_data(), 
      selected_country = input$radar_country,
      gcc_method = gcc_method()
    )
  })
  
  # Radar comparison summary
  output$radar_comparison_summary <- renderUI({
    req(input$radar_country)
    
    data <- wcr_data()$factors_2025
    gcc_data <- data %>% filter(Country == gcc_method())
    country_data <- data %>% filter(Country == input$radar_country)
    
    dims <- c("EconPerf_Score", "GovEff_Score", "BusEff_Score", "Infra_Score")
    dim_names <- c("Economic Performance", "Government Efficiency", 
                   "Business Efficiency", "Infrastructure")
    
    diffs <- sapply(dims, function(d) country_data[[d]] - gcc_data[[d]])
    names(diffs) <- dim_names
    
    best <- names(diffs)[which.max(diffs)]
    best_val <- round(max(diffs), 1)
    weakest <- names(diffs)[which.min(diffs)]
    weakest_val <- round(min(diffs), 1)
    overall_diff <- round(country_data$Overall_Score - gcc_data$Overall_Score, 1)
    
    div(style = "margin-top: 1rem; font-size: 0.9rem;",
        p(style = "margin-bottom: 0.5rem;",
          tags$strong(input$radar_country), " vs ", tags$strong(gcc_method()), ":"
        ),
        tags$ul(style = "margin: 0; padding-left: 1.2rem;",
                tags$li("Overall: ", 
                        span(style = paste0("color: ", if(overall_diff >= 0) "#27ae60" else "#e74c3c", ";"),
                             if(overall_diff >= 0) paste0("+", overall_diff) else overall_diff),
                        " points"),
                tags$li("Strongest: ", best, " (",
                        span(style = "color: #27ae60;", paste0("+", best_val)), ")"),
                tags$li("Gap: ", weakest, " (",
                        span(style = "color: #e74c3c;", weakest_val), ")")
        )
    )
  })
  
}

# ============================================================================
# RUN APP
# ============================================================================
shinyApp(ui = ui, server = server)
