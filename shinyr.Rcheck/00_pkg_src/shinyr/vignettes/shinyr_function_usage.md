---
title: shinyr - R package to build analytics dashboard automatically.
author: Pushker Ravindra, Jayachandra N
date: September 5, 2019
output:
  prettydoc::html_pretty:
    theme: cayman
    highlight: html_document
# output: html_document
#   prettydoc::html_pretty:
#     theme: cayman
---



### **shinyr** is developed to build dynamic shiny based dashboards to analyze the data of your choice.  It provides simple yet genius dashboard design to subset the data, perform exploratory analysis and predictive analysis by means of interactive filter mechanism.

#### **NOTE: shinyr package does not mis-use your data, your data is not being copied or migrated to anywhere. **

## Installing shinyr package
##### You can install shinyr package like how you install any other package from CRAN. simply fallow the folloing commands to install the package.

```r
install.packages("shinyr")
library(shinyr)
```

## shinyr dependencies
#### shinyr was developed using R programming and few R packages mentioned below along with bit of js and css.
1. R >= 3.3.1 version 
2. Following R packages 
    + shiny
    + shinydashboard
    + dplyr
    + tm
    + wordcloud
    + corrplot
    + RColorBrewer
    + RandomForest
    + caret
    + nnet
    + DMwR 
    + plotly
  
## Build dynamic dashboard using shinyr
#### Do you have your data in a csv/xlsx file and you want to get some insights of the data? Cool you can use shinyr package to build a simple dashboard for your data with filters for each of your columns. 
* You can get insights such as dimention of data, column types, some stats on each column, correlation, missing values. 
* You can Impute the missing values with mean, median, max, min or sum of that erticular column. 
* You can aggregate/summarize values of one column by grouping values on other column.
* You can perform exploratory analysis by simple yet iinformative vsualizations such as bar plot, wordcloud, line, box, and 3D plots. 
* You can also train regression, logit regression and random forest models, check model performance, predict and validate models with simple clicks.
* Run the following commands and upload your data and click on build button to create dashboard for your data. You can also choose one few example datasets from your R session.


```r
library(shinyr) 
shinyr::shineMe()
```


## Get list of data sets from your session.
valid_sets() will give all the data sets that are available in the data frame

