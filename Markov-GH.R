################### ---------- Necessary Steps before Analysis -----------###############
## Download the data as per your requirement from google Analytics
## Clean the data by removing commas,Currency Symbols and Spaces
## Also remove unnecessary or blank rows which includes name of the report and date range
## Load the data into R from your working directory

## To set your working directory
## Use command setwd()
## For e.g. setwd("D:/Github")
## Always replace backslashes with forward slashes while giving path to R
## Copy your downloaded and clean file into your working directory

############## ---------------- R Code Starts ----###########
## You will require "Channel Attribution package for further analysis
## Installing Package
install.packages("ChannelAttribution")

## Loading same
library(ChannelAttribution)

## Read the data from working directory and saving into data frame dat
dat<-read.csv("your_data_from_analytics.csv")

## Checking Structure of the columns in data frame
str(dat)


## Which will usually look like
#'data.frame':	364 obs. of  3 variables:
#$ MCFChannelGroupingPath: Factor w/ 364 levels "(unavailable)",..: 134 18 301 23 252 139 302 25 235 142 ...
#$ Conversions           : int  2508 1963 1021 554 395 384 291 252 242 138 ...
#$ Conversion.Value      : num  586.4 745.5 0 59.6 541.8 ...

## Make Sure Channel Grouping column is in Factor type and other two in integer or number
####################### Heuristics model ---------
##After checking the variables we move to the analysis and algorithmic part of the code 
## Arguments in the function will take your 1) data, 
#                                           2) Channel column as var_path
#                                           3) Conversions
#                                           4) Conversion value
heuristics<-heuristic_models(Data = dat,
                             var_path ='MCFChannelGroupingPath',
                             var_conv ='Conversions',
                             var_value = 'Conversion.Value')  

## This will give you first touch , Last touch and linear touch conversions of the channels

####################### Markov model ---------
## The main part comes into picture now,
## Following function will give you 1) weighted imputations of each channel
##                                  2) Channel to channel conversion probability
##                                  3) Removal Effects 

## It will take same arguments as previous , only order of the chain will increase also you have to mention the seperator for the same
markov<-markov_model(Data = dat,
                     var_path ='MCFChannelGroupingPath',
                     var_conv ='Conversions',order = 1,out_more = TRUE,
                     sep = ">",
                     var_value ='Conversion.Value')
## Always put out_more=True , this will give you transition matrix and Removal effect of the channel
## After this you can access or view your data using following commands

View(heuristics) ## To get simple heuristics
View(markov$result) ## To get weighted imputation of each channel
View(markov$transition_matrix) ## Transition probability
View(markov$removal_effects) ## Removal effect of all channels


## To Extract the same you can use command write.csv
write.csv(data you want to extract,"file name you want to give.csv")

########## Visualisation ---------
## You can visualize same in R using ggplot library
## Install if necessary
library(ggplot2)
library(reshape2)

## Merging data frame
Mergedframe<-merge(heuristics,markov$result,by = "channel_name")
# Selecting only relevant columns
Mergedframe <- Mergedframe[, (colnames(Mergedframe)%in%c('channel_name', 'first_touch_conversions', 'last_touch_conversions', 'linear_touch_conversions', 'total_conversions'))]
## We need all the values one by one , melting data frame

Mergedframe<-melt(Mergedframe,id = "channel_name")

## Now we have data frame ready, plotting it into R
ggplot(data = Mergedframe,aes(channel_name,value,fill = variable))+
  geom_bar(stat = "identity",position = "dodge")+
  ggtitle('Weighted Imputation')

## You can also change theme and colour of the bars as per your requirement 
## You can read more about ggplot here:  https://cran.r-project.org/package=ggplot2/ggplot2.pdf


#### Result #####
## Final graph will tell you though you are getting first touch or last touch conversions by any channel,
## but what is the weighted imputation of each channel
## How much it is contributing to your conversion irrespective of which attribution you use
## Removal effect from the markov model will tell you what is the net effect on your conversions or revenue when you remove a particular channel


