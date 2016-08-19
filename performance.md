%r
`6vr.2dpdk.lat` <- read.csv("~/code/networkperformance/data/6vr-2dpdk-lat.csv")
View(`6vr.2dpdk.lat`)

### install and load library

```
> install.packages("dplyr")
also installing the dependencies ‘assertthat’, ‘R6’, ‘Rcpp’, ‘magrittr’, ‘lazyeval’, ‘DBI’, ‘BH’

trying URL 'https://cran.rstudio.com/bin/macosx/mavericks/contrib/3.3/assertthat_0.1.tgz'   
Content type 'application/x-gzip' length 43355 bytes (42 KB)   
downloaded 42 KB

...cut...


> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union
    
> a <- 1:10
> a
 [1]  1  2  3  4  5  6  7  8  9 10
> a %>% max(a)
[1] 10
> a %>% max
[1] 10
> 
```    