```r
library(shinyr)
dsets <- shinyr::valid_sets()
knitr::kable(dsets)
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> Package </th>
   <th style="text-align:left;"> LibPath </th>
   <th style="text-align:left;"> Item </th>
   <th style="text-align:left;"> Title </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> LifeCycleSavings </td>
   <td style="text-align:left;"> Intercountry Life-Cycle Savings Data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> OrchardSprays </td>
   <td style="text-align:left;"> Potency of Orchard Sprays </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> Puromycin </td>
   <td style="text-align:left;"> Reaction Velocity of an Enzymatic Reaction </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> ToothGrowth </td>
   <td style="text-align:left;"> The Effect of Vitamin C on Tooth Growth in Guinea Pigs </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> USArrests </td>
   <td style="text-align:left;"> Violent Crime Rates by US State </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> USJudgeRatings </td>
   <td style="text-align:left;"> Lawyers' Ratings of State Judges in the US Superior Court </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> airquality </td>
   <td style="text-align:left;"> New York Air Quality Measurements </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> anscombe </td>
   <td style="text-align:left;"> Anscombe's Quartet of 'Identical' Simple Linear Regressions </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> attenu </td>
   <td style="text-align:left;"> The Joyner-Boore Attenuation Data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> attitude </td>
   <td style="text-align:left;"> The Chatterjee-Price Attitude Data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 53 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> esoph </td>
   <td style="text-align:left;"> Smoking, Alcohol and (O)esophageal Cancer </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> freeny </td>
   <td style="text-align:left;"> Freeny's Revenue Data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 62 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> infert </td>
   <td style="text-align:left;"> Infertility after Spontaneous and Induced Abortion </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 63 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> iris </td>
   <td style="text-align:left;"> Edgar Anderson's Iris Data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 68 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> longley </td>
   <td style="text-align:left;"> Longley's Economic Regression Data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 71 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> morley </td>
   <td style="text-align:left;"> Michelson Speed of Light Data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 72 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> mtcars </td>
   <td style="text-align:left;"> Motor Trend Car Road Tests </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 75 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> npk </td>
   <td style="text-align:left;"> Classical N, P, K Factorial Experiment </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 80 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> quakes </td>
   <td style="text-align:left;"> Locations of Earthquakes off Fiji </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 81 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> randu </td>
   <td style="text-align:left;"> Random Numbers from Congruential Generator RANDU </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 83 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> rock </td>
   <td style="text-align:left;"> Measurements on Petroleum Rock Samples </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 84 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> sleep </td>
   <td style="text-align:left;"> Student's Sleep Data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 87 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> stackloss </td>
   <td style="text-align:left;"> Brownlee's Stack Loss Plant Data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 98 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> swiss </td>
   <td style="text-align:left;"> Swiss Fertility and Socioeconomic Indicators (1888) Data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 100 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> trees </td>
   <td style="text-align:left;"> Girth, Height and Volume for Black Cherry Trees </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 103 </td>
   <td style="text-align:left;"> datasets </td>
   <td style="text-align:left;"> /usr/lib/R/library </td>
   <td style="text-align:left;"> warpbreaks </td>
   <td style="text-align:left;"> The Number of Breaks in Yarn during Weaving </td>
  </tr>
</tbody>
</table>


## Select and load any inbuilt data
In case you want to load any data sets from the list of datasets from return of valis_sets() function you can use base::get() function to load the data sets. this will help you to choose on data sets to load dynamycally in any program.


```r
mtcars <- get(dsets$Item[dsets$Item == "mtcars"])
knitr::kable(head(mtcars))
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> mpg </th>
   <th style="text-align:right;"> cyl </th>
   <th style="text-align:right;"> disp </th>
   <th style="text-align:right;"> hp </th>
   <th style="text-align:right;"> drat </th>
   <th style="text-align:right;"> wt </th>
   <th style="text-align:right;"> qsec </th>
   <th style="text-align:right;"> vs </th>
   <th style="text-align:right;"> am </th>
   <th style="text-align:right;"> gear </th>
   <th style="text-align:right;"> carb </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Mazda RX4 </td>
   <td style="text-align:right;"> 21.0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.90 </td>
   <td style="text-align:right;"> 2.620 </td>
   <td style="text-align:right;"> 16.46 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mazda RX4 Wag </td>
   <td style="text-align:right;"> 21.0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.90 </td>
   <td style="text-align:right;"> 2.875 </td>
   <td style="text-align:right;"> 17.02 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Datsun 710 </td>
   <td style="text-align:right;"> 22.8 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;"> 3.85 </td>
   <td style="text-align:right;"> 2.320 </td>
   <td style="text-align:right;"> 18.61 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet 4 Drive </td>
   <td style="text-align:right;"> 21.4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 258 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.08 </td>
   <td style="text-align:right;"> 3.215 </td>
   <td style="text-align:right;"> 19.44 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet Sportabout </td>
   <td style="text-align:right;"> 18.7 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 360 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 3.15 </td>
   <td style="text-align:right;"> 3.440 </td>
   <td style="text-align:right;"> 17.02 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Valiant </td>
   <td style="text-align:right;"> 18.1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 225 </td>
   <td style="text-align:right;"> 105 </td>
   <td style="text-align:right;"> 2.76 </td>
   <td style="text-align:right;"> 3.460 </td>
   <td style="text-align:right;"> 20.22 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
</tbody>
</table>

## Find the numeric columns in the given data frame
To figure the class of each column in the given data frame use getnumericcols() it return the column names which are numeric

```r
getnumericCols(mtcars)
```

```
##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
## [11] "carb"
```

