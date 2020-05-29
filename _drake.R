source(here::here("packages.R"))

dateRange <- tibble(Date=seq(as.Date("2020-02-28"), as.Date("2020-05-29"), "days"))
probableDates <- tribble(
  ~Date, ~Probable,
  "2020-03-24", 13.0, # https://www.health.govt.nz/news-media/media-releases/40-new-confirmed-cases-covid-19-new-zealand
  "2020-03-25", 3, # https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-novel-coronavirus-news-and-media-updates
  "2020-03-26", 5, # https://www.health.govt.nz/news-media/news-items/covid-19-media-update-26-march
  "2020-03-27", 9,
  "2020-03-28", 5,
  "2020-03-29", 3,
  "2020-03-30", -1,
  "2020-03-31", 10,
  "2020-04-01", 14,
  "2020-04-02", 13,
  "2020-04-03", 22,
  "2020-04-04", 30,
  "2020-04-05", 41,
  "2020-04-06", 28,
  "2020-04-07", 22,
  "2020-04-08", 24,
  "2020-04-09", 6,
  "2020-04-10", 21,
  "2020-04-11", 9,
  "2020-04-12", 4,
  "2020-04-13", 4,
  "2020-04-14", 9,
  "2020-04-15", 14,
  "2020-04-16", 9,
  "2020-04-17", 6,
  "2020-04-18", 5,
  "2020-04-19", 5,
  "2020-04-20", 2,
  "2020-04-21", 3,
  "2020-04-22", 0,
  "2020-04-23", 2,
  "2020-04-24", 3,
  "2020-04-25", 2,
  "2020-04-26", 5,
  "2020-04-27", -2,
  "2020-04-28", 1,
  "2020-04-29", 0,
  "2020-04-30", -1,
  "2020-05-01", 0,
  "2020-05-02", 4,
  "2020-05-03", 0,
  "2020-05-04", -1,
  "2020-05-05", -1,
  "2020-05-06", 1,
  "2020-05-07", 0,
  "2020-05-08", -1,
  "2020-05-09", 1,
  "2020-05-10", 0,
  "2020-05-11", 0,
  "2020-05-12", 0,
  "2020-05-13", 0,
  "2020-05-14", 0,
  "2020-05-15", 0,
  "2020-05-16", 0,
  "2020-05-17", 0,
  "2020-05-18", 0,
  "2020-05-19", 0,
  "2020-05-20", 0,
  "2020-05-21", 0,
  "2020-05-22", 0,
  "2020-05-23", 0,
  "2020-05-24", 0,
  "2020-05-25", 0,
  "2020-05-26", 0,
  "2020-05-27", 0,
  "2020-05-28", 0,
  "2020-05-29", 0,
  ) %>% mutate(Date=as.Date(Date))

