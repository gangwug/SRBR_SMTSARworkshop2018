# SRBR_SMTSARworkshop2018
Statistical Methods for Time Series Analysis of Rhythms (SMTSAR) workshop in 2018 SRBR Meeting

## Introduction
The SMTSAR workshop was hosted by Dr. Tanya Leise of Amherst College and Dr. John Hogenesch of the Cincinnati Children's Hospital Medical Center in 2018 SRBR meeting. The workshop demo for evaluating periodicity in large scale data using MetaCycle was lead by Dr. Marc D. Ruben. 

## Before the workshop

##### 1. Pre-install software
* Please visit [CRAN](https://cran.cnr.berkeley.edu) to download the latest released R (version 3.5.0) and install it on your laptop.

* Please visit [RStudio](https://www.rstudio.com/products/rstudio/download/) (an Integrated Development Environment that makes programming easier) to download the latest released RStudio Desktop (version 1.1.447) and install it on your laptop.

* If you only have Internet Explorer (IE) web browser on your laptop, please download and install another web browser (e.g. [Chrome](https://www.google.com/chrome/browser/desktop/) or [Firefox](https://www.mozilla.org/en-US/firefox/new/)). 

##### 2. Pre-install R packages

* Open RStudio. Check to make sure you’ve properly installed the latest version of R (as instructed above). You verify this by typing the following command: “sessionInfo()” into the Console window in RStudio. The top line of the output from this command should read: “R version 3.5.0.”

* If there are multiple R versions installed on your laptop, please follow [Using Different Versions of R](https://support.rstudio.com/hc/en-us/articles/200486138-Using-Different-Versions-of-R) to switch R version to the latest one. 

* In the Console window, copy and paste the line of code below (both lines). This will install all of the packages required for the workshop.

* Install ‘tidyverse’, 'shiny’, MetaCycle, and ggrepel packages
install.packages(c(‘tidyverse’, ‘shiny’, ‘MetaCycle’, ‘ggrepel’))

* Verify that the four packages have installed properly by opening the ‘Packages’ tab in the lower right quadrant of Studio. All packages that have been installed successfully will be listed. It is OK if the box next to the package name is not checked. During the workshop, we will load these packages into our workspace, at which time they will become checked boxes.

##### 3. Day of the workshop

* Bring a fully charged laptop!

* If your default web browser is Internet Explorer (IE), please [set default web browser](https://support.google.com/chrome/answer/95417?hl=en) to Chrome, Firefox or another one (IE does not play nice with the ’shiny' package). 

* Bring a great attitude :)

