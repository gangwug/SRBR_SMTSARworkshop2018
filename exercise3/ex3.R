#Exercise 3: RNA-seq read depth 

#By the end of this exercise, you should be able to:
#1. Understand the impact of sequencing depth on analysis of periodic data.  

#Exercise3 dataset: RNAseq Drosophila heads sampled every 2h for 48h. 
#unpublished data kindly provided by Michael Hughes & JiaJia Li (Washington University School of Medicine in St Louis) for this workshop

#Step 1. Clear environment from previous exercise
rm(list=ls())

#Step 2. Load the following packages:
library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)
library(shiny)
library(MetaCycle)
library(ggrepel)


#Step 3. Run Metacycle (JTK) on time series data generated from one of five different max sequencing depths:
#a) Each group member should choose only ONE depth to run. BUT, as before in exercise 2, be sure that there
#is at least one member in the group for each one (i.e., member1 runs Depth1, member2 runs Depth2, etc.)

#Depth 1: 0.625M 
#Depth 2: 1.25M
#Depth 3: 2.5M
#Depth 4: 5M
#Depth 5: 10M

#Use the 'runApp' function from the shiny package to run MetaCycle, set parameters as specified below:
runApp("./SRBR/MetaCycleApp")
#Choose Data File: 'ex3_depth1.csv' or 'ex3_depth2.csv', etc, ACCORDING TO YOUR SEQ DEPTH
#Minper: '24'
#Maxper: '24'
#cycMethod: 'JTK'
#Save download as: 'ex3_meta2d.csv', be sure to save in 'exercise3' folder

#Step 4. Find the number of cycling genes at Q <= 0.05?
#a) Load your MetaCycle output.
dat <- read.csv("./SRBR/exercise3/ex3_meta2d.csv")

#b) Apply filter and arrange (you're now an expert at this :)
signif <- dat %>%
  filter(JTK_BH.Q <= 0.05) %>%
  arrange(JTK_BH.Q)

#GROUP THINK: take a minute to discuss among your group...
#i) How many cyclers are you discovering?
#ii) How do the results compare for different sequencing depths?
#iii) Is it possible to improve the detection of cycling genes?

#Step 5. Plot the number of cycling genes under different Q value cutoffs for ALL sequencing depths, according to meta2d.
load("./SRBR/exercise3/ex3.rda")
cuts <- c(0.5, 0.4, 0.3, 0.2, 0.1, 0.05, 0.005, 0.0005, 0.00005)
QvG <- NULL
for (i in 1:length(cuts)) {
  tp <- ex3 %>% 
    group_by(dataset) %>% 
    summarise(genes = sum(meta2d_BH.Q < cuts[i])) %>%
    mutate(fdr = as.numeric(cuts[i]))
  QvG <- bind_rows(QvG, tp)
}
ggplot(QvG, aes(x = fdr, y=genes, color = dataset, group = dataset, label = genes)) +
  geom_line (size = 1) +
  geom_point(size = 3, alpha = 0.8) +
  geom_text_repel(aes(label = genes)) +
  scale_x_continuous(breaks = c(0.00005, .0005,.005,.05, .1, .2, .3, .4, .5), labels=c("0.00005", "0.0005", "0.005", "0.05", "0.1", "0.2", "0.3", "", "0.5")) +
  scale_y_continuous(breaks = seq(0, 600, 50)) +
  coord_trans(x = "log10") +
  labs(title = "", x = "meta2d_BH.Q", y = "Number of cycling genes") +
  theme_bw() +
  theme(axis.title=element_text(size=14), axis.text.y = element_text(size=14),
        axis.text.x = element_text(size=14), legend.text = element_text(size =14),
        legend.title = element_text(size=14)) 

#GROUP THINK: take a minute to discuss among your group...
#i) How did Metacycle increase the number of detectable cycling genes? 
#ii) What can we say about the impact of sequencing depth in the fly? Mouse? Human?


#Step 6. How does sequencing depth impact temporal profile of a single clock gene?
#Use dplyr functions to prepare data for ggplot as done in exercise 1.
clk <- "tim"
plt <- ex3 %>% filter(CycID == clk) %>%
  gather(time, expression, as.character(seq(24, 70, 2))) %>%
  mutate(time = as.numeric(time))
labels <- plt %>%
  group_by(dataset) %>%
  filter(expression == max(expression)) %>%
  mutate_at(vars(meta2d_BH.Q, meta2d_pvalue), funs(round(digits = 6, .))) %>%
  ungroup(CycID)
ggplot(plt, aes(x = time, y = expression, group = dataset)) +
  geom_point() +
  geom_line() +
  geom_text(aes(x = 60, y = expression), data = labels, label = paste("Pval = ", labels$meta2d_pvalue, sep = ""), size = 3) +
  geom_text(aes(x = 60, y = expression * 0.9), data = labels, label = paste("BH.Q = ", labels$meta2d_BH.Q, sep = ""), size = 3) +
  scale_y_continuous(expand = c(0.1, 0.1)) +
  scale_x_continuous(expand = c(0.01, 0.01), breaks = seq(24, 70, by = 2)) +
  labs(x = "Circadian Time", y = "Expression") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  facet_wrap(~ dataset, scales = "free_y", ncol = 2)

##GROUP THINK: take a minute to discuss among your group...
#i) How does sequencing depth impact the temporal profile of a single clock gene?