confirmedDates <- tribble(
  ~Date, ~Confirmed,
  "2020-02-28", 1.0, # https://www.health.govt.nz/news-media/media-releases/single-case-covid-19-confirmed-new-zealand
  "2020-03-04", 1, # https://www.health.govt.nz/news-media/media-releases/second-case-covid-19-confirmed-nz
  "2020-03-05", 1, # https://www.health.govt.nz/news-media/media-releases/third-case-covid-19-confirmed-new-zealand
  "2020-03-06", 1, # https://www.health.govt.nz/news-media/media-releases/fourth-case-covid-19-confirmed-new-zealand
  "2020-03-07", 1, # https://www.health.govt.nz/news-media/news-items/covid-19-novel-coronavirus-update-7-march
  "2020-03-14", 1, # https://www.health.govt.nz/news-media/media-releases/covid-19-6th-case-overseas-link
  "2020-03-15", 2, # https://www.health.govt.nz/news-media/media-releases/covid-19-7th-and-8th-cases-overseas-links
  "2020-03-17", 4, # https://www.health.govt.nz/news-media/media-releases/covid-19-one-additional-case-linked-overseas-travel https://www.health.govt.nz/news-media/media-releases/covid-19-three-new-cases-linked-overseas
  "2020-03-18", 8, # https://www.health.govt.nz/news-media/media-releases/covid-19-eight-new-cases-linked-overseas-travel
  "2020-03-19", 8, # https://www.health.govt.nz/news-media/media-releases/new-cases-covid-19-confirmed-no-community-transmission
  "2020-03-20", 11, # https://www.health.govt.nz/news-media/media-releases/11-new-cases-covid-19
  "2020-03-21", 13, # https://www.health.govt.nz/news-media/media-releases/covid-19-update-21-march
  "2020-03-22", 14, # https://www.health.govt.nz/news-media/media-releases/covid-19-update-22-march-2020
  "2020-03-23", 36, # https://www.health.govt.nz/news-media/media-releases/36-new-cases-covid-19-new-zealand
  "2020-03-24", 40, # https://www.health.govt.nz/news-media/media-releases/40-new-confirmed-cases-covid-19-new-zealand
  "2020-03-25", 47, # https://www.health.govt.nz/news-media/news-items/covid-19-media-update-25-march
  "2020-03-26", 73, # https://www.health.govt.nz/news-media/news-items/covid-19-media-update-26-march
  "2020-03-27", 76,
  "2020-03-28", 78,
  "2020-03-29", 60,
  "2020-03-30", 76,
  "2020-03-31", 48,
  "2020-04-01", 47,
  "2020-04-02", 76,
  "2020-04-03", 49,
  "2020-04-04", 52,
  "2020-04-05", 48,
  "2020-04-06", 39,
  "2020-04-07", 32,
  "2020-04-08", 26,
  "2020-04-09", 23,
  "2020-04-10", 23,
  "2020-04-11", 20,
  "2020-04-12", 14,
  "2020-04-13", 15,
  "2020-04-14", 8,
  "2020-04-15", 6,
  "2020-04-16", 6,
  "2020-04-17", 2,
  "2020-04-18", 8,
  "2020-04-19", 4,
  "2020-04-20", 7,
  "2020-04-21", 2,
  "2020-04-22", 3,
  "2020-04-23", 5,
  "2020-04-24", 2,
  "2020-04-25", 3,
  "2020-04-26", 4,
  "2020-04-27", 1,
  "2020-04-28", 2,
  "2020-04-29", 2,
  "2020-04-30", 3,
  "2020-05-01", 3,
  "2020-05-02", 2,
  "2020-05-03", 2,
  "2020-05-04", 1,
  "2020-05-05", 0,
  "2020-05-06", 1,
  "2020-05-07", 1,
  "2020-05-08", 2,
  "2020-05-09", 1,
  "2020-05-10", 2,
  "2020-05-11", 3,
  "2020-05-12", 0,
  "2020-05-13", 0,
  "2020-05-14", 0,
  "2020-05-15", 1,
  "2020-05-16", 0,
  "2020-05-17", 1,
  "2020-05-18", 0,
  "2020-05-19", 0,
  "2020-05-20", 0,
  "2020-05-21", 0,
  "2020-05-22", 1,
  "2020-05-23", 0,
  "2020-05-24", 0,
  "2020-05-25", 0,
  "2020-05-26", 0,
  "2020-05-27", 0,
  "2020-05-28", 0,
  "2020-05-29", 0,
  ) %>% mutate(Date=as.Date(Date))


