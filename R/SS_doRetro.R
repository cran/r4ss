#' Run retrospective analyses
#'
#' Do retrospective analyses by creating new directories, copying model files,
#' and iteratively changing the starter file to set the number of years of data
#' to exclude. Note that there was a  bug for retrospectives in 3.30.01;
#' the user should update their model to a newer version of Stock Synthesis to
#' run retrospectives
#'
#'
#' @param masterdir Directory where everything takes place.
#' @param oldsubdir Subdirectory within `masterdir` with existing model
#' files.
#' @param newsubdir Subdirectory within `masterdir` where retrospectives
#' will be run. Default is 'retrospectives'.
#' @param subdirstart First part of the pattern of names for the directories in
#' which the models will actually be run.
#' @param years Vector of values to iteratively enter into the starter file for
#' retrospective year. Should be zero or negative values.
#' @param overwrite Overwrite any input files with matching names in the
#' subdirectories where models will be run.
#' @param exefile Executable file found in directory with model files.
#' On Windows systems, this value will be automatically updated if a single
#' executable exists in the directory of model files. Input exefile=NULL if
#' the executable is in your path and doesn't need copying.
#' @param extras Additional commands to use when running SS. Default = "-nox"
#' will reduce the amount of command-line output.
#' @param intern Display runtime information from SS in the R console (vs.
#' saving to a file).
#' @param CallType Either "system" or "shell" (choice depends on how you're running
#' R. Default is "system".
#' @param RemoveBlocks Logical switch determining whether specifications of
#' blocks is removed from top of control file. Blocks can cause problems for
#' retrospective analyses, but the method for removing them is overly
#' simplistic and probably won't work in most cases. Default=FALSE.
#' @author Ian Taylor, Jim Thorson
#' @export
#' @seealso [SSgetoutput()]
#' @examples
#' \dontrun{
#' # note: don't run this in your main directory--make a copy in case something
#' # goes wrong
#' mydir <- "C:/Simple"
#'
#' ## retrospective analyses
#' SS_doRetro(
#'   masterdir = mydir,
#'   oldsubdir = "",
#'   newsubdir = "retrospectives",
#'   years = 0:-5
#' )
#'
#' retroModels <- SSgetoutput(
#'   dirvec = file.path(mydir, "retrospectives", paste("retro", 0:-5, sep = ""))
#' )
#' retroSummary <- SSsummarize(retroModels)
#' endyrvec <- retroSummary[["endyrs"]] + 0:-5
#' SSplotComparisons(retroSummary,
#'   endyrvec = endyrvec,
#'   legendlabels = paste("Data", 0:-5, "years")
#' )
#' }
#'
SS_doRetro <- function(masterdir, oldsubdir, newsubdir = "retrospectives",
                       subdirstart = "retro", years = 0:-5, overwrite = TRUE,
                       exefile = "ss", extras = "-nox", intern = FALSE, CallType = "system",
                       RemoveBlocks = FALSE) {

  # this should always be "windows" or "unix" (includes Mac and Linux)
  OS <- .Platform[["OS.type"]]
  # prefix applied to start of command to run model
  prefix <- ifelse(OS == "windows", "", "./")

  # save working directory
  oldwd <- getwd()
  on.exit(setwd(oldwd))

  olddir <- file.path(masterdir, oldsubdir)
  newdir <- file.path(masterdir, newsubdir)

  # make directories, modify starter file, and start retrospective analyses

  # for Windows users, automatically determine executable
  if (!is.null(exefile) & OS == "windows") {
    exefiles <- dir(olddir)[grep(".exe", dir(olddir))]
    # if exactly one executable found in model directory, use that instead
    if (length(exefiles) == 1) {
      exefile <- exefiles
    }
    # for cases where there is more than one exe and the file name is
    # "ss" by default, add the exe automatically
    if (exefile == "ss") {
      exefile <- "ss.exe"
    }
    if (!exefile %in% exefiles) {
      stop("Missing executable file ", exefile, " in ", olddir)
    }
  }

  # get model file names from olddir
  startfile <- dir(olddir)[tolower(dir(olddir)) == "starter.ss"]
  forefile <- dir(olddir)[tolower(dir(olddir)) == "forecast.ss"]
  wtatagefile <- dir(olddir)[tolower(dir(olddir)) == "wtatage.ss"]
  testfile <- dir(olddir)[tolower(dir(olddir)) == "test.ss"]

  if (length(startfile) == 0) stop("No starter.ss file found in ", olddir)

  ## print(getwd())
  ## print(startfile)
  startfile <- file.path(olddir, startfile)

  message("Getting input file names from starter file:\n", startfile)
  starter <- SS_readstarter(startfile, verbose = FALSE)
  ctlfile <- starter[["ctlfile"]]
  datfile <- starter[["datfile"]]

  filenames <- c(exefile, forefile, ctlfile, datfile, wtatagefile, testfile)
  message("copying model files from\n", olddir, "\n  to\n", newdir)
  message("model files to copy:\n ", paste(filenames, collapse = "\n "))


  if (!file.exists(newdir)) dir.create(newdir)

  subdirnames <- paste0(subdirstart, years)

  for (iyr in 1:length(years)) {
    # create directory
    if (!file.exists(file.path(newdir, subdirnames[iyr]))) {
      dir.create(file.path(newdir, subdirnames[iyr]))
    }
    # copy files
    copy.test <- file.copy(file.path(olddir, filenames),
      file.path(newdir, subdirnames[iyr], filenames),
      overwrite = TRUE
    )
    # make sure there weren't any errors copying the files
    if (!all(copy.test)) {
      stop("error copying file(s): ", filenames[!copy.test])
    }
    # change starter file to do retrospectives
    starter[["retro_yr"]] <- years[iyr]
    starter[["init_values_src"]] <- 0
    setwd(file.path(newdir, subdirnames[iyr]))
    SS_writestarter(starter, dir = getwd(), verbose = FALSE, overwrite = TRUE)

    ## # someday the code could be expanded to fix data file if it has blocks
    ## ctl <- SS_parlines(ctlfile) # doesn't currently read columns with block info
    ctl <- readLines(ctlfile)
    if (RemoveBlocks == TRUE) {
      ctl[grep("block designs", ctl)] <- "0 # Number of block designs for time varying parameters"
      ctl[grep("blocks per design", ctl) + 0:2] <- "# blocks deleted"
    }
    file.remove(ctlfile)
    writeLines(ctl, ctlfile)

    # if spaces in exe file, then put the filename in quotes
    if (length(grep(" ", exefile)) > 0) {
      exefile_to_run <- paste0('"', exefile, '"')
    } else {
      # but avoid otherwise in case they mess something up
      exefile_to_run <- exefile
    }
    command <- paste0(prefix, exefile_to_run, " ", extras)

    # run model
    message("Running model in ", getwd(), "\n",
      "using the command:\n   ", command,
      sep = ""
    )

    if (file.exists("covar.sso")) file.remove("covar.sso")
    if (intern) {
      message("ADMB output generated during model run will be written to:\n   ",
        getwd(), "/ADMBoutput.txt. \n   To change this, set intern=FALSE\n",
        "Note: ignore message about 'Error trying to open data input file ss3.dat'\n",
        sep = ""
      )
    }

    if (CallType == "system") {
      ADMBoutput <- system(command, intern = intern)
    }
    if (CallType == "shell") {
      ADMBoutput <- shell(command, intern = intern)
    }
    # add rough check for if the model ran (although a report file may exist if
    # if the model only ran part of the way through). Warn the user in this case.
    if (!file.exists("Report.sso")) {
      warning("The retrospective model run failed in ", getwd())
    }
    if (intern) {
      writeLines(c(
        "###", "ADMB output", as.character(Sys.time()),
        "###", " ", ADMBoutput
      ), con = "ADMBoutput.txt")
    }
    setwd("..")
  }
  setwd(oldwd)
}


