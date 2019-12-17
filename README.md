# SRBR_SMTSARworkshop2018
Statistical Methods for Time Series Analysis of Rhythms Workshop in 2018 SRBR Meeting
This repository has the introduction and demo files used for the "Statistical Methods for Time Series Analysis of Rhythms" (SMTSAR) workshop at the 2016 SRBR meeting. 

## Introduction
The SMTSAR workshop will be hosted by Dr. Tanya Leise of Amherst College and Dr. John Hogenesch of the University of Cincinnati and the Cincinnati Children's Hospital Medical Center. This 90-minute workshop will give an overview of various statistical methods used for analyzing biological time-series data. The respective strengths and limitations of approaches will be discussed. Then, the workshop demo methods for evaluating periodicity in large scale data. During the demo, we will i) show how to analyze time-series datasets with various sampling resolution using [MetaCycle](http://biorxiv.org/content/early/2016/02/19/040345), and ii) do phase enrichment analysis with [PSEA](http://jbr.sagepub.com/content/31/3/244.long). Finally, we will leave 10 to 15 minutes in this workshop for participants, who are welcome to bring their own datasets and/or questions on analyzing time-series datasets to the workshop.

## Before the workshop

##### 1. Pre-installed software
* Please visit [CRAN](https://cran.cnr.berkeley.edu) to download the latest released R and install it on your notebook computer.
* Please visit [RStudio](https://www.rstudio.com/products/rstudio/download/) (an Integrated Development Environment that makes programming easier) to download the latest released RStudio Desktop and install it on your notebook computer.
* Please visit the [Java](http://java.com/en/download/manual.jsp) website to download the latest released Java and install it on your notebook computer.
* If you only have Internet Explorer (IE) web browser on your laptop, please download and install another web browser (e.g. [Chrome](https://www.google.com/chrome/browser/desktop/) or [Firefox](https://www.mozilla.org/en-US/firefox/new/)) on your notebook computer. 

##### 2. Pre-installed R packages

* Open RStudio and check the text at the top of the Console window to find the listed R version, which should be 'R version 3.3.0.'.
* If there are multiple R versions installed on your laptop, please follow [Using Different Versions of R](https://support.rstudio.com/hc/en-us/articles/200486138-Using-Different-Versions-of-R) to switch R version to the latest one. 
* In the Console window, type below command to install required packages.

```r
# install 'shiny' package
install.packages("shiny")
# install 'MetaCycle' package
install.packages("MetaCycle")
# install 'dplyr' package
install.packages("dplyr")
# install 'ggplot2' package
install.packages("ggplot2")
# install 'cowplot' package
install.packages("cowplot")
# install 'Bioconductor'
# try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite()
```

Please contact the workshop assistant (Gang Wu: wggucas@gmail.com) if you have problems in installing software or packages to your notebook computer.

##### 3. A little knowledge about R language

Knowing a little R language will be helpful for this workshop. If you have not used R before and are interested with learning R, take a quick tour in [DataCamp](https://www.datacamp.com/home), or [Try R](http://tryr.codeschool.com/levels/1/challenges/3) or [R tutorials](http://www.r-bloggers.com/how-to-learn-r-2/). At a minimum, please try the commands below in RStudio to learn a few basics about working with R.

```r
# Suppose that there is a directory named 'SRBR_SMTSARworkshop2016' in the 'Desktop' directory, 
# you could change the working directory to 'SRBR_SMTSARworkshop2016' through
# clicking 'Session | Set Working Directory | Choose Directory...', or by typing below command
setwd("~/Desktop/SRBR_SMTSARworkshop2016") 

# how to load an installed package
library(MetaCycle)
# how to find the help documentation about a function (eg. 'filter' function in 'dplyr' package)
library(dplyr)
?filter
# how to use the function by following the example part in the documentation file
filter(mtcars, cyl < 6)

# how to write the data to a file
write.csv(mtcars, file="mtcars.csv")
# how to read a file into a data frame
dataD <- read.csv("mtcars.csv")
# look at the top six rows of a data frame
head(dataD)
```

##### 4. Take a look at the demo files

The demo files are under 'demo' directory of this repository. The 'demo.html' file could be opened with the default web browser. 

##### 5. Download three repositories to your notebook computer

* Click [SRBR_SMTSARworkshop2016](https://github.com/gangwug/SRBR_SMTSARworkshop2016/archive/master.zip), [MetaCycleApp](https://github.com/gangwug/MetaCycleApp/archive/master.zip) and [PSEA](https://github.com/ranafi/PSEA/archive/master.zip) one by one to download each repository to your notebook computer.
* Unzip the downloaded repositories, and put them on the Desktop of your notebook computer.

##### 6. Prepare your own datasets if you hope to try them at the end of this workshop.
* Prepare your own datasets in the same format as the sample sets. See the file 'Hughes2009_MouseLiver1h.txt' provided in the 'data-raw' directory of the SRBR_SMTSARworkshop2016 repository as an example. 
* Each time series data will be a row of the spreadsheet, with a top header row and a leftmost column of labels, saved as a tab-delimited txt file or comm-delimited csv file.

## Day of the workshop
* Bring a fully charged notebook computer to the workshop.
* If your default web browser is IE, please [set default web browser](https://support.google.com/chrome/answer/95417?hl=en) to Chrome, Firefox or another one (IE does not work well with 'shiny' package). 
* Bring a great attitude.

## Update news

**Please keep track of this page, which may have updates (e.g. newly required packages or files for this demo).**

* ### Update news (May 19)

    + We put four new files in 'data' and 'result' directory.
    + We will leave a message in this page when the final presentation files are uploaded in 'demo' directory.
    + For windows users, please change the default download folder to Desktop and follow the instructions for [Chrome](https://support.google.com/chrome/answer/95759?co=GENIE.Platform%3DDesktop&hl=en) or [Firefox](http://audible.custhelp.com/app/answers/detail/a_id/4661/~/how-can-i-change-my-download-location-using-firefox%3F).