# recovered numbers are read from main page manually or pulled from livestream
recoveredDates <- tribble(
  ~Date, ~Recovered,
  "2020-03-24", 12.0,
  "2020-03-25", 10,
  "2020-03-26", 5,
  "2020-03-27", 10,
  "2020-03-28", 13,
  "2020-03-29", 6,
  "2020-03-30", 7,
  "2020-03-31", 11,
  "2020-04-01", 9,
  "2020-04-02", 9,
  "2020-04-03", 11,
  "2020-04-04", 24,
  "2020-04-05", 29,
  "2020-04-06", 20,
  "2020-04-07", 65,
  "2020-04-08", 41,
  "2020-04-09", 35,
  "2020-04-10", 56,
  "2020-04-11", 49,
  "2020-04-12", 49,
  "2020-04-13", 75,
  "2020-04-14", 82,
  "2020-04-15", 100,
  "2020-04-16", 42,
  "2020-04-17", 46,
  "2020-04-18", 51,
  "2020-04-19", 45,
  "2020-04-20", 62,
  "2020-04-21", 32,
  "2020-04-22", 30,
  "2020-04-23", 29,
  "2020-04-24", 30,
  "2020-04-25", 23,
  "2020-04-26", 24,
  "2020-04-27", 38,
  "2020-04-28", 34,
  "2020-04-29", 15,
  "2020-04-30", 12,
  "2020-05-01", 11,
  "2020-05-02", 11,
  "2020-05-03", 3,
  "2020-05-04", 10,
  "2020-05-05", 26,
  "2020-05-06", 14,
  "2020-05-07", 16,
  "2020-05-08", 15,
  "2020-05-09", 21,
  "2020-05-10", 3,
  "2020-05-11", 15,
  "2020-05-12", 12,
  "2020-05-13", 4,
  "2020-05-14", 9,
  "2020-05-15", 10,
  "2020-05-16", 7,
  "2020-05-17", 5,
  "2020-05-18", 0,
  "2020-05-19", 9,
  "2020-05-20", 5,
  "2020-05-21", 5,
  "2020-05-22", 3,
  "2020-05-23", 0,
  "2020-05-24", 1,
  "2020-05-25", 0,
  "2020-05-26", 5,
  "2020-05-27", 1,
  "2020-05-28", 12,
  "2020-05-29", 7,
  ) %>% mutate(Date=as.Date(Date))