## if(FALSE){
##   #### example use
##   # source this file
##   source('c:/SS/hake/Hake_2012/retro/retro_script.R')

##   # move to directory one level above existing model run
##   setwd('C:/ss/hake/Hake_2013/runs/')

##   # run the function above
##   SS_doRetro(olddir='2013hake_12',years=0:-10)
##   # read in output
##   retroModels <- SSgetoutput(dirvec=paste('retrospectives/retro',-10:0,sep=''))
##   # summarize output
##   retroSummary <- SSsummarize(retroModels)

##   # set the ending year of each model in the set
##   endyrvec <- retroModels[[1]][["endyr"]]-10:0
##   # make comparison plot
##   pdf('retrospectives/retrospective_comparison_plots.pdf')
##   SSplotComparisons(retroSummary,endyrvec=endyrvec,new=FALSE)
##   dev.off()

##   # make Ianelli-style plot of recdev retrospectives using a different function
##   pdf('retrospectives/retrospective_dev_plots.pdf',width=7,height=10)
##   par(mfrow=c(2,1))
##   # first scaled relative to most recent estimate
##   SSplotRetroDevs(retroSummary, endyrvec=endyrvec, cohorts=1999:2012, relative=TRUE, legend=FALSE)
##   # second without scaling
##   SSplotRetroDevs(retroSummary, endyrvec=endyrvec, cohorts=1999:2012, relative=FALSE, legend=FALSE)
##   dev.off()

## }