## Split the given sentence into words
to split paragraph or sentence to induvidial words use splitAndGet(), it returns the list of induvidual words in the given input which can be later used by getFeqTable()

```
## [[1]]
##  [1] "**shinyr**"  "is"          "developed"   "to"          "build"      
##  [6] "dynamic"     "shiny"       "based"       "dashboards"  "to"         
## [11] "analyze"     "the"         "data"        "of"          "your"       
## [16] "choice."     ""            "It"          "provides"    "simple"     
## [21] "yet"         "genius"      "dashboard"   "design"      "to"         
## [26] "subset"      "the"         "data,"       "perform"     "exploratory"
## [31] "analysis"    "and"         "predictive"  "analysis"    "by"         
## [36] "means"       "of"
```

## Get the frequency table for given sentence
getFeqTable will be used on the output of spliAndGet() to get the frequency of each word, which will be used by getWordCloud
<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> word </th>
   <th style="text-align:right;"> freq </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> analysis </td>
   <td style="text-align:left;"> analysis </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> data </td>
   <td style="text-align:left;"> data </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> analyze </td>
   <td style="text-align:left;"> analyze </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> based </td>
   <td style="text-align:left;"> based </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> build </td>
   <td style="text-align:left;"> build </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> choice </td>
   <td style="text-align:left;"> choice </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> dashboard </td>
   <td style="text-align:left;"> dashboard </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> dashboards </td>
   <td style="text-align:left;"> dashboards </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> design </td>
   <td style="text-align:left;"> design </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> developed </td>
   <td style="text-align:left;"> developed </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> dynamic </td>
   <td style="text-align:left;"> dynamic </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> exploratory </td>
   <td style="text-align:left;"> exploratory </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> genius </td>
   <td style="text-align:left;"> genius </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> means </td>
   <td style="text-align:left;"> means </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> perform </td>
   <td style="text-align:left;"> perform </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> predictive </td>
   <td style="text-align:left;"> predictive </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> provides </td>
   <td style="text-align:left;"> provides </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> shiny </td>
   <td style="text-align:left;"> shiny </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> shinyr </td>
   <td style="text-align:left;"> shinyr </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> simple </td>
   <td style="text-align:left;"> simple </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> subset </td>
   <td style="text-align:left;"> subset </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> yet </td>
   <td style="text-align:left;"> yet </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
</tbody>
</table>

## Word cloud using the frequency table
Use getWordCloud() to plot word cloud.