# hospitalisations data are the total number of people in hospital on a given
# day - NOT the number admitted that day - making it a different kind of number to the rest
hospitalisationDates <- tribble(
  ~Date, ~`In Hospital Now`, ~`Total Been In Hospital`, ~`In ICU`,
  "2020-03-24", 6.0, NA, 0.0,
  "2020-03-25", 6, NA, 0,
  "2020-03-26", 7, NA, 0,
  "2020-03-27", 8, 20, 1,
  "2020-03-28", 12, 22, 2,
  "2020-03-29", 9, 28, 1,
  "2020-03-30", 12, 28, 2,
  "2020-03-31", 14, NA, 2,
  "2020-04-01", 14, NA, 2,
  "2020-04-02", 13, NA, 2,
  "2020-04-03", 13, NA, 1,
  "2020-04-04", 10, NA, 1,
  "2020-04-05", 15, NA, 3,
  "2020-04-06", 13, NA, 3,
  "2020-04-07", 12, NA, 4,
  "2020-04-08", 12, NA, 4,
  "2020-04-09", 14, NA, 4,
  "2020-04-10", 16, NA, 4,
  "2020-04-11", 15, NA, 5,
  "2020-04-12", 14, NA, 5,
  "2020-04-13", 15, NA, 4,
  "2020-04-14", 15, NA, 3,
  "2020-04-15", 13, NA, 3,
  "2020-04-16", 12, NA, 3,
  "2020-04-17", 14, NA, 3,
  "2020-04-18", 20, NA, 3,
  "2020-04-19", 18, NA, 3,
  "2020-04-20", 14, NA, 3,
  "2020-04-21", 12, NA, 3,
  "2020-04-22", 11, NA, 2,
  "2020-04-23", 8, NA, 1,
  "2020-04-24", 8, NA, 1,
  "2020-04-25", 7, NA, 1,
  "2020-04-26", 7, NA, 1,
  "2020-04-27", 7, NA, 1,
  "2020-04-28", 9, NA, 1,
  "2020-04-29", 6, NA, 0,
  "2020-04-30", 7, NA, 0,
  "2020-05-01", 6, NA, 0,
  "2020-05-02", 5, NA, 0,
  "2020-05-03", 8, NA, 0,
  "2020-05-04", 4, NA, 0,
  "2020-05-05", 4, NA, 0,
  "2020-05-06", 2, NA, 0,
  "2020-05-07", 2, NA, 0,
  "2020-05-08", 3, NA, 0,
  "2020-05-09", 2, NA, 0,
  "2020-05-10", 2, NA, 0,
  "2020-05-11", 2, NA, 0,
  "2020-05-12", 2, NA, 0,
  "2020-05-13", 2, NA, 0,
  "2020-05-14", 2, NA, 0,
  "2020-05-15", 2, NA, 0,
  "2020-05-16", 3, NA, 0,
  "2020-05-17", 2, NA, 0,
  "2020-05-18", 2, NA, 0,
  "2020-05-19", 2, NA, 0,
  "2020-05-20", 1, NA, 0,
  "2020-05-21", 1, NA, 0,
  "2020-05-22", 1, NA, 0,
  "2020-05-23", 1, NA, 0,
  "2020-05-24", 1, NA, 0,
  "2020-05-25", 1, NA, 0,
  "2020-05-26", 1, NA, 0,
  "2020-05-27", 0, NA, 0,
  "2020-05-28", 0, NA, 0,
  "2020-05-29", 0, NA, 0,
  ) %>% mutate(Date=as.Date(Date))

  deathsDates <- tribble(
    ~Date, ~Deaths, ~`Total Deaths`,
    "2020-03-29", 1, 1,
    "2020-03-30", 0, 1,
    "2020-03-31", 0, 1,
    "2020-04-01", 0, 1,
    "2020-04-02", 0, 1,
    "2020-04-03", 0, 1,
    "2020-04-04", 0 ,1,
    "2020-04-05", 0 ,1,
    "2020-04-06", 0 ,1,
    "2020-04-07", 0 ,1,
    "2020-04-08", 0 ,1,
    "2020-04-09", 0 ,1,
    "2020-04-10", 1 ,2,
    "2020-04-11", 2 ,4,
    "2020-04-12", 0 ,4,
    "2020-04-13", 1 ,5,
    "2020-04-14", 4 ,9,
    "2020-04-15", 0 ,9,
    "2020-04-16", 0 ,9,
    "2020-04-17", 2 ,11,
    "2020-04-18", 0 ,11,
    "2020-04-19", 1 ,12,
    "2020-04-20", 0 ,12,
    "2020-04-21", 1 ,13,
    "2020-04-22", 1 ,14,
    "2020-04-23", 2 ,16,
    "2020-04-24", 1 ,17,
    "2020-04-25", 1 ,18,
    "2020-04-26", 0 ,18,
    "2020-04-27", 1 ,19,
    "2020-04-28", 0 ,19,
    "2020-04-29", 0 ,19,
    "2020-04-30", 0 ,19,
    "2020-05-01", 0 ,19,
    "2020-05-02", 1 ,20,
    "2020-05-03", 0 ,20,
    "2020-05-04", 0 ,20,
    "2020-05-05", 0 ,20,
    "2020-05-06", 1 ,21,
    "2020-05-07", 0 ,21,
    "2020-05-08", 0 ,21,
    "2020-05-09", 0 ,21,
    "2020-05-10", 0 ,21,
    "2020-05-11", 0 ,21,
    "2020-05-12", 0 ,21,
    "2020-05-13", 0 ,21,
    "2020-05-14", 0 ,21,
    "2020-05-15", 0 ,21,
    "2020-05-16", 0 ,21,
    "2020-05-17", 0 ,21,
    "2020-05-18", 0 ,21,
    "2020-05-19", 0 ,21,
    "2020-05-20", 0 ,21,
    "2020-05-21", 0 ,21,
    "2020-05-22", 0 ,21,
    "2020-05-23", 0 ,21,
    "2020-05-24", 0 ,21,
    "2020-05-25", 0 ,21,
    "2020-05-26", 0 ,21,
    "2020-05-27", 0 ,21,
    "2020-05-28", 0 ,22,
    "2020-05-29", 0 ,22,
  ) %>% mutate(Date=as.Date(Date))

