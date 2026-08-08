# V2 of this code
# Changes: Match the flow of the other codes 
# ==== Loading libraries =====
rm(list=ls(all=T))
library(stringr); library(devtools);  library("plyr")
library("readr"); library(tidyverse); library(readxl);library(crayon);

# ==== Run Info - User Input =====
pnnl.user = "gara009" # this is for Windows path
run.date = 20230526# in YYYYMMDD
RC = "RC3" # Options are RC2, RC3 or RC4
study.code = "SSF"
instrument = "BSF" # Options are MCRL or BSF

# ==== Defining paths and working directories ======
# Main path is where the raw data will be stored
home.path = paste0("C:/Users/",pnnl.user,"/OneDrive - PNNL/Documents - Core Richland and Sequim Lab-Field Team/Data Generation and Files/")

if (instrument == "MCRL"){
  instrument.path = paste0(home.path,"Raw_Instrument_Data/TSS MCRL/")
  lod.path = paste0(instrument.path,"LODs/")
} else if (instrument == "BSF"){
  instrument.path = paste0(home.path,"Raw_Instrument_Data/TSS BSF/")
  lod.path = paste0(instrument.path,"Limit_of_detection_calculations/")
  LOD.file = "TSS_BSF_LOD.xlsx"
}
# Formatted and processed data paths
if (RC == "RC3"){
  formatted.path = paste0(home.path,RC,"/01_Processed_data_by_analysis/TSS/")
  processed.path = paste0(home.path,RC,"/01_Processed_data_by_analysis/TSS/")
} else {
  rc.path = paste0(home.path,RC,"/TSS/")
  formatted.path = paste0(rc.path,"02_FormattedData/")
  processed.path = paste0(rc.path,"03_ProcessedData/")
}

# ==== Read in  Mapping sheet and set output folder ======
# Read in files, format them and export to formatted folder
setwd(instrument.path)
files = list.files(full.names = TRUE)
docs = files[grep(pattern = run.date, files)]
mapping.sheet = docs[grep("Mapping",docs)]
mapping = read_excel(mapping.sheet, skip = 1)

# Defining rc.study.code
rc.study.code.samples = str_extract(mapping.sheet, paste0(RC,"_",study.code,"_([A-Za-z0-9]+)_([A-Za-z0-9]+)-([A-Za-z0-9]+)")) 

if (is.na(rc.study.code.samples) == TRUE){
  rc.study.code.samples = str_extract(mapping.sheet, paste0(RC,"_",study.code,"_([A-Za-z0-9]+)-([A-Za-z0-9]+)"))
}
if (is.na(rc.study.code.samples) == TRUE){
  rc.study.code.samples = str_extract(mapping.sheet, paste0(RC,"_",study.code,"_([A-Za-z0-9]+)-([A-Za-z0-9]+)"))
}
if (is.na(rc.study.code.samples) == TRUE){
  rc.study.code.samples = str_extract(mapping.sheet, paste0(RC,"_",study.code,"_([A-Za-z0-9]+)"))
}
if (is.na(rc.study.code.samples) == TRUE){
  rc.study.code.samples = str_extract(mapping.sheet, paste0(RC,"_",study.code))
}

if (nchar(rc.study.code.samples)>16){
  rc.study.code.samples = str_extract(mapping.sheet, paste0(RC,"_",study.code))
}
# Setting up the formatted and processed folder
run.folders = list.dirs(path = formatted.path)
data.folder = run.folders[grep(pattern = run.date ,run.folders)]

formatted.folder = if_else(RC == "RC3",paste0(run.date,"_Data_Processed_TSS_SBR_",rc.study.code.samples,"/"),paste0(run.date,"_Data_Formatted_TSS_SBR_",rc.study.code.samples,"/"))

processed.folder = if_else(RC == "RC3",paste0(run.date,"_Data_Processed_TSS_SBR_",rc.study.code.samples,"/"),paste0(run.date,"_Data_Processed_TSS_SBR_",rc.study.code.samples,"/"))

if (length(data.folder)==0){
  dir.create(paste0(formatted.path,formatted.folder))
  dir.create(paste0(processed.path,processed.folder))
}

formatted.path = paste0(formatted.path,formatted.folder)
processed.path = paste0(processed.path,processed.folder)

# ==== Copy Raw Data into folder =====
if (RC == "RC3"){
  raw.path = paste0(home.path,RC,"/00_Raw_data_by_analysis/TSS/")
}else{
  raw.path = paste0(rc.path,"01_RawData/")
}
run.folders = list.dirs(path = raw.path)
data.folder = run.folders[grep(pattern = run.date ,run.folders)]
output.folder = paste0(run.date,"_Data_Raw_TSS_SBR_",rc.study.code.samples,"/")
if (length(data.folder)==0){
  dir.create(paste0(raw.path,output.folder))
}

raw.output.path = paste0(raw.path,output.folder)

file.copy(docs,raw.output.path, overwrite = T)

# ==== Formatting data =====
dat.sheet = docs[grep("Data_Raw",docs)]
data = read_excel(dat.sheet)
df = merge(data,mapping, by = "Sample_ID")

# Keeping only relevant columns
# final = df %>% dplyr::select(Sample_ID,`Non-filterable residue (Column I mg- Column C mg)* (1000 mL/L) / (Column D g - Column E in grams = mL )`,Method_Deviation)
final = df %>% dplyr::select(Sample_ID,names(df)[grep("Column I",colnames(data))],Method_Deviation)
colnames(final) = c("Sample_ID","TSS_mg_per_L","Method_Deviation")

# ==== Adding flags based on LOD ======

LOD = read_excel(paste0(lod.path,LOD.file))
LOD.df = LOD[which(LOD$Date_start_YYYYMMDD <= run.date & LOD$Date_end_YYYYMMDD >= run.date),]
# if there are not LODS in the range of run dates
if (nrow(LOD.df) == 0){
  cat(red$bold("NO LODs in file"))
  LOD.df = LOD[1:12,]
}
LOD = round(LOD.df$LOD_TSS_mg_per_L,2) 

# adding flags when the sample is below limit of detection

for (i in 1:nrow(final)){
  if (is.na(as.numeric(final$TSS_mg_per_L[i]))==T){
    final$TSS_mg_per_L[i] = NA
  }else if (as.numeric(final$TSS_mg_per_L[i]) < 0){
    final$TSS_mg_per_L[i] = paste0("TSS_negative_value_ppm_Below_LOD_",LOD,"_ppm")
  }else if (as.numeric(final$TSS_mg_per_L[i])<= LOD&is.na(final$TSS_mg_per_L[i])==F){
    final$TSS_mg_per_L[i] = paste0("TSS_",round(as.numeric(final$TSS_mg_per_L[i]),2),"_Below_LOD_",LOD,"_ppm")
    final$Method_Deviation[i] = paste0(final$Method_Deviation[i],"; TSS_Below_LOD_",LOD,"_ppm")
  }else{
    final$TSS_mg_per_L[i] = round(as.numeric(final$TSS_mg_per_L[i]),2)
  }
}

#Fixing the NA situation
final$Method_Deviation = gsub("NA; ","",final$Method_Deviation)


# ===== Export data =====
write_csv(final, paste0(processed.path,run.date,"_Data_Processed_TSS_",rc.study.code.samples,".csv"), row.names = FALSE)
