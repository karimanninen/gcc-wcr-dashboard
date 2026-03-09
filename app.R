# ============================================================================
# GCC COMPETITIVENESS DATA STORY - SCROLLYTELLING DASHBOARD
# "Stronger Together: How the GCC Became a Global Economic Force"
#
# Structure:
#   app.R         - This file (UI + Server)
#   R/            - R modules (data_loader.R, charts.R, translations.R)
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
source("R/translations.R")

# ============================================================================
# LOGO URLS
# ============================================================================
logo_white <- "images/GCC-MAIN-01-WHITE.png"
logo_black <- "images/GCC-MAIN-01-BLACK.png"

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

  # Include embedded CSS
  tags$head(
    # Google Fonts for Arabic
    tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700&family=Tajawal:wght@300;400;500;700&display=swap"),
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
        cursor: pointer;
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

      /* Language toggle button */
      .lang-toggle-btn {
        position: fixed;
        top: 1.5rem;
        right: 1.5rem;
        z-index: 9999;
        padding: 6px 16px;
        border-radius: 20px;
        border: 2px solid rgba(255,255,255,0.8);
        background: rgba(255,255,255,0.15);
        color: white;
        font-size: 14px;
        cursor: pointer;
        font-family: 'Cairo', 'Tajawal', 'Inter', Arial, sans-serif;
        font-weight: 600;
        transition: all 0.3s ease;
        backdrop-filter: blur(10px);
      }

      .lang-toggle-btn:hover {
        background: rgba(255,255,255,0.3);
        transform: scale(1.05);
      }

      /* RTL-specific callout box */
      body.lang-ar .callout-box {
        border-left: none;
        border-right: 4px solid #B8A358;
        border-radius: 8px 0 0 8px;
      }

      /* RTL: Arabic font overrides */
      body.lang-ar .narrative-text,
      body.lang-ar .narrative-text p,
      body.lang-ar .narrative-text h2,
      body.lang-ar .narrative-text .lead,
      body.lang-ar .hero-title,
      body.lang-ar .hero-subtitle,
      body.lang-ar .big-number-label,
      body.lang-ar .control-panel-title,
      body.lang-ar .recommendation-card h4,
      body.lang-ar .recommendation-card p,
      body.lang-ar .footer-text,
      body.lang-ar .callout-box p {
        font-family: 'Cairo', 'Tajawal', Arial, sans-serif;
        direction: rtl;
        text-align: right;
      }

      body.lang-ar .narrative-text h2 {
        font-family: 'Cairo', 'Tajawal', Arial, sans-serif;
        letter-spacing: 0;
      }

      body.lang-ar .hero-title {
        font-family: 'Cairo', 'Tajawal', Arial, sans-serif;
        letter-spacing: 0;
      }

      /* RTL: centered sections keep center alignment */
      body.lang-ar .content-wrapper.centered .narrative-text,
      body.lang-ar .content-wrapper.centered .narrative-text p,
      body.lang-ar .content-wrapper.centered .narrative-text h2,
      body.lang-ar .content-wrapper.centered .narrative-text .lead,
      body.lang-ar .content-wrapper.centered .hero-title,
      body.lang-ar .content-wrapper.centered .hero-subtitle,
      body.lang-ar .content-wrapper.centered .big-number-label {
        text-align: center;
      }

      body.lang-ar .dashboard-footer,
      body.lang-ar .footer-text {
        text-align: center;
      }

      /* RTL: country dot margins */
      body.lang-ar .country-dot {
        margin-right: 0;
        margin-left: 8px;
      }

      /* RTL: nav dots on left side */
      body.lang-ar .nav-dots {
        right: auto;
        left: 2rem;
      }

      /* RTL: form controls */
      body.lang-ar .form-control,
      body.lang-ar select.form-control,
      body.lang-ar .bootstrap-select .dropdown-toggle,
      body.lang-ar .bootstrap-select .dropdown-menu {
        direction: rtl;
        text-align: right;
        font-family: 'Cairo', 'Tajawal', Arial, sans-serif;
      }

      body.lang-ar .control-label,
      body.lang-ar label {
        direction: rtl;
        text-align: right;
        font-family: 'Cairo', 'Tajawal', Arial, sans-serif;
      }

      /* RTL: control row */
      body.lang-ar .control-row {
        flex-direction: row-reverse;
      }

      /* RTL: body-level line-height for Arabic */
      body.lang-ar {
        line-height: 1.8;
      }

      /* RTL: generic heading coverage (h1-h6) */
      body.lang-ar h1,
      body.lang-ar h2,
      body.lang-ar h3,
      body.lang-ar h4,
      body.lang-ar h5,
      body.lang-ar h6 {
        direction: rtl;
        font-family: 'Cairo', 'Tajawal', Arial, sans-serif;
        font-weight: 600;
        letter-spacing: 0;
      }

      /* RTL: generic text elements */
      body.lang-ar p,
      body.lang-ar li,
      body.lang-ar span,
      body.lang-ar strong {
        font-family: 'Cairo', 'Tajawal', Arial, sans-serif;
      }

      /* RTL: logo positioning - flip to right side */
      body.lang-ar .story-section > div:first-child[style*="left: 1.5rem"] {
        left: auto !important;
        right: 1.5rem;
      }

      /* RTL: lang toggle button moves to left */
      body.lang-ar .lang-toggle-btn {
        right: auto;
        left: 1.5rem;
      }

      /* RTL: list items with country dots */
      body.lang-ar ul[style*="list-style: none"] li {
        direction: rtl;
        text-align: right;
      }

      /* RTL: shinyWidgets pickerInput */
      body.lang-ar .bootstrap-select .filter-option-inner-inner,
      body.lang-ar .bootstrap-select .dropdown-item,
      body.lang-ar .bootstrap-select .bs-actionsbox .btn-group button,
      body.lang-ar .bootstrap-select .dropdown-header {
        direction: rtl;
        text-align: right;
        font-family: 'Cairo', 'Tajawal', Arial, sans-serif;
      }

      /* RTL: shinyWidgets switchInput - keep LTR layout */
      body.lang-ar .bootstrap-switch {
        direction: ltr;
      }

      /* RTL: selectize inputs */
      body.lang-ar .selectize-input,
      body.lang-ar .selectize-dropdown,
      body.lang-ar .selectize-dropdown-content .option {
        direction: rtl;
        text-align: right;
        font-family: 'Cairo', 'Tajawal', Arial, sans-serif;
      }

      /* RTL: chart container hints/labels */
      body.lang-ar .chart-container > p {
        direction: rtl;
        text-align: right;
        font-family: 'Cairo', 'Tajawal', Arial, sans-serif;
      }

      /* Plotly charts stay LTR internally */
      body.lang-ar .plotly-graph-div {
        direction: ltr !important;
      }

      /* Plotly chart titles get Arabic font */
      body.lang-ar .plotly-chart-title,
      body.lang-ar .js-plotly-plot .plotly .gtitle {
        font-family: 'Cairo', 'Tajawal', Arial, sans-serif !important;
      }

      /* RTL: recommendation cards in section 8 */
      body.lang-ar .recommendation-card {
        direction: rtl;
        text-align: right;
      }

      /* RTL: big number section stays centered */
      body.lang-ar .big-number {
        direction: ltr; /* numbers stay LTR */
        text-align: center;
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
        body.lang-ar .nav-dots { left: 1rem; right: auto; }
        body.lang-ar .hero-title { font-size: 2.2rem; }
      }
    "))
  ),

  # Language direction JavaScript
  tags$script(HTML("
    Shiny.addCustomMessageHandler('setLang', function(lang) {
      if (lang === 'ar') {
        $('body').addClass('lang-ar').attr('dir', 'rtl');
      } else {
        $('body').removeClass('lang-ar').attr('dir', 'ltr');
      }
    });

    $(document).ready(function() {
      // Update active nav dot on scroll
      $(document).on('scroll', '.story-container', function() {
        var sections = $(this).find('.story-section');
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
      $(document).on('click', '.nav-dot', function() {
        var index = $(this).index();
        var target = $('.story-section').eq(index);
        var container = $('.story-container');
        container.animate({
          scrollTop: target.position().top + container.scrollTop()
        }, 800);
      });

      // Scroll indicator click
      $(document).on('click', '.scroll-indicator', function() {
        $('.nav-dot').eq(1).click();
      });
    });
  ")),

  # Language toggle button (fixed position, always visible)
  actionButton("lang_toggle", "", class = "lang-toggle-btn"),

  # Main content rendered dynamically for bilingual support
  uiOutput("main_ui")

) # End page_fillable


# ============================================================================
# SERVER
# ============================================================================

server <- function(input, output, session) {

  # Load data
  wcr_data <- reactive({
    load_wcr_data()
  })

  # --------------------------------------------------------------------------
  # Language state
  # --------------------------------------------------------------------------
  current_lang <- reactiveVal("en")

  observeEvent(input$lang_toggle, {
    new_lang <- if (current_lang() == "en") "ar" else "en"
    current_lang(new_lang)
  })

  observe({
    session$sendCustomMessage("setLang", current_lang())
  })

  # Update language toggle button label
  observe({
    lang <- current_lang()
    updateActionButton(session, "lang_toggle", label = t("lang_toggle_label", lang))
  })

  # --------------------------------------------------------------------------
  # Main UI (rebuilt on language change)
  # --------------------------------------------------------------------------
  output$main_ui <- renderUI({
    lang <- current_lang()

    tagList(
      # Navigation dots
      div(class = "nav-dots",
          div(class = "nav-dot active", title = t("nav_intro", lang)),
          div(class = "nav-dot", title = t("nav_ranking", lang)),
          div(class = "nav-dot", title = t("nav_journey", lang)),
          div(class = "nav-dot", title = t("nav_fact", lang)),
          div(class = "nav-dot", title = t("nav_strengths", lang)),
          div(class = "nav-dot", title = t("nav_dimensions", lang)),
          div(class = "nav-dot", title = t("nav_profiles", lang)),
          div(class = "nav-dot", title = t("nav_gap", lang)),
          div(class = "nav-dot", title = t("nav_horizon", lang))
      ),

      # Main scrolling container
      div(class = "story-container",

          # ====== SECTION 1: HERO ======
          div(class = "story-section section-hero", id = "section-hero",
              div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
                  tags$img(src = logo_white, style = "max-width: 200px; height: auto;", alt = "GCC-Stat Logo")
              ),
              div(class = "content-wrapper centered",
                  div(class = "narrative-text",
                      h1(class = "hero-title", t("hero_title", lang)),
                      p(class = "hero-subtitle", t("hero_subtitle", lang)),
                      hr(style = "border-color: rgba(255,255,255,0.3); width: 100px; margin: 2rem auto;"),
                      p(class = "lead", t("hero_source", lang)),
                      p(style = "margin-top: 3rem; opacity: 0.7;", t("hero_scroll", lang)),
                      div(class = "scroll-indicator",
                          tags$svg(width = "40", height = "40", viewBox = "0 0 24 24",
                                   fill = "none", stroke = "currentColor", `stroke-width` = "2",
                                   tags$path(d = "M12 5v14M19 12l-7 7-7-7")))
                  )
              )
          ),

          # ====== SECTION 2: GLOBAL RANKING ======
          div(class = "story-section section-light", id = "section-ranking",
              div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
                  tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
              ),
              div(class = "content-wrapper",
                  div(class = "narrative-text",
                      h2(t("sec2_title", lang)),
                      p(t("sec2_body", lang)),
                      div(class = "callout-box",
                          p(style = "margin: 0; font-weight: 600;", t("sec2_callout", lang))
                      ),
                      div(class = "control-panel",
                          p(class = "control-panel-title", t("sec2_agg_method", lang)),
                          div(class = "control-row",
                              span(t("sec2_simple_avg", lang), style = "font-size: 0.9rem;"),
                              switchInput(
                                inputId = "use_gdp_weighted",
                                value = TRUE,
                                onLabel = "GDP",
                                offLabel = "Avg",
                                onStatus = "primary",
                                size = "normal"
                              ),
                              span(t("sec2_gdp_weighted", lang), style = "font-size: 0.9rem;")
                          ),
                          uiOutput("method_explanation")
                      )
                  ),
                  div(class = "chart-container",
                      p(style = "font-size: 0.85rem; color: #666; margin-bottom: 0.5rem;",
                        t("sec2_slider_hint", lang)),
                      plotlyOutput("chart_world_ranking", height = "500px")
                  )
              )
          ),

          # ====== SECTION 3: THE JOURNEY ======
          div(class = "story-section section-light", id = "section-journey",
              div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
                  tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
              ),
              div(class = "content-wrapper reversed",
                  div(class = "chart-container",
                      div(style = "margin-bottom: 1rem;",
                          pickerInput(
                            inputId = "highlight_countries",
                            label = t("sec3_highlight_label", lang),
                            choices = setNames(
                              c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Kuwait", "Oman", "GCC Average"),
                              c(translate_country("UAE", lang),
                                translate_country("Qatar", lang),
                                translate_country("Saudi Arabia", lang),
                                translate_country("Bahrain", lang),
                                translate_country("Kuwait", lang),
                                translate_country("Oman", lang),
                                t("gcc_average", lang))
                            ),
                            selected = c("UAE", "Qatar", "Saudi Arabia",
                                         "Bahrain", "Kuwait", "Oman", "GCC Average"),
                            multiple = TRUE,
                            options = list(
                              `actions-box` = TRUE,
                              `selected-text-format` = "count > 2",
                              `count-selected-text` = t("sec3_count_selected", lang)
                            ),
                            width = "100%"
                          )
                      ),
                      plotlyOutput("chart_trajectory", height = "450px")
                  ),
                  div(class = "narrative-text",
                      h2(t("sec3_title", lang)),
                      p(t("sec3_body", lang)),
                      tags$ul(style = "list-style: none; padding: 0;",
                              tags$li(style = "margin-bottom: 1rem;",
                                      span(class = "country-dot uae"),
                                      tags$strong(translate_country("UAE", lang)),
                                      t("sec3_uae", lang)),
                              tags$li(style = "margin-bottom: 1rem;",
                                      span(class = "country-dot qatar"),
                                      tags$strong(translate_country("Qatar", lang)),
                                      t("sec3_qatar", lang)),
                              tags$li(style = "margin-bottom: 1rem;",
                                      span(class = "country-dot saudi"),
                                      tags$strong(translate_country("Saudi Arabia", lang)),
                                      t("sec3_saudi", lang))
                      ),
                      p(t("sec3_others", lang))
                  )
              )
          ),

          # ====== SECTION 4: KEY FACT ======
          div(class = "story-section section-gold", id = "section-fact",
              div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
                  tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
              ),
              div(class = "content-wrapper centered",
                  div(class = "narrative-text",
                      p(style = "text-transform: uppercase; letter-spacing: 3px; font-size: 1rem;",
                        t("sec4_did_you_know", lang)),
                      div(class = "big-number", style = "color: #1a5276;", "3"),
                      p(class = "big-number-label", style = "color: #1a5276;",
                        t("sec4_label", lang)),
                      hr(style = "border-color: rgba(0,0,0,0.2); width: 100px; margin: 2rem auto;"),
                      p(style = "font-size: 1.3rem; max-width: 600px; margin: 0 auto;",
                        t("sec4_detail", lang))
                  )
              )
          ),

          # ====== SECTION 5: SECRET WEAPONS ======
          div(class = "story-section section-light", id = "section-strengths",
              div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
                  tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
              ),
              div(class = "content-wrapper",
                  div(class = "narrative-text",
                      h2(t("sec5_title", lang)),
                      p(class = "lead", t("sec5_lead", lang)),
                      p(t("sec5_body1", lang)),
                      p(t("sec5_body2", lang))
                  ),
                  div(class = "chart-container",
                      plotlyOutput("chart_dimensions", height = "450px")
                  )
              )
          ),

          # ====== SECTION 5B: RADAR COMPARISON ======
          div(class = "story-section section-light", id = "section-radar",
              div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
                  tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
              ),
              div(class = "content-wrapper",
                  div(class = "narrative-text",
                      h2(t("sec5b_title", lang)),
                      p(class = "lead", t("sec5b_lead", lang)),
                      p(t("sec5b_body1", lang)),
                      p(t("sec5b_body2", lang)),
                      div(class = "control-panel",
                          p(class = "control-panel-title", t("sec5b_select_country", lang)),
                          selectInput(
                            inputId = "radar_country",
                            label = NULL,
                            choices = setNames(
                              c("UAE", "Qatar", "Saudi Arabia", "Bahrain", "Kuwait", "Oman"),
                              c(translate_country("UAE", lang),
                                translate_country("Qatar", lang),
                                translate_country("Saudi Arabia", lang),
                                translate_country("Bahrain", lang),
                                translate_country("Kuwait", lang),
                                translate_country("Oman", lang))
                            ),
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
              div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
                  tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
              ),
              div(class = "content-wrapper reversed",
                  div(class = "chart-container",
                      plotlyOutput("chart_heatmap", height = "500px")
                  ),
                  div(class = "narrative-text",
                      h2(t("sec6_title", lang)),
                      p(t("sec6_body", lang)),
                      tags$ul(style = "list-style: none; padding: 0;",
                              tags$li(style = "margin-bottom: 1rem;",
                                      span(class = "country-dot uae"),
                                      tags$strong(translate_country("UAE", lang)),
                                      t("sec6_uae", lang)),
                              tags$li(style = "margin-bottom: 1rem;",
                                      span(class = "country-dot qatar"),
                                      tags$strong(translate_country("Qatar", lang)),
                                      t("sec6_qatar", lang)),
                              tags$li(style = "margin-bottom: 1rem;",
                                      span(class = "country-dot saudi"),
                                      tags$strong(translate_country("Saudi Arabia", lang)),
                                      t("sec6_saudi", lang))
                      ),
                      p(t("sec6_complement", lang))
                  )
              )
          ),

          # ====== SECTION 7: GAP ANALYSIS ======
          div(class = "story-section section-light", id = "section-gap",
              div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
                  tags$img(src = logo_black, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
              ),
              div(class = "content-wrapper",
                  div(class = "narrative-text",
                      h2(t("sec7_title", lang)),
                      p(t("sec7_body1", lang)),
                      p(t("sec7_body2", lang)),
                      div(class = "callout-box",
                          p(style = "margin: 0;",
                            tags$strong(t("sec7_callout", lang)))
                      )
                  ),
                  div(class = "chart-container",
                      plotlyOutput("chart_gap", height = "400px")
                  )
              )
          ),

          # ====== SECTION 8: 2030 HORIZON ======
          div(class = "story-section section-dark", id = "section-future",
              div(style = "position: absolute; top: 1.5rem; left: 1.5rem; z-index: 100;",
                  tags$img(src = logo_white, style = "max-width: 120px; height: auto;", alt = "GCC-Stat Logo")
              ),
              div(class = "content-wrapper",
                  div(class = "narrative-text",
                      h2(t("sec8_title", lang)),
                      p(class = "lead", t("sec8_lead", lang)),
                      p(t("sec8_body1", lang)),
                      p(t("sec8_body2", lang))
                  ),
                  div(
                      h4(style = "color: #B8A358; margin-bottom: 1.5rem;",
                         t("sec8_recs_title", lang)),
                      div(class = "recommendation-card",
                          h4(paste0("\U0001F3D7\uFE0F ", t("rec_infra_title", lang))),
                          p(style = "margin: 0; font-style: italic; color: #333;",
                            t("rec_infra_body", lang))
                      ),
                      div(class = "recommendation-card",
                          h4(paste0("\U0001F331 ", t("rec_sustain_title", lang))),
                          p(style = "margin: 0; font-style: italic; color: #333;",
                            t("rec_sustain_body", lang))
                      ),
                      div(class = "recommendation-card",
                          h4(paste0("\U0001F393 ", t("rec_human_title", lang))),
                          p(style = "margin: 0; font-style: italic; color: #333;",
                            t("rec_human_body", lang))
                      ),
                      div(class = "recommendation-card",
                          h4(paste0("\U0001F91D ", t("rec_integration_title", lang))),
                          p(style = "margin: 0; font-style: italic; color: #333;",
                            t("rec_integration_body", lang))
                      )
                  )
              )
          ),

          # ====== FOOTER ======
          div(class = "dashboard-footer", id = "section-footer",
              tags$img(src = logo_white, style = "max-width: 150px; height: auto; margin-bottom: 1rem;", alt = "GCC-Stat Logo"),
              p(class = "footer-text", t("footer_org", lang)),
              p(class = "footer-text", style = "margin-top: 0.5rem;", t("footer_dept", lang))
          )

      ) # End story-container
    ) # End tagList
  })

  # --------------------------------------------------------------------------
  # Reactive: Get selected aggregation method
  # --------------------------------------------------------------------------
  gcc_method <- reactive({
    if(isTRUE(input$use_gdp_weighted)) "GCC (Weighted)" else "GCC (Simple)"
  })

  # --------------------------------------------------------------------------
  # Chart outputs (pass lang for bilingual chart labels)
  # --------------------------------------------------------------------------

  # Chart 1: World Ranking
  output$chart_world_ranking <- renderPlotly({
    lang <- current_lang()
    create_world_ranking_chart(wcr_data(), gcc_method = gcc_method(), lang = lang)
  })

  # Method explanation text
  output$method_explanation <- renderUI({
    lang <- current_lang()
    if(isTRUE(input$use_gdp_weighted)) {
      div(style = "margin-top: 0.75rem; font-size: 0.85rem; color: #555;",
          HTML(t("method_gdp_weights", lang)),
          br(),
          t("method_gdp_desc", lang)
      )
    } else {
      div(style = "margin-top: 0.75rem; font-size: 0.85rem; color: #555;",
          HTML(t("method_simple_weights", lang)),
          br(),
          t("method_simple_desc", lang)
      )
    }
  })

  # Chart 2: Trajectory
  output$chart_trajectory <- renderPlotly({
    lang <- current_lang()
    selected <- input$highlight_countries
    if(is.null(selected) || length(selected) == 0 || length(selected) == 7) {
      selected <- "All"
    }
    create_trajectory_chart(wcr_data(), highlight = selected, lang = lang)
  })

  # Chart 3: Dimensions
  output$chart_dimensions <- renderPlotly({
    create_dimensions_chart(wcr_data(), lang = current_lang())
  })

  # Chart 4: Heatmap
  output$chart_heatmap <- renderPlotly({
    create_heatmap_chart(wcr_data(), lang = current_lang())
  })

  # Chart 5: Gap Analysis
  output$chart_gap <- renderPlotly({
    create_gap_chart(wcr_data(), gcc_method = gcc_method(), lang = current_lang())
  })

  # Chart 6: Radar Comparison
  output$chart_radar_comparison <- renderPlotly({
    create_overlay_radar_chart(
      wcr_data(),
      selected_country = input$radar_country,
      gcc_method = gcc_method(),
      lang = current_lang()
    )
  })

  # Radar comparison summary
  output$radar_comparison_summary <- renderUI({
    req(input$radar_country)
    lang <- current_lang()

    data <- wcr_data()$factors_2025
    gcc_data <- data %>% filter(Country == gcc_method())
    country_data <- data %>% filter(Country == input$radar_country)

    dims <- c("EconPerf_Score", "GovEff_Score", "BusEff_Score", "Infra_Score")
    dim_names <- c(
      t("dim_economic_performance", lang),
      t("dim_government_efficiency", lang),
      t("dim_business_efficiency", lang),
      t("dim_infrastructure", lang)
    )

    diffs <- sapply(dims, function(d) country_data[[d]] - gcc_data[[d]])
    names(diffs) <- dim_names

    best <- names(diffs)[which.max(diffs)]
    best_val <- round(max(diffs), 1)
    weakest <- names(diffs)[which.min(diffs)]
    weakest_val <- round(min(diffs), 1)
    overall_diff <- round(country_data$Overall_Score - gcc_data$Overall_Score, 1)

    gcc_label <- if(gcc_method() == "GCC (Weighted)") t("gcc_weighted_label", lang) else t("gcc_simple_label", lang)

    div(style = "margin-top: 1rem; font-size: 0.9rem;",
        p(style = "margin-bottom: 0.5rem;",
          tags$strong(translate_country(input$radar_country, lang)),
          t("radar_vs", lang),
          tags$strong(gcc_label), ":"
        ),
        tags$ul(style = "margin: 0; padding-left: 1.2rem;",
                tags$li(t("radar_overall", lang),
                        span(style = paste0("color: ", if(overall_diff >= 0) "#27ae60" else "#e74c3c", ";"),
                             if(overall_diff >= 0) paste0("+", overall_diff) else overall_diff),
                        t("radar_points", lang)),
                tags$li(t("radar_strongest", lang), best, " (",
                        span(style = "color: #27ae60;", paste0("+", best_val)), ")"),
                tags$li(t("radar_gap", lang), weakest, " (",
                        span(style = "color: #e74c3c;", weakest_val), ")")
        )
    )
  })

}

# ============================================================================
# RUN APP
# ============================================================================
shinyApp(ui = ui, server = server)