transmissionDates <- tribble(
  ~Date, ~Overseas, ~Contact, ~Investigating, ~Community, ~Established,
  # "2020-03-30", round(0.57*455), round(0.26*455), round(0.15*455), round(0.02*455), 455,
  "2020-03-31", round(0.53*647), round(0.29*647), round(0.17*647), round(0.01*647), NA,
  "2020-04-01", round(0.51*708), round(0.30*708), round(0.18*708), round(0.01*708), NA,
  "2020-04-02", round(0.51*797), round(0.31*797), round(0.17*797), round(0.01*797), NA,
  "2020-04-03", round(0.49*868), round(0.33*868), round(0.17*868), round(0.01*868), NA,
  "2020-04-04", round(0.47*950), round(0.34*950), round(0.17*950), round(0.01*950), NA,
  "2020-04-05", round(0.45*1039), round(0.36*1039), round(0.18*1039), round(0.01*1039), NA,
  "2020-04-06", round(0.43*1106), round(0.38*1106), round(0.17*1106), round(0.02*1106), NA,
  "2020-04-07", round(0.42*1160), round(0.41*1160), round(0.15*1160), round(0.02*1160), NA,
  "2020-04-08", round(0.41*1210), round(0.43*1210), round(0.14*1210), round(0.02*1210), NA,
  "2020-04-09", round(0.41*1239), round(0.44*1239), round(0.13*1239), round(0.02*1239), NA,
  "2020-04-10", round(0.40*1283), round(0.44*1283), round(0.14*1283), round(0.02*1283), NA,
  "2020-04-11", round(0.40*1312), round(0.46*1312), round(0.11*1312), round(0.02*1312), NA,
  "2020-04-12", round(0.40*1330), round(0.47*1330), round(0.11*1330), round(0.02*1330), NA,
  "2020-04-13", round(0.40*1349), round(0.47*1349), round(0.11*1349), round(0.02*1349), NA,
  "2020-04-14", round(0.39*1366), round(0.48*1366), round(0.11*1366), round(0.02*1366), NA,
  "2020-04-15", round(0.39*1386), round(0.48*1386), round(0.10*1386), round(0.02*1386), NA,
  "2020-04-16", round(0.39*1401), round(0.55*1401), round(0.04*1401), round(0.02*1401), NA,
  "2020-04-17", round(0.39*1409), round(0.54*1409), round(0.03*1409), round(0.03*1409), NA,
  "2020-04-18", round(0.39*1422), round(0.54*1422), round(0.03*1422), round(0.03*1422), NA,
  "2020-04-19", round(0.39*1431), round(0.54*1431), round(0.03*1431), round(0.03*1431), NA,
  "2020-04-20", round(0.39*1440), round(0.54*1440), round(0.02*1440), round(0.04*1440), NA,
  "2020-04-21", round(0.39*1445), round(0.55*1445), round(0.02*1445), round(0.04*1445), NA,
  "2020-04-22", round(0.39*1451), round(0.55*1451), round(0.02*1451), round(0.04*1451), NA,
  "2020-04-23", round(0.39*1451), round(0.56*1451), round(0.02*1451), round(0.04*1451), NA,
  "2020-04-24", round(0.39*1456), round(0.41*1456), round(0.02*1456), round(0.04*1456), round(0.14*1456),
  "2020-04-25", round(0.39*1461), round(0.41*1461), round(0.02*1461), round(0.03*1461), round(0.15*1461),
  "2020-04-26", round(0.39*1470), round(0.41*1470), round(0.02*1470), round(0.03*1470), round(0.15*1470),
  "2020-04-27", round(0.39*1469), round(0.33*1469), round(0.02*1469), round(0.03*1469), round(0.23*1469),
  "2020-04-28", round(0.39*1472), round(0.33*1472), round(0.02*1472), round(0.03*1472), round(0.23*1472),
  "2020-04-29", round(0.39*1474), round(0.33*1474), round(0.02*1474), round(0.03*1474), round(0.23*1474),
  "2020-04-30", round(0.39*1476), round(0.32*1476), round(0.01*1476), round(0.04*1476), round(0.24*1476),
  "2020-05-01", round(0.39*1479), round(0.32*1479), round(0.01*1479), round(0.04*1479), round(0.24*1479),
  "2020-05-02", round(0.38*1485), round(0.32*1485), round(0.01*1485), round(0.04*1485), round(0.24*1485),
  "2020-05-03", round(0.38*1487), round(0.32*1487), round(0.01*1487), round(0.04*1487), round(0.24*1487),
  "2020-05-04", round(0.38*1487), round(0.32*1487), round(0.01*1487), round(0.04*1487), round(0.24*1487),
  "2020-05-05", round(0.38*1486), round(0.32*1486), round(0.01*1486), round(0.04*1486), round(0.24*1486),
  "2020-05-06", round(0.38*1488), round(0.32*1488), round(0.01*1488), round(0.04*1488), round(0.24*1488),
  "2020-05-07", round(0.38*1488), round(0.32*1488), round(0.01*1488), round(0.04*1488), round(0.24*1488),
  "2020-05-08", round(0.38*1490), round(0.32*1490), round(0.01*1490), round(0.04*1490), round(0.24*1490),
  "2020-05-09", round(0.38*1492), round(0.32*1492), round(0.01*1492), round(0.04*1492), round(0.24*1492),
  "2020-05-10", round(0.38*1494), round(0.32*1494), round(0.01*1494), round(0.04*1494), round(0.24*1494),
  "2020-05-11", 572, 475, 1497-572-475-366-67, 67, 366,
  "2020-05-12", 572, 475, 1497-572-475-366-67, 67, 366,
  "2020-05-13", 572, 475, 1497-572-475-366-67, 67, 366,
  "2020-05-14", 572, 475, 1497-572-475-366-67, 67, 366,
  "2020-05-15", 572, 468, 1497-572-468-370-74, 74, 370,
  "2020-05-16", 572, 468, 1497-572-468-370-74, 74, 370,
  "2020-05-17", 572, 469, 1497-572-468-370-74, 74, 370,
  "2020-05-18", 572, 469, 1497-572-468-370-74, 74, 370,
  "2020-05-19", 576, 464, 1503-576-464-376-85, 85, 376,
  "2020-05-20", 576, 464, 1503-576-464-376-85, 85, 376,
  "2020-05-21", 576, 464, 1503-576-464-376-85, 85, 376,
  "2020-05-22", 576, 464, 1503-576-464-376-85, 85, 376,
  "2020-05-23", 575, 461, 1503-575-464-381-86, 86, 381,
  "2020-05-24", 575, 462, 1504-575-462-381-85, 85, 381,
  "2020-05-25", 575, 463, 1504-575-463-380-85, 85, 380,
  "2020-05-26", 575, 463, 1504-575-463-380-85, 85, 380,
  "2020-05-27", 575, 463, 1504-575-463-380-85, 85, 380,
  "2020-05-28", 575, 463, 1504-575-463-380-85, 85, 380,
  "2020-05-29", 575, 463, 1504-575-463-380-85, 85, 380,
  ) %>% mutate(Date=as.Date(Date))



