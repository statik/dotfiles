
# adapted from https://github.com/gvelasq/dotfiles/blob/main/R/.Rprofile

if (interactive()) {
  suppressMessages(require(devtools))
  suppressMessages(require(usethis))
}

## Default repo
local({r <- getOption("repos")
       r["CRAN"] <- "https://cloud.r-project.org"
       options(repos=r)
})
if (Sys.info()[["sysname"]] == "Linux") {
  options(
    # https://packagemanager.rstudio.com/__docs__/admin/serving-binaries/#binary-user-agents
    HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])),
    repos = c(
      statik = "https://statik.r-universe.dev",
      REPO_NAME = "https://packagemanager.rstudio.com/all/__linux__/jammy/latest"
    )
  )
}

options(
  usethis.description = list(
    `Authors@R` = 'person("Elliot", "Murphy", email = "elliot@elliotmurphy.com", role = c("aut", "cre"))',
    License = "MIT + file LICENSE",
    Version = "0.0.0.9000"
  ),
  usethis.full_name = "Elliot Murphy",
  usethis.protocol = "https",
  vsc.rstudioapi = TRUE,
  warnPartialMatchArgs = TRUE,
  warnPartialMatchDollar = TRUE,
  warnPartialMatchAttr = TRUE
)
