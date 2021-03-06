#' Start Phuse Web Application
#' @description start phuse web appllication framework.
#' @param n Example number
#' @param pkg  package name
#' @param pt Port number
#' @param lb define the browser- shiny.launch.browser
#' @param ht define the host or ip address
#' @param dm display modes are auto, normal or showcase
#' @param msg_lvl message level
#' @export
#' @examples
#'\dontrun{
#'   library(phuse)
#'   start_phusee()  # default to "02_display"
#'   start_phuse(1)  # start "01_html"
#'}
#' @author Hanming Tu
#' @name start_phuse
# ---------------------------------------------------------------------------
# HISTORY   MM/DD/YYYY (developer) - explanation
#  09/21/2017 (htu) - initial creation
#  03/04/2018 (htu) - skipped run_example
#  10/18/2018 (htu) - added msg_lvl
#

# start_phuse <- function (n = 2)
#{
#  app_name <- paste0(sprintf("%02d", n), "_display")
#  run_example(app_name)
# }

start_phuse <- function (n = 2, pkg = "phuse"
                        , pt = NULL
                        , lb = getOption("shiny.launch.browser",interactive())
                        , ht = getOption("shiny.host", "127.0.0.1")
                        #, dm = c("auto", "normal", "Normal")
                        , dm =  "normal"
                        , msg_lvl = NULL
) {
  prg <- "start_phuse"; echo_msg(prg,0.0,'Started', 1)

  if (is.null(msg_lvl)) {
    Sys.setenv("g_lvl"=0, "d_lvl"=0)
  } else {
    Sys.setenv("g_lvl"=msg_lvl, "d_lvl"=msg_lvl)
  }
  examplesDir <- system.file("examples", package = pkg )
  # apps    <- c("01_html","02_display","03_showenv","04_merge","05_d3");
  apps    <- list.files(examplesDir);
  example <- apps[n];

  echo_msg(prg,0.1, paste("Example dir =", examplesDir), 1)

  # dir <- shiny:::resolve(examplesDir, example)
  dir <- resolve(examplesDir, example)
  echo_msg(prg,0.2, paste("Resolved dir =", dir), 1)


  if (is.null(dir)) {
    echo_msg(prg,1.1,paste('could not find a dir for ',example), 1)
    if (is.na(example)) {
      errFun <- message
      errMsg <- ""
    } else {
      errFun <- stop
      errMsg <- paste("Example", example, "does not exist. ")
    }
    errFun(errMsg, "Valid examples are \""
           , paste(list.files(examplesDir), collapse = "\", \""), "\"")
  } else {
    echo_msg(prg,1.2,paste('Start app from ',dir), 1)
    shiny::runApp(dir
                  , port = pt, host = ht, launch.browser = lb, display.mode = dm)
  }
}