todayCsv <- paste0("data/daily/dhb-cases-", format(Sys.Date(), "%Y-%m-%d"), ".csv")
todayXlsx <- paste0("data/daily/dhb-cases-", format(Sys.Date(), "%Y-%m-%d"), ".xlsx")


views <- function(d) {
list(
      age=d %>% group_by(age) %>% summarise(total=n(), confirmed=length(age[status=="Confirmed"]), probable=length(age[status=="Probable"])) %>% ungroup() %>% rename(variable=age),
      sex=d %>% group_by(sex) %>% summarise(total=n(), confirmed=length(sex[status=="Confirmed"]), probable=length(sex[status=="Probable"])) %>% ungroup() %>% rename(variable=sex),
      origin=d %>% group_by(origin) %>% summarise(total=n(), confirmed=length(origin[status=="Confirmed"]), probable=length(origin[status=="Probable"])) %>% ungroup() %>% rename(variable=origin),
      dhb=d %>% group_by(dhb) %>% arrange(dhb) %>% summarise(total=n(), confirmed=length(dhb[status=="Confirmed"]), probable=length(dhb[status=="Probable"])) %>% ungroup() %>% rename(variable=dhb),
      reported=d %>% group_by(reported) %>% arrange(reported) %>% summarise(total=n(), confirmed=length(reported[status=="Confirmed"]), probable=length(reported[status=="Probable"])) %>% ungroup() %>% rename(variable=reported),
      announced=d %>% group_by(announced) %>% arrange(announced) %>% summarise(total=n(), confirmed=length(announced[status=="Confirmed"]), probable=length(announced[status=="Probable"])) %>% ungroup() %>% rename(variable=announced),
      total=d %>% nrow(),
      confirmed=d %>% filter(status=="Confirmed") %>% nrow(),
      probable=d %>% filter(status=="Probable") %>% nrow()
      )
}