```r
getWordCloud(x)
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8-1.png)

## Get basic insights to the data
getDataInsights() takes data frame as an input and returns the basic insights such as class, number of values missing, maximum, min, var, sd, mean, median, unique items for each column. 
<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Column </th>
   <th style="text-align:left;"> Class </th>
   <th style="text-align:left;"> Missing </th>
   <th style="text-align:left;"> Max </th>
   <th style="text-align:left;"> Min </th>
   <th style="text-align:left;"> Mean </th>
   <th style="text-align:left;"> Median </th>
   <th style="text-align:left;"> SD </th>
   <th style="text-align:left;"> Variance </th>
   <th style="text-align:left;"> Unique_items </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> mpg </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 33.9 </td>
   <td style="text-align:left;"> 10.4 </td>
   <td style="text-align:left;"> 20.09 </td>
   <td style="text-align:left;"> 19.2 </td>
   <td style="text-align:left;"> 6.03 </td>
   <td style="text-align:left;"> 36.32 </td>
   <td style="text-align:left;"> 21,22.8,21.4,18.7,18.1,14.3,24.4,19.2,17.8,16.4,17.3,15.2,10.4,14.7,32.4,30.4,33.9,21.5,15.5,13.3,27.3,26,15.8,19.7,15 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cyl </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 6.19 </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> 1.79 </td>
   <td style="text-align:left;"> 3.19 </td>
   <td style="text-align:left;"> 6,4,8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> disp </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 472 </td>
   <td style="text-align:left;"> 71.1 </td>
   <td style="text-align:left;"> 230.72 </td>
   <td style="text-align:left;"> 196.3 </td>
   <td style="text-align:left;"> 123.94 </td>
   <td style="text-align:left;"> 15360.8 </td>
   <td style="text-align:left;"> 160,108,258,360,225,146.7,140.8,167.6,275.8,472,460,440,78.7,75.7,71.1,120.1,318,304,350,400,79,120.3,95.1,351,145,301,121 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hp </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 335 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 146.69 </td>
   <td style="text-align:left;"> 123 </td>
   <td style="text-align:left;"> 68.56 </td>
   <td style="text-align:left;"> 4700.87 </td>
   <td style="text-align:left;"> 110,93,175,105,245,62,95,123,180,205,215,230,66,52,65,97,150,91,113,264,335,109 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> drat </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 4.93 </td>
   <td style="text-align:left;"> 2.76 </td>
   <td style="text-align:left;"> 3.6 </td>
   <td style="text-align:left;"> 3.7 </td>
   <td style="text-align:left;"> 0.53 </td>
   <td style="text-align:left;"> 0.29 </td>
   <td style="text-align:left;"> 3.9,3.85,3.08,3.15,2.76,3.21,3.69,3.92,3.07,2.93,3,3.23,4.08,4.93,4.22,3.7,3.73,4.43,3.77,3.62,3.54,4.11 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wt </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 5.424 </td>
   <td style="text-align:left;"> 1.513 </td>
   <td style="text-align:left;"> 3.22 </td>
   <td style="text-align:left;"> 3.33 </td>
   <td style="text-align:left;"> 0.98 </td>
   <td style="text-align:left;"> 0.96 </td>
   <td style="text-align:left;"> 2.62,2.875,2.32,3.215,3.44,3.46,3.57,3.19,3.15,4.07,3.73,3.78,5.25,5.424,5.345,2.2,1.615,1.835,2.465,3.52,3.435,3.84,3.845,1.935,2.14,1.513,3.17,2.77,2.78 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> qsec </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 22.9 </td>
   <td style="text-align:left;"> 14.5 </td>
   <td style="text-align:left;"> 17.85 </td>
   <td style="text-align:left;"> 17.71 </td>
   <td style="text-align:left;"> 1.79 </td>
   <td style="text-align:left;"> 3.19 </td>
   <td style="text-align:left;"> 16.46,17.02,18.61,19.44,20.22,15.84,20,22.9,18.3,18.9,17.4,17.6,18,17.98,17.82,17.42,19.47,18.52,19.9,20.01,16.87,17.3,15.41,17.05,16.7,16.9,14.5,15.5,14.6,18.6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vs </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0.44 </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0.5 </td>
   <td style="text-align:left;"> 0.25 </td>
   <td style="text-align:left;"> 0,1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> am </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0.41 </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0.5 </td>
   <td style="text-align:left;"> 0.25 </td>
   <td style="text-align:left;"> 1,0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> gear </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 3.69 </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 0.74 </td>
   <td style="text-align:left;"> 0.54 </td>
   <td style="text-align:left;"> 4,3,5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> carb </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2.81 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 1.62 </td>
   <td style="text-align:left;"> 2.61 </td>
   <td style="text-align:left;"> 4,1,2,3,6,8 </td>
  </tr>
</tbody>
</table>

## Correlation table 
getDataInsight() also calculates the correlation table for the given data frame.

```r
knitr::kable(res$cor_matrix)
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> mpg </th>
   <th style="text-align:right;"> cyl </th>
   <th style="text-align:right;"> disp </th>
   <th style="text-align:right;"> hp </th>
   <th style="text-align:right;"> drat </th>
   <th style="text-align:right;"> wt </th>
   <th style="text-align:right;"> qsec </th>
   <th style="text-align:right;"> vs </th>
   <th style="text-align:right;"> am </th>
   <th style="text-align:right;"> gear </th>
   <th style="text-align:right;"> carb </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> mpg </td>
   <td style="text-align:right;"> 1.0000000 </td>
   <td style="text-align:right;"> -0.8521620 </td>
   <td style="text-align:right;"> -0.8475514 </td>
   <td style="text-align:right;"> -0.7761684 </td>
   <td style="text-align:right;"> 0.6811719 </td>
   <td style="text-align:right;"> -0.8676594 </td>
   <td style="text-align:right;"> 0.4186840 </td>
   <td style="text-align:right;"> 0.6640389 </td>
   <td style="text-align:right;"> 0.5998324 </td>
   <td style="text-align:right;"> 0.4802848 </td>
   <td style="text-align:right;"> -0.5509251 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cyl </td>
   <td style="text-align:right;"> -0.8521620 </td>
   <td style="text-align:right;"> 1.0000000 </td>
   <td style="text-align:right;"> 0.9020329 </td>
   <td style="text-align:right;"> 0.8324475 </td>
   <td style="text-align:right;"> -0.6999381 </td>
   <td style="text-align:right;"> 0.7824958 </td>
   <td style="text-align:right;"> -0.5912421 </td>
   <td style="text-align:right;"> -0.8108118 </td>
   <td style="text-align:right;"> -0.5226070 </td>
   <td style="text-align:right;"> -0.4926866 </td>
   <td style="text-align:right;"> 0.5269883 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> disp </td>
   <td style="text-align:right;"> -0.8475514 </td>
   <td style="text-align:right;"> 0.9020329 </td>
   <td style="text-align:right;"> 1.0000000 </td>
   <td style="text-align:right;"> 0.7909486 </td>
   <td style="text-align:right;"> -0.7102139 </td>
   <td style="text-align:right;"> 0.8879799 </td>
   <td style="text-align:right;"> -0.4336979 </td>
   <td style="text-align:right;"> -0.7104159 </td>
   <td style="text-align:right;"> -0.5912270 </td>
   <td style="text-align:right;"> -0.5555692 </td>
   <td style="text-align:right;"> 0.3949769 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hp </td>
   <td style="text-align:right;"> -0.7761684 </td>
   <td style="text-align:right;"> 0.8324475 </td>
   <td style="text-align:right;"> 0.7909486 </td>
   <td style="text-align:right;"> 1.0000000 </td>
   <td style="text-align:right;"> -0.4487591 </td>
   <td style="text-align:right;"> 0.6587479 </td>
   <td style="text-align:right;"> -0.7082234 </td>
   <td style="text-align:right;"> -0.7230967 </td>
   <td style="text-align:right;"> -0.2432043 </td>
   <td style="text-align:right;"> -0.1257043 </td>
   <td style="text-align:right;"> 0.7498125 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> drat </td>
   <td style="text-align:right;"> 0.6811719 </td>
   <td style="text-align:right;"> -0.6999381 </td>
   <td style="text-align:right;"> -0.7102139 </td>
   <td style="text-align:right;"> -0.4487591 </td>
   <td style="text-align:right;"> 1.0000000 </td>
   <td style="text-align:right;"> -0.7124406 </td>
   <td style="text-align:right;"> 0.0912048 </td>
   <td style="text-align:right;"> 0.4402785 </td>
   <td style="text-align:right;"> 0.7127111 </td>
   <td style="text-align:right;"> 0.6996101 </td>
   <td style="text-align:right;"> -0.0907898 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> wt </td>
   <td style="text-align:right;"> -0.8676594 </td>
   <td style="text-align:right;"> 0.7824958 </td>
   <td style="text-align:right;"> 0.8879799 </td>
   <td style="text-align:right;"> 0.6587479 </td>
   <td style="text-align:right;"> -0.7124406 </td>
   <td style="text-align:right;"> 1.0000000 </td>
   <td style="text-align:right;"> -0.1747159 </td>
   <td style="text-align:right;"> -0.5549157 </td>
   <td style="text-align:right;"> -0.6924953 </td>
   <td style="text-align:right;"> -0.5832870 </td>
   <td style="text-align:right;"> 0.4276059 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> qsec </td>
   <td style="text-align:right;"> 0.4186840 </td>
   <td style="text-align:right;"> -0.5912421 </td>
   <td style="text-align:right;"> -0.4336979 </td>
   <td style="text-align:right;"> -0.7082234 </td>
   <td style="text-align:right;"> 0.0912048 </td>
   <td style="text-align:right;"> -0.1747159 </td>
   <td style="text-align:right;"> 1.0000000 </td>
   <td style="text-align:right;"> 0.7445354 </td>
   <td style="text-align:right;"> -0.2298609 </td>
   <td style="text-align:right;"> -0.2126822 </td>
   <td style="text-align:right;"> -0.6562492 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> vs </td>
   <td style="text-align:right;"> 0.6640389 </td>
   <td style="text-align:right;"> -0.8108118 </td>
   <td style="text-align:right;"> -0.7104159 </td>
   <td style="text-align:right;"> -0.7230967 </td>
   <td style="text-align:right;"> 0.4402785 </td>
   <td style="text-align:right;"> -0.5549157 </td>
   <td style="text-align:right;"> 0.7445354 </td>
   <td style="text-align:right;"> 1.0000000 </td>
   <td style="text-align:right;"> 0.1683451 </td>
   <td style="text-align:right;"> 0.2060233 </td>
   <td style="text-align:right;"> -0.5696071 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> am </td>
   <td style="text-align:right;"> 0.5998324 </td>
   <td style="text-align:right;"> -0.5226070 </td>
   <td style="text-align:right;"> -0.5912270 </td>
   <td style="text-align:right;"> -0.2432043 </td>
   <td style="text-align:right;"> 0.7127111 </td>
   <td style="text-align:right;"> -0.6924953 </td>
   <td style="text-align:right;"> -0.2298609 </td>
   <td style="text-align:right;"> 0.1683451 </td>
   <td style="text-align:right;"> 1.0000000 </td>
   <td style="text-align:right;"> 0.7940588 </td>
   <td style="text-align:right;"> 0.0575344 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> gear </td>
   <td style="text-align:right;"> 0.4802848 </td>
   <td style="text-align:right;"> -0.4926866 </td>
   <td style="text-align:right;"> -0.5555692 </td>
   <td style="text-align:right;"> -0.1257043 </td>
   <td style="text-align:right;"> 0.6996101 </td>
   <td style="text-align:right;"> -0.5832870 </td>
   <td style="text-align:right;"> -0.2126822 </td>
   <td style="text-align:right;"> 0.2060233 </td>
   <td style="text-align:right;"> 0.7940588 </td>
   <td style="text-align:right;"> 1.0000000 </td>
   <td style="text-align:right;"> 0.2740728 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> carb </td>
   <td style="text-align:right;"> -0.5509251 </td>
   <td style="text-align:right;"> 0.5269883 </td>
   <td style="text-align:right;"> 0.3949769 </td>
   <td style="text-align:right;"> 0.7498125 </td>
   <td style="text-align:right;"> -0.0907898 </td>
   <td style="text-align:right;"> 0.4276059 </td>
   <td style="text-align:right;"> -0.6562492 </td>
   <td style="text-align:right;"> -0.5696071 </td>
   <td style="text-align:right;"> 0.0575344 </td>
   <td style="text-align:right;"> 0.2740728 </td>
   <td style="text-align:right;"> 1.0000000 </td>
  </tr>
