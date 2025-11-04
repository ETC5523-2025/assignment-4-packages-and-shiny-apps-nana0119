
<!-- README.md is generated from README.Rmd. Please edit that file -->

# yarrawater

The yarrawater package helps users explore changes in Yarra River water
quality between the 1990s and 2020s.

### Purpose of the package

The **yarrawater** package helps users explore changes in **Yarra River
water quality** between the **1990s** and **2020s**.  
It provides a cleaned dataset, useful plotting functions, and an
interactive **Shiny app** for comparing water quality indicators such as
**pH**, **Salinity as <EC@25>**, **Turbidity**, and **Water
Temperature**.

------------------------------------------------------------------------

### Example of use

``` r
library(yarrawater)

# Launch the interactive Shiny app
run_my_app()

# Create a static summary plot
plot_yarra_data()
```

These tools help users visualise how different water parameters have
changed over time.

### Installation

You can install the package directly from GitHub using the remotes
package:

``` r
# install.packages("remotes")

remotes::install_github("ETC5523-2025/assignment-4-packages-and-shiny-apps-nana0119")
#> Downloading GitHub repo ETC5523-2025/assignment-4-packages-and-shiny-apps-nana0119@HEAD
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#>      checking for file ‘/private/var/folders/t4/8f2397n15vl_xd57bnz00cmw0000gn/T/RtmpUIJu56/remotesf7a62cd48aa2/ETC5523-2025-assignment-4-packages-and-shiny-apps-nana0119-2948875/DESCRIPTION’ ...  ✔  checking for file ‘/private/var/folders/t4/8f2397n15vl_xd57bnz00cmw0000gn/T/RtmpUIJu56/remotesf7a62cd48aa2/ETC5523-2025-assignment-4-packages-and-shiny-apps-nana0119-2948875/DESCRIPTION’
#>   ─  preparing ‘yarrawater’:
#>      checking DESCRIPTION meta-information ...  ✔  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>   ─  building ‘yarrawater_0.0.0.9000.tar.gz’
#>      
#> 
library(yarrawater)
```

### Overview of the package

- Data: yarra_wq_clean — cleaned Yarra River water quality dataset.

- Functions:

run_app() — launches the interactive Shiny dashboard.

plot_yarra_data() — creates plots comparing the 1990s and 2020s.

- Shiny: Located in inst/shiny-app/, allowing users to select parameters
  and plot types interactively.

- Documentation: All functions and data objects are clearly documented
  using roxygen2.

- pkgdown website:
  <https://etc5523-2025.github.io/assignment-4-packages-and-shiny-apps-nana0119/>
