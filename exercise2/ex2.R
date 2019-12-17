	#Exercise 2: Samping resolution and the errors of Venn diagrams

#By the end of this exercise, you should be able to:
#1. Understand the impact of sampling resolution on analysis of periodic data.  
#2. Appreciate that venn-style demonstration of 'overlap' can be misleading. 

#Exercise2 dataset: Hughes et. al. 2009, array data from mouse liver sampled every 1hr for 48hr in constant darkness

#Step 1. Clear environment from previous exercise
rm(list=ls())

#Step 2. Load the following packages (they should already be installed!)
library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)
library(shiny)
library(MetaCycle)
library(ggrepel)

#Question: How does sampling resolution impact the detection of rhythms?

#Step 1. Load the 'gold standard' Hughes et. al. dataset, Found in exercise2 folder.
dat <- read.csv("./SRBR/exercise2/ex2_data1.csv", check.names = FALSE)

#Step 2. Subset the 'gold standard' down to a lower sampling resolution.
#a) Each of the 5 lines of code below (Res1, Res2, etc.) specify a different resolution.
#Each group member should choose only ONE resolution to run. BUT, be sure that there
#is at least one member in the group for each one (i.e., member1 runs Res1, member2 runs Res2, etc.)

#b) The line of code that you run below will create a vector of column indices,
#corresopnding to the sampling resolution indicated.

#Res1
smpl_res <- seq(2,25,4) #every 4hr for 24hr (6 total points)

#Res2
smpl_res <- seq(2,49,6) #every 6hr for 48hr (8 total points)

#Res3
smpl_res <- seq(2,49,4) #every 4hr for 48hr (12 total points)

#Res4
smpl_res <- seq(2,25,2) #every 2hr for 24hr (12 total points)

#Res5
smpl_res <- seq(2,49,2) #every 2hr for 48hr (24 total points)


#c) Using the vector, create a new dataframe with your specified resolution
#Use dplyr's 'select' function, which will keep only the columns from the 'gold standard' 
#dataframe that are called (either by variable name, or indices)
sub_dat <- dat %>%
  select(GeneSymbol, smpl_res)

#d) Save this subset to the exercise2 folder as 'ex2.mysubset' 
write_csv(sub_dat, "./SRBR/exercise2/ex2_mysubset.csv")  

#Step 3. Run MetaCycle on your subset
runApp("./SRBR/MetaCycleApp")
#Adjust the following parameters in MetaCycle --
#Choose Data File: 'ex2.mysubset.csv'
#Minper: '24'
#Maxper: '24'
#cycMethod: 'JTK'
#Save downloaded output as: 'ex2_mysubset_meta2d.csv'; be sure to save in exercise2 folder


#Step 4a) Load MetaCycle results
sub_meta <- read.csv("./SRBR/exercise2/ex2_mysubset_meta2d.csv")

#b) Add a variable to the dataframe that identifies the dataset.
#The 'mutate' function is like excel 'insert column' and allows you to specify the contents
#Use 'select' to keep only the variables were are interested in
sub_meta_c <- sub_meta %>%
  mutate(dataset = "subset") %>%
  select(dataset, CycID, JTK_BH.Q)

#We want to compare our subsetted results to the gold-standard, so let's load that up...

#c) Load MetaCycle output from the 'gold-standard' dataset (pre-run)
gldstd_meta <- read.csv("./SRBR/exercise2/ex2_data2.csv", check.names = FALSE) %>%
  mutate(dataset = "gold_std") %>%
  select(dataset, CycID, JTK_BH.Q)


#Step 5. Calculate & plot the numbers of circadian genes identified in gold-standard vs. your subset
#q) Combine subset and gold-standard into a single dataframe
combi <- bind_rows(sub_meta_c, gldstd_meta)

#b) set value of the 'mysubset' variable to YOUR! sampling resolution (eg., "12hr2day")
mysubset <- "2hr2day"

#c) Run function 'QvGene'
#feel free to take a look at the code behind the function, found in the funx.R script
source("./SRBR/exercise2/funx.R")
QvG <- QvGene(combi)
#take a look at the QvG dataframe showing number of circadian genes at a series of JTK.Q-value thresholds 

#d) Plot the results
ggplot(QvG, aes(x = fdr, y=genes, color = dataset, group = dataset, label = genes)) +
  geom_line (size = 1) +
  geom_point(size = 5, colour = "white") +
  geom_point(size = 3, alpha = 0.8) +
  geom_text_repel(aes(label = genes)) +
  scale_x_continuous(breaks = c(0.00005, .0005,.005,.05, .1, .2, .3, .4, .5), labels=c("0.00005", "0.0005", "0.005", "0.05", "0.1", "0.2", "0.3", "", "0.5")) +
  scale_y_continuous(breaks = seq(0, 18000, 2000)) +
  scale_color_manual(values = c("#E69F00", "#C0717C", "#3F4921")) +
  coord_trans(x = "log10") +
  labs(title = paste(mysubset, " vs gold standard", sep = ""), x = "JTK.Q-value", y = "Number of cycling genes") +
  theme_bw() +
  theme(axis.title=element_text(size=14), axis.text.y = element_text(size=14),
        axis.text.x = element_text(size=14), legend.text = element_text(size =14),
        legend.title = element_text(size=14)) 

#GROUP THINK: take a minute to discuss among your group...
#i) What, if any, benefit is there to looking at cycling genes across a range of FDR thresholds? 
#ii) How do the different sampling resolutions compare to the 'gold-standard'?  
#iii) What are the key trade-offs being made when choosing between 'high' vs. 'low' sampling resolutions?
#FYI, check it out:  the CircaInSilico web-based app (Hughes et. al. 2017 'Guidelines for Genome-Scale Analysis of Biological Rhythms') is useful for simulating the impact of different designs on type1/2 errors.