tidyCases <- function(df, status) {
  df %>%
    rename(`Date of report`=`Date notified of potential case`) %>%
    mutate(
    Origin=case_when(
      `Overseas travel`=="Yes" ~ 'Overseas',
      `Overseas travel`=="No" ~ 'In New Zealand',
      TRUE ~ 'Unknown'
      ),
    Status=status,
    `Date of report`=case_when(`Date of report`=="43939" ~ "18/04/2020", TRUE ~ `Date of report`),
    `Date of report`=parse_date(`Date of report`, format="%d/%m/%Y")
    ) %>%
  rename(Reported=`Date of report`,
      Age = `Age group`)
}

manualDHBactive <- function(nz, dhbScrape) {
  nz$dhb <- nz$dhb %>% mutate(
    active=dhbScrape %>% pull(Active) %>% as.numeric(),
    recovered=dhbScrape %>% pull(Recovered) %>% as.numeric())
  return(nz)
}


plan <- drake_plan(
    # https://services2.arcgis.com/9V7Qc4NIcvZBm0io/ArcGIS/rest/services
    esrRaw = read_json("https://services2.arcgis.com/9V7Qc4NIcvZBm0io/ArcGIS/rest/services/Daily_ESR_Update_Cases/FeatureServer/0/query?f=json&where=1%3D1&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&orderByFields=FID%20ASC&resultOffset=0&resultRecordCount=5000&cacheHint=true"),
    esrData = esrRaw$features %>% map_dfr(~(first(.) %>% as_tibble())) %>%
      mutate(ReportDate=as.POSIXct(ReportDate/1000, origin = "1970-01-01", tz="UTC") %>%
        lubridate::force_tz("Pacific/Auckland"),
      DHB=case_when(
        DHB=="Waitematā" ~ "Waitemata",
        DHB=="Tairāwhiti" ~ "Tairawhiti",
        TRUE ~ DHB),
      Sex=case_when(Sex=="NA"~NA_character_, TRUE~Sex)),

    casefile = file_in("data/moh/covid-cases-29may20.xlsx"),
    confirmedCases = readxl::read_excel(casefile, skip=3) %>% tidyCases("Confirmed"),


    probableCases = readxl::read_excel(casefile, skip=3, sheet=2) %>% tidyCases("Probable"),


    write_cases_tidy_csv = bind_rows(confirmedCases, probableCases) %>%
      arrange(Reported) %>%
      write_csv(file_out("data/cases.csv")),
    write_cases_tidy_xlsx = bind_rows(confirmedCases, probableCases) %>%
      arrange(Reported) %>%
      writexl::write_xlsx(file_out("data/cases.xlsx")),


    allCasesMoH = bind_rows(confirmedCases, probableCases) %>%
      rename_all(str_to_lower) %>%
      mutate(reported=lubridate::force_tz(reported, "Pacific/Auckland"),
        `arrival date`=lubridate::force_tz(`arrival date`, "Pacific/Auckland"),
        age=case_when(
          age %in% c("<1","1 to 4","5 to 9") ~ "0 to 9",
          age %in% c("10 to 14", "15 to 19") ~ "10 to 19",
          TRUE ~ age)),

    esrMohDiff = allCasesMoH %>%
          count(status, reported, sex, age, dhb) %>%
        full_join(esrData %>%
        count(Status, ReportDate, Sex, AgeGrp1, DHB), by=c("status"="Status","reported"="ReportDate","sex"="Sex","age"="AgeGrp1","dhb"="DHB")) %>%
        filter(n.x != n.y | is.na(n.y) | is.na(n.x)),


    dhbScrape = read_html("https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-current-situation/covid-19-current-cases#2020-05-29") %>%
      html_table() %>% nth(2) %>% filter(DHB != "Total") %>% arrange(DHB),


    manual = dateRange %>%
      left_join(confirmedDates %>% mutate(`Total Confirmed`=cumsum(Confirmed)), by="Date") %>%
    fill(`Total Confirmed`) %>%
    mutate(Confirmed=coalesce(Confirmed, 0)) %>%
    left_join(probableDates, by="Date") %>%
    mutate(
      `Total Probable`=na_if(cumsum(coalesce(Probable,0)),0),
      Cases=Confirmed+coalesce(Probable,0),
      `Total Cases`=`Total Confirmed`+coalesce(`Total Probable`,0),
      ) %>%
    left_join(recoveredDates, by="Date") %>%
    mutate(`Total Recovered`=na_if(cumsum(coalesce(Recovered,0)),0)) %>%
    left_join(hospitalisationDates, by="Date") %>%
    left_join(deathsDates, by="Date") %>%
    left_join(transmissionDates, by="Date") %>%
    rename_all(snakecase::to_lower_camel_case) %>%
    mutate(date=as.POSIXct(date),tag="Manual"),


    allCases = allCasesMoH %>%  # bind_rows(esrMohDiff %>% select(-n.x,-n.y) %>% mutate(origin="Unknown")) %>%
      arrange(reported) %>%
      mutate(announced = (manual %>% filter(!(totalConfirmed == 1125
           | totalConfirmed == 1140
            )) %>%
        mutate(cases=ifelse(totalConfirmed == 1120, 8, cases)) %>%
        arrange(date) %>% select(date, cases) %>% pmap_df(
          function(date,cases) {tibble(reported=rep(date,cases))}) %>% pull(reported))[1:1504],
        ),


    nzTotals = allCases %>% views %>% manualDHBactive(dhbScrape),
    ageTotals = allCases %>% split(.$age) %>% map(views) %>% unname(),
    sexTotals = allCases %>% split(.$sex) %>% map(views) %>% unname(),
    originTotals = allCases %>% split(.$origin) %>% map(views) %>% unname(),
    dhbTotals = allCases %>% split(.$dhb) %>% map(views) %>% unname(),
    reportedTotals = allCases %>% split(.$reported) %>% map(views) %>% unname(),
    announcedTotals = allCases %>% split(.$announced) %>% map(views) %>% unname(),



    write_everything = list(
      cases=allCases,
      nz=nzTotals,
      age=ageTotals,
      sex=sexTotals,
      origin=originTotals,
      dhb=dhbTotals,
      reported=reportedTotals,
      announced=announcedTotals,
      manual=manual
      ) %>%
      as_d3_data() %>%
      write_json(file_out("data/cases.json"), auto_unbox=T, POSIXt="ISO8601", Date="ISO8601", UTC=T),



  write_timeseries = manual %>%
    write_csv(file_out("data/days.csv")),

  write_timeseries_xlsx = manual %>%
      writexl::write_xlsx(file_out("data/days.xlsx"))


#     dataurl = file_in("https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-current-cases"),

#     dhbNumbersTable = (read_html(dataurl) %>%
#       html_nodes("table") %>%
#       html_table())[[2]],

#     # Tomorrow is nothing changes I will work out how to start building a series from this
#     dhbNumbers = dhbNumbersTable %>%
#        pivot_longer(-DHB, names_to = 'Case Status', values_to = 'Count') %>%
#        mutate(Date=Sys.Date()),

#      writeDHBToday = dhbNumbers %>%
#        write_csv(file_out(here(todayCsv))),

#      writeDHBTodayXLSX = dhbNumbers %>%
#        writexl::write_xlsx(file_out(here(todayXlsx))),

#      allFiles = fs::dir_ls(here("data/daily")),
#     csvFiles = allFiles[str_detect(allFiles, "csv")],

#     allDHBNumbers = csvFiles %>% map_df(read_csv),

#      writeDHB = allDHBNumbers %>%
#        write_csv(file_out(here("data/dhb-cases.csv"))),

#      writeDHBXLSX = allDHBNumbers %>%
#        writexl::write_xlsx(file_out(here("data/dhb-cases.xlsx"))),


#   # %>%
#   #   left_join(communityTransmissionDates, by="Date") %>%
#   #   mutate(`Total Community Transmission`=na_if(cumsum(coalesce(`Community Transmission`,0)),0)) %>%
#   #   left_join(testDates, by="Date"),

#    casedataurl = file_in("https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-current-cases/covid-19-current-cases-details"),

#    casesTable = read_html(casedataurl) %>%
#       html_node("table") %>%
#       html_table() %>%
#       mutate(Date=rev(confirmedDates[confirmedDates < "2020-03-27"])),  # waiting until cases are updated



)

drake_config(plan)
