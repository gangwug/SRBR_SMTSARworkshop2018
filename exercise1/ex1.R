#Exercise 1: Intro to R & MetaCycle

#Initial Setup:
#Open RStudio
#Open exercise 1. Toolbar at top: File > Open File > Desktop > SRBR > exercise1 > ex1.R

#1) Set working drive to your desktop. Toolbar at top: Session > Set Working Directory > Choose Working Directory > DESKTOP
#verify that the workspace is your desktop by running "getwd()" in the Console

#By the end of this exercise, you should be able to:
#1  Work within RStudio, and apply R grammar to transform, subset, and visualize data. 
#2  Run the MetaCycle application and understand its key parameters.
#3. Appreciate the impact of algorithm choice when analyzing periodic data.

#RStudio is an integrated development environment (IDE) for R programming. 
#It defaults to this 4-quadrant layout: 
#Upper left: editing workspace for writing code; can be saved at any time
#Lower left: console from which code is run. You can write directly in cosole, or select from editor & run
#Upper right: global environment where variables, objects, and functions you create are visible (you'll see as we get going)
#Lower right: offers a bunch of things, file directory, plot viewer, list of installed packages, help menu
#NOW IS A GREAT TIME TO VERIFY THAT YOU HAVE ALL OF THE NECESSARY PACKAGES INSTALLED!!

#Exercise1 dataset: Hughes et. al 2009, array data from mouse liver sampled every 1hr for 48hr in constant darkness

#Load the following packages (to run code, select & click 'Run' in toolbar)
#note: these packages are already installed, here using 'library' function we are loading them for this session
library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)
library(shiny)
library(MetaCycle)

#Step 1. Use MetaCycle to identify gene rhythmic gene expression in mouse liver dataset  
# a) Use the 'runApp' function from the shiny package to run MetaCycle, set parameters as specified below:
runApp("./SRBR/MetaCycleApp")
#Choose Data File: 'ex1_data.csv' (reminder: this is mouse liver gene expression sampled every 1hr for 48hr)
#Minper: '24'
#Maxper: '24'
#cycMethod: 'JTK'
#Save download as: 'ex1_meta2d.csv'; be sure to save in 'exercise1' folder

# b) Load the MetaCycle output.
#Use 'read.csv' function, specifying the file directory and name, and store results in a dataframe.
dat <- read.csv("./SRBR/exercise1/ex1_meta2d.csv")
#Look at the dataframe by clicking on 'dat' in upper right 'Global Environment' panel
#Note that this is only a subset (n = 2K genes) of the entire genome

#Question: how can we subset and rank all the genes that fall below a particular Q-val?
#Answer: The R package 'dplyr' provides a simple grammar with a few key verbs

#Step 3. The code below uses dplyr structure to do this:
#Functions (e.g., filter, arrange) can be chained together using the 'pipe' (%>%) symbol.
#Variables that precede the pipe are treated as input to functions that follow the pipe.
#You can think of the %>% as a "then do"...
#i) Define new variable 'signif' and set it equal to our 'dat' dataframe that we want to subset,
#ii) Pipe symbol says then 'filter', 
#iii) Filter fxn takes a variable (JTK_BH.Q) and value (0.05) as arguments, only rows where this is true are kept
#iv) Another pipe symbol says then 'arrange',
#v) Arrange fxn sorts rows by a specified variable (JTK_BH.Q) from low to high 

signif <- dat %>%
  filter(JTK_BH.Q <= 0.05) %>%
  arrange(JTK_BH.Q)

#Take a look at the 'signif' dataframe
#Note the sorted dataframe. Sorting can also be done in the object viewer by clicking on the variable name


#Step 4. From the list of cycling genes, let's look at some time-series plots!
#a) Create a character vector named where each element is a gene we're interested in plotting
cyc <- c("Arntl", "Npas2", "Nr1d1", "Cry1", "Dbp", "Ciart", "Snapc1", "Ufd1l")

#b) Define new variable 'cyc_signif', set it equal to our 'signif' dataframe, then (%>%) filter...
# Filter any row where CycID (i.e., gene name) matches any element in the 'cyc' vector.
cyc_signif <- signif %>%
  filter(CycID %in% cyc)
#Take a look at the 'cyc_signif' dataframe

#We've not got all the information we want to plot stored in this new dataframe.
#The next two blocks of code we'll breeze through. You can pick apart what is happening later, and/or...
#Check out this awesome instructional on R programming: http://r4ds.had.co.nz/

#FYI, Step 5 is simply a rearrangment of the data for the purposes of plotting in R.
#Currently, the cyc_signif dataframe stores each time point in its own column. This is called 'wide' data.
#For plotting in R, we need to rearrange so that all time points and corresponding values are stacked into just two columns.

#Step 5. Transform data from 'wide' to 'narrow' format to make plot-friendly, the key function here is 'gather'. 
plt <- cyc_signif %>%
  gather(time, expression, X18:X65) %>%
  mutate(time = as.numeric(gsub("X", "", time)), CycID = factor(CycID, levels = cyc))
#take a look at the narrow format by clicking on 'plt' in upper right panel called 'Global Environment'.


#Step 6. create separate dataframe to support plot labels; it isn't necessary but it's helpful.
labels <- plt %>%
  group_by(CycID) %>%
  filter(expression == max(expression)) %>%
  mutate_at(vars(meta2d_AMP, meta2d_rAMP), funs(round(digits = 2, .))) %>%
  ungroup(CycID)


#Step 7. Use the ggplot package to make our plots from our dataframe!
#There are many extra lines of code to pretty things up, BUT the first 4 lines contain the core elements.
#Line1) Specify the dataframe 'plt' which contains the data we're plotting, and
#create aesthetics, which can take many arguments, but most essentially defining your x- and y-axes variables.
#Line 2 & 3) Define the type of plot; you can see we're wanting for both points and lines
#Line 4) A wonderful function called 'facet_wrap' which separates the plot into different panels by any variables,
#here, we want a panel for each of the 8 genes in our dataframe

ggplot(plt, aes(x = time, y = expression, group = CycID)) +
  geom_point() +
  geom_line() +
  facet_wrap(~ CycID, scales = "free_y", ncol = 2) +
  geom_text(aes(x = 50, y = expression), data = labels, label = paste("Amp = ", labels$meta2d_AMP, sep = ""), size = 3) +
  geom_text(aes(x = 50, y = expression * 0.9), data = labels, label = paste("rAmp = ", labels$meta2d_rAMP, sep = ""), size = 3) +
  scale_y_continuous(expand = c(0.1, 0.1)) +
  scale_x_continuous(expand = c(0.01, 0.01), breaks = seq(18, 65, by = 1)) +
  labs(x = "Circadian Time", y = "Expression", title = "Mouse Liver 1hr,  2days") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
  
#The plot should automatically show in the viewer to right. Click 'Zoom'.

#GROUP THINK: take a minute to discuss among your group -- what do you take away from these plots?

#Step 8. How does choice of algorithm (JTK versus other) influence results?
#So far, we've run JTK. MetaCycle also allows ARSER and Lomb Scargle (LS).
#The intro touched upon relative strengths/weaknesses of these three methods.
#To see the differences in practice, we've prepared output for ARSER and LS, just as you've already done for JTK.
#Open the jpg image in exercise1 folder. Showing distribution of Q-values for three methods. Left: full range from 0-1, Right shows from 0 to 0.05.

#GROUP THINK: take a minute to discuss among your group -- what do you take away from these plots?