</tbody>
</table>

## Correlation Plot
You can use corrplot::corrplot() on correlation table to get the correlation table.

```r
corrplot::corrplot(as.matrix(res$cor_matrix),method = "number")
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png)

## Exclude few items from the given set
This function was developed to eliminate few items from the list of items for any reason.

```r
excludeThese(mtcars$mpg, c(21.0))
```

```
##  [1] 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4 10.4
## [15] 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
## [29] 15.0 21.4
```


## get most repeated item in the given set
You can find out most repeated values in the given set of values.

```r
getMostRepeatedValue(c(1,1,1,2,2,3,4,5))
```

```
## [1] 1
## Levels: 1 2 3 4 5
```

## Calculate total missing items in vector
missing count will calculate the total number of NA, NULL, "", "NULL", "NA" s in a given set of values. lets introduce some missing values to mtcars

```r
x <- head(mtcars)
x$mpg[1:2] <- NA
```


```r
missing_count(x$mpg)
```

```
## [1] 2
```
## Impute data
You can replace the missing values in any column of given data frame with one of mean, median, max, and min, sum and mode  by using ImputeMydata().  for example you can impute the missing values in the mpg column by mean of all the values in the column as shown below.

```r
 imputeMyData(df = x, col = "mpg", FUN = "mean")
