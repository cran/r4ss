SS_readdat <- function(file,verbose=TRUE,echoall=FALSE,section=NULL){
  # function to read Stock Synthesis data files

  if(verbose) cat("running SS_readdat\n")
  dat <- readLines(file,warn=FALSE)

  if(!is.null(section)){
    Nsections <- as.numeric(substring(dat[grep("Number_of_datafiles",dat)],24))
    if(!section %in% 1:Nsections) stop("The 'section' input should be within the 'Number_of_datafiles' in a data.ss_new file.\n")
    if(section==1) dat <- dat[grep("#_observed data:",dat):grep("#_expected values with no error added",dat)]
    if(section==2) dat <- dat[grep("#_expected values with no error added",dat):grep("#_bootstrap file: 1",dat)]
    if(section>=3){
      start <- grep(paste("#_bootstrap file:",section-2),dat)
      end <- grep(paste("#_bootstrap file:",section-1),dat)
      if(length(end)==0) end <- length(dat)
      dat <- dat[start:end]
    }
  }

  temp <- strsplit(dat[2]," ")[[1]][1]
  if(!is.na(temp) && temp=="Start_time:") dat <- dat[-(1:2)]
  allnums <- NULL
  for(i in 1:length(dat)){
    mysplit <- strsplit(dat[i],split="[[:blank:]]+")[[1]]
    mysplit <- mysplit[mysplit!=""]
    nums <- suppressWarnings(as.numeric(mysplit))
    if(sum(is.na(nums)) > 0) maxcol <- min((1:length(nums))[is.na(nums)])-1
    else maxcol <- length(nums)
    if(maxcol > 0){
      nums <- nums[1:maxcol]
      allnums <- c(allnums, nums)
    }
  }
  i <- 1
  datlist <- list()

  datlist$sourcefile <- file
  datlist$type <- "Stock_Synthesis_data_file"
  datlist$SSversion <- "SSv3.20"

  if(verbose) cat("SSversion =",datlist$SSversion,"\n")
  # model dimensions
  datlist$styr  <- allnums[i]; i <- i+1
  datlist$endyr <- allnums[i]; i <- i+1
  datlist$nseas <- nseas <- allnums[i]; i <- i+1
  datlist$months_per_seas <- allnums[i:(i+nseas-1)]; i <- i+nseas
  datlist$spawn_seas <- allnums[i]; i <- i+1
  datlist$Nfleet <- Nfleet <- allnums[i]; i <- i+1
  datlist$Nsurveys <- Nsurveys <- allnums[i]; i <- i+1
  Ntypes <- Nfleet+Nsurveys
  datlist$N_areas <- allnums[i]; i <- i+1

  # an attempt at getting the fleet names based on occurance of %-sign
  if(Ntypes>1){
    fleetnames <- dat[grep('%',dat)[1]]
    fleetnames <- strsplit(fleetnames,'%')[[1]]
    if(length(fleetnames)!=Ntypes)
      fleetnames <- c(paste("fishery",1:Nfleet),paste("survey",1:Nsurveys))
  }else{
    fleetnames <- "fleet1"
  }
  datlist$fleetnames <- fleetnames
  datlist$surveytiming <- surveytiming <- allnums[i:(i+Ntypes-1)]; i <- i+Ntypes
  datlist$areas <- areas <- allnums[i:(i+Ntypes-1)]; i <- i+Ntypes

  # fleet info
  fleetinfo1 <- data.frame(rbind(surveytiming,areas))
  names(fleetinfo1) <- fleetnames
  fleetinfo1$input <- c("#_surveytiming","#_areas")
  datlist$fleetinfo1 <- fleetinfo1

  datlist$units_of_catch <- units_of_catch <- allnums[i:(i+Nfleet-1)]; i <- i+Nfleet
  datlist$se_log_catch <- se_log_catch <- allnums[i:(i+Nfleet-1)]; i <- i+Nfleet
  fleetinfo2 <- data.frame(rbind(units_of_catch,se_log_catch))
  names(fleetinfo2) <- fleetnames[1:Nfleet]
  fleetinfo2$input <- c("#_units_of_catch","#_se_log_catch")
  datlist$fleetinfo2 <- fleetinfo2

  # more dimensions
  datlist$Ngenders <- Ngenders <- allnums[i]; i <- i+1
  datlist$Nages <- Nages <- allnums[i]; i <- i+1
  datlist$init_equil <- allnums[i:(i+Nfleet-1)]; i <- i+Nfleet

  # catch
  datlist$N_catch <- N_catch <- allnums[i]; i <- i+1
  if(verbose) cat("N_catch =",N_catch,"\n")
  Nvals <- N_catch*(Nfleet+2)
  catch <- data.frame(matrix(
    allnums[i:(i+Nvals-1)],nrow=N_catch,ncol=(Nfleet+2),byrow=TRUE))
  names(catch) <- c(fleetnames[1:Nfleet],"year","seas")
  datlist$catch <- catch
  i <- i+Nvals
  if(echoall) print(catch)
  
  # CPUE
  datlist$N_cpue <- N_cpue <- allnums[i]; i <- i+1
  if(verbose) cat("N_cpue =",N_cpue,"\n")
  if(N_cpue > 0){
    CPUEinfo <- data.frame(matrix(allnums[i:(i+Ntypes*3-1)],
                                  nrow=Ntypes,ncol=3,byrow=TRUE))
    i <- i+Ntypes*3
    names(CPUEinfo) <- c("Fleet","Units","Errtype")
    CPUE <- data.frame(matrix(
      allnums[i:(i+N_cpue*5-1)],nrow=N_cpue,ncol=5,byrow=TRUE))
    i <- i+N_cpue*5
    names(CPUE) <- c('year','seas','index','obs','se_log')
  }else{
    CPUEinfo <- NULL
    CPUE <- NULL
  }
  datlist$CPUEinfo <- CPUEinfo
  datlist$CPUE <- CPUE
  if(echoall){
    print(CPUEinfo)
    print(CPUE)
  }

  # discards
  # datlist$discard_units <- discard_units <- allnums[i]; i <- i+1
  datlist$N_discard_fleets <- N_discard_fleets <- allnums[i]; i <- i+1
  if(verbose) cat("N_discard_fleets =",N_discard_fleets,"\n")
  datlist$N_discard <- N_discard <- allnums[i]; i <- i+1
  if(verbose) cat("N_discard =",N_discard,"\n")
  if(N_discard > 0){
    Ncols <- 5
    discard_data <- data.frame(matrix(
      allnums[i:(i+N_discard*Ncols-1)],nrow=N_discard,ncol=Ncols,byrow=TRUE))
    i <- i+N_discard*Ncols
    names(discard_data) <- c('Yr','Seas','Flt','Discard','Std_in')
  }else{
    discard_data <- NULL
  }
  datlist$discard_data <- discard_data

  # meanbodywt
  datlist$N_meanbodywt <- N_meanbodywt <- allnums[i]; i <- i+1
  if(verbose) cat("N_meanbodywt =",N_meanbodywt,"\n")
  if(N_meanbodywt > 0){
    Ncols <- 6
    meanbodywt <- data.frame(matrix(
      allnums[i:(i+N_meanbodywt*Ncols-1)],nrow=N_meanbodywt,ncol=Ncols,byrow=TRUE))
    i <- i+N_discard*Ncols
    names(meanbodywt) <- c('Year','Seas','Type','Partition','Value','CV')
  }else{
    meanbodywt <- NULL
  }
  datlist$meanbodywt <- meanbodywt

  datlist$DF_for_meanbodywt <- allnums[i]
  i <- i+1
  if(echoall) print(datlist$DF_for_meanbodywt)
  
  # length data
  datlist$lbin_method <- lbin_method <- allnums[i]; i <- i+1
  if(lbin_method==2){
    datlist$binwidth <- allnums[i]; i <- i+1
    datlist$minimum_size <- allnums[i]; i <- i+1
    datlist$maximum_size <- allnums[i]; i <- i+1
  }else{
    datlist$binwidth <- NA
    datlist$minimum_size <- NA
    datlist$maximum_size <- NA
  }
  if(lbin_method==3){
    datlist$N_lbinspop <- N_lbinspop <- allnums[i]; i <- i+1
    datlist$lbin_vector_pop <- allnums[i:(i+N_lbinspop-1)]; i <- i+N_lbinspop
  }else{
    datlist$N_lbinspop <- NA
    datlist$lbin_vector_pop <- NA
  }
  if(echoall){
    cat("N_lbinspop =",N_lbinspop,"\nlbin_vector_pop:\n")
    print(datlist$lbin_vector_pop)
  }
  datlist$comp_tail_compression <- allnums[i]; i <- i+1
  datlist$add_to_comp <- allnums[i]; i <- i+1
  datlist$max_combined_age <- allnums[i]; i <- i+1
  datlist$N_lbins <- N_lbins <- allnums[i]; i <- i+1
  datlist$lbin_vector <- lbin_vector <- allnums[i:(i+N_lbins-1)]; i <- i+N_lbins
  if(echoall) print(lbin_vector)
  
  datlist$N_lencomp <- N_lencomp <- allnums[i]; i <- i+1

  # if(verbose) cat(datlist[-15:0 + length(datlist)])
  if(verbose) cat("N_lencomp =",N_lencomp,"\n")

  if(N_lencomp > 0){
    Ncols <- N_lbins*Ngenders+6
    lencomp <- data.frame(matrix(
                                 allnums[i:(i+N_lencomp*Ncols-1)],nrow=N_lencomp,ncol=Ncols,byrow=TRUE))
    i <- i+N_lencomp*Ncols
    names(lencomp) <- c("Yr","Seas","FltSvy","Gender","Part","Nsamp",
                        if(Ngenders==1){paste("l",lbin_vector,sep="")}else{NULL},
                        if(Ngenders>1){ c(paste("f",lbin_vector,sep=""),paste("m",lbin_vector,sep="")) }else{ NULL } )
  }else{
    lencomp <- NULL
  }
  datlist$lencomp <- lencomp

  # age data
  datlist$N_agebins <- N_agebins <- allnums[i]; i <- i+1
  if(verbose) cat("N_agebins =",N_agebins,"\n")
  if(N_agebins > 0){
    agebin_vector <- allnums[i:(i+N_agebins-1)]; i <- i+N_agebins
  }else{
    agebin_vector <- NULL
  }
  datlist$agebin_vector <- agebin_vector
  
  datlist$N_ageerror_definitions <- N_ageerror_definitions <- allnums[i]; i <- i+1
  if(N_ageerror_definitions > 0){
    Ncols <- Nages+1
    ageerror <- data.frame(matrix(
      allnums[i:(i+2*N_ageerror_definitions*Ncols-1)],
      nrow=2*N_ageerror_definitions,ncol=Ncols,byrow=TRUE))
    i <- i+2*N_ageerror_definitions*Ncols
    names(ageerror) <- paste("age",0:Nages,sep="")
  }else{
    ageerror <- NULL
  }
  datlist$ageerror <- ageerror

  datlist$N_agecomp <- N_agecomp <- allnums[i]; i <- i+1
  if(verbose) cat("N_agecomp =",N_agecomp,"\n")

  datlist$Lbin_method <- allnums[i]; i <- i+1
  datlist$max_combined_lbin <- allnums[i]; i <- i+1

  if(N_agecomp > 0){
    if(N_agebins==0) stop("N_agecomp =",N_agecomp," but N_agebins = 0")
    Ncols <- N_agebins*Ngenders+9
    agecomp <- data.frame(matrix(
      allnums[i:(i+N_agecomp*Ncols-1)],nrow=N_agecomp,ncol=Ncols,byrow=TRUE))
    i <- i+N_agecomp*Ncols
    names(agecomp) <- c("Yr","Seas","FltSvy","Gender","Part","Ageerr","Lbin_lo","Lbin_hi","Nsamp",
                        if(Ngenders==1){paste("a",agebin_vector,sep="")}else{NULL},
                        if(Ngenders>1){ c(paste("f",agebin_vector,sep=""),paste("m",agebin_vector,sep="")) }else{ NULL } )
  }else{
    agecomp <- NULL
  }
  datlist$agecomp <- agecomp

  # MeanSize_at_Age
  datlist$N_MeanSize_at_Age_obs <- N_MeanSize_at_Age_obs <- allnums[i]; i <- i+1
  if(verbose) cat("N_MeanSize_at_Age_obs =",N_MeanSize_at_Age_obs,"\n")
  if(N_MeanSize_at_Age_obs > 0){
    Ncols <- 2*N_agebins*Ngenders + 7
    MeanSize_at_Age_obs <- data.frame(matrix(
      allnums[i:(i+N_MeanSize_at_Age_obs*Ncols-1)],nrow=N_MeanSize_at_Age_obs,ncol=Ncols,byrow=TRUE))
    i <- i+N_MeanSize_at_Age_obs*Ncols
    names(MeanSize_at_Age_obs) <- c('Yr','Seas','Fleet','Gender','Part','AgeErr','Ignore',
                                    if(Ngenders==1){paste("a",agebin_vector,sep="")}else{NULL},
                                    if(Ngenders>1){ c(paste("f",agebin_vector,sep=""),paste("m",agebin_vector,sep="")) }else{ NULL },
                                    if(Ngenders==1){paste("N_a",agebin_vector,sep="")}else{NULL},
                                    if(Ngenders>1){ c(paste("N_f",agebin_vector,sep=""),paste("N_m",agebin_vector,sep="")) }else{ NULL } )
  }else{
    MeanSize_at_Age_obs <- NULL
  }
  datlist$MeanSize_at_Age_obs <- MeanSize_at_Age_obs

  # other stuff
  datlist$N_environ_variables <- N_environ_variables <- allnums[i]; i <- i+1
  datlist$N_environ_obs <- N_environ_obs <- allnums[i]; i <- i+1
  datlist$N_sizefreq_methods <- N_sizefreq_methods <- allnums[i]; i <- i+1
  datlist$do_tags <- do_tags <- allnums[i]; i <- i+1
  if(do_tags != 0){
    datlist$N_tag_groups <- N_tag_groups <- allnums[i]; i <- i+1
    datlist$N_recap_events <- N_recap_events <- allnums[i]; i <- i+1
    datlist$mixing_latency_period <- mixing_latency_period <- allnums[i]; i <- i+1
    datlist$max_periods <- max_periods <- allnums[i]; i <- i+1

    # read tag release data
    if(N_tag_groups > 0){
      Ncols <- 8
      tag_releases <- data.frame(matrix(allnums[i:(i+N_tag_groups*Ncols-1)],nrow=N_tag_groups,ncol=Ncols,byrow=TRUE))
      i <- i+N_tag_groups*Ncols
      names(tag_releases) <- c('TG', 'Area', 'Yr', 'Season', 'tfill', 'Gender', 'Age', 'Nrelease')
    }else{
      tag_releases <- NULL
    }
    datlist$tag_releases <- tag_releases

    # read tag recapture data
    if(N_recap_events > 0){
      Ncols <- 5
      tag_recaps <- data.frame(matrix(allnums[i:(i+N_recap_events*Ncols-1)],nrow=N_recap_events,ncol=Ncols,byrow=TRUE))
      i <- i+N_recap_events*Ncols
      names(tag_recaps) <- c('TG', 'Yr', 'Season', 'Fleet', 'Nrecap')
    }else{
      tag_recaps <- NULL
    }
    datlist$tag_recaps <- tag_recaps
  }
  
  datlist$morphcomp_data <- morphcomp_data <- allnums[i]; i <- i+1

  if(allnums[i]==999){
    if(verbose) cat("read of data file complete (final value = 999)\n")
  }else{
    cat("Error: final value is", allnums[i]," but should be 999\n")
  }

  # return the result
  return(datlist)
}