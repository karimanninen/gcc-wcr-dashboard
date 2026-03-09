# GCC Competitiveness Data Story Dashboard

A bilingual (English/Arabic) scrollytelling Shiny dashboard presenting
"Stronger Together: How the GCC Became a Global Economic Force" based on
IMD World Competitiveness Ranking 2025 data.

## Project Structure

```
app.R                   # Main Shiny app (UI + Server, embedded CSS/JS)
R/
  data_loader.R         # Data loading & GCC aggregate calculations
  charts.R              # All Plotly chart functions (8 charts)
  translations.R        # Bilingual dictionary & helper functions
www/
  CSS/                  # External stylesheets (not currently loaded)
    main.css            # Layout & scrollytelling structure
    themes.css          # Section background themes
    components.css      # Component-specific styles
  js/
    scroll.js           # Navigation & scroll behavior (not currently loaded)
  images/
    GCC-MAIN-01-WHITE.png
    GCC-MAIN-01-BLACK.png
manifest.json           # Posit Connect deployment config
```

## Architecture

- **Single-file Shiny app** using `bslib::page_fillable()` with Bootstrap 5
- **CSS/JS are embedded** in `app.R` via `tags$style()` / `tags$script()`
  for reliable rendering on Posit Connect Cloud
- **Data is embedded** in `R/data_loader.R` (future: Fusion Registry SDMX API)
- **9 scrollytelling sections** with scroll-snap navigation and fixed nav dots

## Bilingual System

Follows the same pattern as the GCCEII dashboard:

- **`R/translations.R`** contains the `t(key, lang)` lookup function,
  `.translations` dictionary, `translate_country()`, and layout helpers
  (`get_direction()`, `get_font()`, `get_text_align()`)
- **Language toggle** is a fixed-position `actionButton` that flips
  `current_lang` reactiveVal between `"en"` and `"ar"`
- **`renderUI("main_ui")`** rebuilds the entire story on language change
- **RTL support** via `body.lang-ar` CSS class set by JS
  `sendCustomMessage("setLang")`; all RTL styles are embedded in `app.R`
- **Chart functions** all accept a `lang` parameter for translated titles,
  axis labels, dimension names, country names, and hover text
- Default language is **English** (`reactiveVal("en")`)

### Adding new translatable text

1. Add a key to `.translations` in `R/translations.R`:
   ```r
   my_new_key = list(en = "English text", ar = "Arabic text")
   ```
2. Use `t("my_new_key", lang)` in the UI or server code

### Country name translations

Use `translate_country("UAE", lang)` or `translate_countries(vec, lang)`
for vectorized translation. Country values in inputs should stay English
(internal data keys); only display labels are translated.

## Chart Functions (R/charts.R)

All accept `lang = "en"` parameter:

| Function | Chart Type | Section |
|---|---|---|
| `create_world_ranking_chart()` | Bar + range slider | Global Ranking |
| `create_trajectory_chart()` | Multi-line | The Journey |
| `create_dimensions_chart()` | Horizontal bar | Strengths |
| `create_heatmap_chart()` | Heatmap | Country Profiles |
| `create_gap_chart()` | Stacked bar | Gap Analysis |
| `create_radar_chart()` | Single radar | (unused) |
| `create_dual_radar_chart()` | Side-by-side radar | (unused) |
| `create_overlay_radar_chart()` | Overlaid radar | Dimension Comparison |

## GCC Country Color Palette

```
UAE:           #000000 (Black)
Qatar:         #99154C (Maroon)
Saudi Arabia:  #008035 (Green)
Bahrain:       #E20000 (Red)
Oman:          #a3a3a3 (Grey)
Kuwait:        #00B1E6 (Cyan)
GCC Aggregate: #B8A358 (Gold)
```

## Dependencies

shiny, bslib, plotly, dplyr, tidyr, scales, shinyWidgets

## Deployment

Deployed to Posit Connect Cloud via `manifest.json`.
Run locally with `shiny::runApp()`.