```

```
## [1] "present NA"
## [1] "Imputed 20.25"
## [1] "present NA"
## [1] "Imputed 20.25"
## [1] "present 22.8"
## [1] "Imputed 22.8"
## [1] "present 21.4"
## [1] "Imputed 21.4"
## [1] "present 18.7"
## [1] "Imputed 18.7"
## [1] "present 18.1"
## [1] "Imputed 18.1"
```

```
##                     mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         20.25   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     20.25   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.80   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.40   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.70   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.10   6  225 105 2.76 3.460 20.22  1  0    3    1
```

## Group By and Summarize
You can summarize the values of one column by grouping the values in the other column using  groupByandSummarize(). For example you can calculate mean of hp by am.

```r
knitr::kable(groupByandSumarize(mtcars, grp_col = c("am"), summarise_col = "hp", FUN = "mean"))
```

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> am </th>
   <th style="text-align:right;"> mean_of_hp_by_am </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 126.8462 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 160.2632 </td>
  </tr>
</tbody>
</table>

## Data partition
You can split a given data set into training set and test set by using datapartition(), you can specify the percentage to specify the size of trainset. For example you can split mtcars into 85 percent to train and 15 to test as shown below.


```r
partition <- dataPartition(mtcars, 85)
```

partition is a list of length 2, which contains test and train sets.

### head of train set


```r
knitr::kable(head(partition$Train))
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> mpg </th>
   <th style="text-align:right;"> cyl </th>
   <th style="text-align:right;"> disp </th>
   <th style="text-align:right;"> hp </th>
   <th style="text-align:right;"> drat </th>
   <th style="text-align:right;"> wt </th>
   <th style="text-align:right;"> qsec </th>
   <th style="text-align:right;"> vs </th>
   <th style="text-align:right;"> am </th>
   <th style="text-align:right;"> gear </th>
   <th style="text-align:right;"> carb </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Maserati Bora </td>
   <td style="text-align:right;"> 15.0 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 301.0 </td>
   <td style="text-align:right;"> 335 </td>
   <td style="text-align:right;"> 3.54 </td>
   <td style="text-align:right;"> 3.570 </td>
   <td style="text-align:right;"> 14.60 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet Sportabout </td>
   <td style="text-align:right;"> 18.7 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 360.0 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 3.15 </td>
   <td style="text-align:right;"> 3.440 </td>
   <td style="text-align:right;"> 17.02 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Dodge Challenger </td>
   <td style="text-align:right;"> 15.5 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 318.0 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 2.76 </td>
   <td style="text-align:right;"> 3.520 </td>
   <td style="text-align:right;"> 16.87 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hornet 4 Drive </td>
   <td style="text-align:right;"> 21.4 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 258.0 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 3.08 </td>
   <td style="text-align:right;"> 3.215 </td>
   <td style="text-align:right;"> 19.44 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Merc 280C </td>
   <td style="text-align:right;"> 17.8 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 167.6 </td>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> 3.92 </td>
   <td style="text-align:right;"> 3.440 </td>
   <td style="text-align:right;"> 18.90 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Fiat X1-9 </td>
   <td style="text-align:right;"> 27.3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 79.0 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 4.08 </td>
   <td style="text-align:right;"> 1.935 </td>
   <td style="text-align:right;"> 18.90 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
