# Load files
install.packages("tidyverse")
install.packages("car")
install.packages("ape")
install.packages("DAAG")
install.packages("Hmisc")
install.packages("dplyr")
install.packages("caret")
install.packages(c("haven", "sas7bdat"))
install.packages("leaps")
install.packages("randomForest")

library(latticeExtra)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(car)
library(ape)
library(DAAG)
library(broom)
library(Hmisc)
library(sas7bdat)
library(RColorBrewer)
require(grDevices)
require(graphics)
library(caret)
library(leaps)
library(randomForest)
#library(ncdf)
options(digits=16)

dhaka_site_list <- read.csv("dhaka_site_list.csv", header = T, sep = ",")
pop_buffer50 <- read.csv("dhaka_pop50.csv", header = T, sep = ",")
pop_buffer100 <- read.csv("dhaka_pop100.csv", header = T, sep = ",")
pop_buffer150 <- read.csv("dhaka_pop150.csv", header = T, sep = ",")
pop_buffer250 <- read.csv("dhaka_pop250.csv", header = T, sep = ",")
pop_buffer500 <- read.csv("dhaka_pop500.csv", header = T, sep = ",")
pop_buffer750 <- read.csv("dhaka_pop750.csv", header = T, sep = ",")
pop_buffer1000 <- read.csv("dhaka_pop1000.csv", header = T, sep = ",")
pop_buffer1250 <- read.csv("dhaka_pop1250.csv", header = T, sep = ",")
pop_buffer1500 <- read.csv("dhaka_pop1500.csv", header = T, sep = ",")
pop_buffer2000 <- read.csv("dhaka_pop2000.csv", header = T, sep = ",")
pop_buffer3000 <- read.csv("dhaka_pop3000.csv", header = T, sep = ",")
pop_buffer5000 <- read.csv("dhaka_pop5000.csv", header = T, sep = ",")


# Run this part for each variable (e..g, rest_buffer100, rest_buffer150, etc. 
sum_var = pop_buffer5000$pop_count ; # varaible to be summarized. YOU HAVE TO CHANGE HERE;  'rest_buffer100$rest_count' this part
site_id = pop_buffer5000$site_id # summarize by. YOU HAVE TO CHANGE HERE; NEW VARIABLE NAME., 'rest_buffer100$site_id' this part
temp <- summarize(sum_var,site_id, sum, na.rm=TRUE)  # use sumarize function to sumarize the varaible by "site_id"; you need to change the fundction (e.g., sum, mean) as required)


df_temp = data.frame(site_id = temp$site_id, sum_var = temp$sum_var) # just to create a temporary dataframe to fit with the merge funciton
df_merge <- merge(dhaka_site_list, df_temp, by = "site_id", all = TRUE) # use merge function to merge two dataframe (site list and df_temp) by "site_id"
df_merge[is.na(df_merge)] <- 0 # remove NA in merged dataframe by 0

pop_5000 = df_merge$sum_var # Rename the sumarized variables to save as a desired convention. YOU HAVE TO CHANGE HERE; NEW VARIABLE NAME; You can change new name here for each variable. R will store the data as you give the name; rest_s100, rest_s150, etc


data4save <- data.frame(site_name =dhaka_site_list$site_name , site_id = dhaka_site_list$site_id, pop_50,pop_100,pop_150,pop_250,pop_500,pop_750,pop_1000,pop_1250,pop_1500,pop_2000,pop_3000,pop_5000) # Create a data frame for variables to be saved; say rest_count at different buffers
write.csv(data4save, file ='dhaka_population_count.csv') # save as csv
