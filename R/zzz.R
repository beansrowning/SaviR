#' @importFrom magrittr `%>%`
#' @importFrom memoise memoise
#' @importFrom cachem cache_mem
#' @importFrom extrafont font_import loadfonts
#' @import Rttf2pt1
NULL

.onLoad <- function(libname, pkgname) {
  # Create a cache that expires every hour
  cache <- cachem::cache_mem(max_age = 60 * 60)

  # Re-assigning these into the package envir as memoised functions
  # i.e. the output gets cached after the first run, subsequent calls fetch
  # the cached result instead of pulling down the data again.
  get_testing <<- memoise::memoise(get_testing, cache = cache)
  get_onetable <<- memoise::memoise(get_onetable, cache = cache)
  get_covid_df <<- memoise::memoise(get_covid_df, cache = cache)
  get_gdeltnews <<- memoise::memoise(get_gdeltnews, cache = cache)
  get_vax <<- memoise::memoise(get_vax, cache = cache)
  get_vax_manufacturers <<- memoise::memoise(get_vax_manufacturers, cache = cache)


  # --- Load up Calibri for plots ----------------------------------
  # This checks to see if Calibri is registered as a font, and if not, installs it
  if (! "Calibri" %in% names(windowsFonts())) {
    suppressMessages(extrafont::font_import(pattern = "calibri", prompt = FALSE))
    extrafont::loadfonts(device = "win", quiet = TRUE)
  }

  invisible()
}