</tbody>
</table>

### head of test set


```r
knitr::kable(head(partition$Test))
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> mpg </th>
   <th style="text-align:right;"> cyl </th>
   <th style="text-align:right;"> disp </th>
   <th style="text-align:right;"> hp </th>
   <th style="text-align:right;"> drat </th>
   <th style="text-align:right;"> wt </th>
   <th style="text-align:right;"> qsec </th>
   <th style="text-align:right;"> vs </th>
   <th style="text-align:right;"> am </th>
   <th style="text-align:right;"> gear </th>
   <th style="text-align:right;"> carb </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Merc 280 </td>
   <td style="text-align:right;"> 19.2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 167.6 </td>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> 3.92 </td>
   <td style="text-align:right;"> 3.440 </td>
   <td style="text-align:right;"> 18.3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Merc 450SLC </td>
   <td style="text-align:right;"> 15.2 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 275.8 </td>
   <td style="text-align:right;"> 180 </td>
   <td style="text-align:right;"> 3.07 </td>
   <td style="text-align:right;"> 3.780 </td>
   <td style="text-align:right;"> 18.0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Toyota Corolla </td>
   <td style="text-align:right;"> 33.9 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 71.1 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 4.22 </td>
   <td style="text-align:right;"> 1.835 </td>
   <td style="text-align:right;"> 19.9 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ford Pantera L </td>
   <td style="text-align:right;"> 15.8 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 351.0 </td>
   <td style="text-align:right;"> 264 </td>
   <td style="text-align:right;"> 4.22 </td>
   <td style="text-align:right;"> 3.170 </td>
   <td style="text-align:right;"> 14.5 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ferrari Dino </td>
   <td style="text-align:right;"> 19.7 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 145.0 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 3.62 </td>
   <td style="text-align:right;"> 2.770 </td>
   <td style="text-align:right;"> 15.5 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 6 </td>
  </tr>
</tbody>
</table>


## Train regression model

```r
mod <- lm(formula = wt ~ ., data = mtcars)
mod
```

```
## 
## Call:
## lm(formula = wt ~ ., data = mtcars)
## 
## Coefficients:
## (Intercept)          mpg          cyl         disp           hp  
##   -0.230634    -0.041666    -0.057254     0.006685    -0.003230  
##        drat         qsec           vs           am         gear  
##   -0.090083     0.199541    -0.066368     0.018445    -0.093508  
##        carb  
##    0.248688
```

## Prediction


```r
predictions <- predict(mod, mtcars[,-6])
```

## Get Regression Model Metrics
get the metrics of regression model by using regressionModelmMetrics()

```r
 actials <- mtcars[,6]
 x <- regressionModelMetrics(actuals = actials, predictions = predictions, model = mod)
 y <- as.data.frame(x)
 row.names(y) <- NULL
 knitr::kable(y)
```

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> AIC </th>
   <th style="text-align:right;"> BIC </th>
   <th style="text-align:right;"> MAE </th>
   <th style="text-align:right;"> MSE </th>
   <th style="text-align:right;"> RMSE </th>
   <th style="text-align:right;"> MAPE </th>
   <th style="text-align:right;"> Corelation </th>
   <th style="text-align:right;"> r.squared </th>
   <th style="text-align:right;"> adj.r.squared </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 20.01 </td>
   <td style="text-align:right;"> 37.6 </td>
   <td style="text-align:right;"> 0.18 </td>
   <td style="text-align:right;"> 0.05 </td>
   <td style="text-align:right;"> 0.23 </td>
   <td style="text-align:right;"> 0.06 </td>
   <td style="text-align:right;"> 0.97 </td>
   <td style="text-align:right;"> 0.94 </td>
   <td style="text-align:right;"> 0.92 </td>
  </tr>
</tbody>
</table>

