library(eurostat)
library(tidyverse)

gdpy <- get_eurostat("nama_10_gdp")
gdpq <- get_eurostat("namq_10_gdp")


# setup -------------------------------------------------------------------


# country <- "UK"
country <- "FR"
movav_periods_q <- 4*5
movav_periods_y <- 5

# run calc and display result ---------------------------------------------


dtay <- gdpy %>% 
  filter(geo == country, na_item == "B1GQ", unit =="CLV15_MNAC") %>% 
  select(TIME_PERIOD,values) %>% 
  rename(time = TIME_PERIOD, gdp = values) %>% 
  mutate(time = lubridate::ymd(time),
         gdptr_cubic = lm(.$gdp ~ poly(1:length(.$gdp),3)) %>% predict(),
         gdptr_movav = zoo::rollmean(gdp,movav_periods_y,fill=NA)
        )

dtaq <- gdpq %>% 
  filter(geo == country, s_adj == "SCA", na_item == "B1GQ", unit =="CLV15_MNAC") %>% 
  select(TIME_PERIOD,values) %>% 
  rename(time = TIME_PERIOD, gdp = values) %>% 
  mutate(time = lubridate::ymd(time),
         gdptr_cubic = lm(.$gdp ~ poly(1:length(.$gdp),3)) %>% predict(),
         gdptr_movav = zoo::rollmean(gdp,movav_periods_q,fill=NA)
         )


ggplot(dtaq, aes(x=time)) + 
  geom_line(aes(y = gdp), color = "red") + 
  geom_line(aes(y = gdptr_cubic), size = 1) +
  ggtitle(paste(country,"-- cubic trend, quarterly data")) +
  xlab("") + ylab("GDP")

ggplot(dtaq, aes(x=time)) + 
  geom_line(aes(y = gdp), color = "red") + 
  geom_line(aes(y = gdptr_movav), size = 1) +
  ggtitle(paste(country,"-- moving average, quarterly data")) +
  xlab("") + ylab("GDP")


ggplot(dtay, aes(x=time)) + 
  geom_line(aes(y = gdp), color = "blue") + 
  geom_line(aes(y = gdptr_cubic), size = 1) +
  ggtitle(paste(country,"-- cubic trend, annual data")) +
  xlab("") + ylab("GDP")

ggplot(dtay, aes(x=time)) + 
  geom_line(aes(y = gdp), color = "blue") + 
  geom_line(aes(y = gdptr_movav), size = 1) +
  ggtitle(paste(country,"-- moving average, annual data")) +
  xlab("") + ylab("GDP")

