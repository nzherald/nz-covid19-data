source(here::here("packages.R"))

dateRange <- tibble(Date=seq(as.Date("2020-02-28"), as.Date("2020-04-07"), "days"))
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
  ) %>% mutate(Date=as.Date(Date))

transmissionDates <- tribble(
  ~Date, ~Overseas, ~Contact, ~Investigating, ~Community, ~Established,
  # "2020-03-30", round(0.57*455), round(0.26*455), round(0.15*455), round(0.02*455), 455,
  "2020-03-31", round(0.53*647), round(0.29*647), round(0.17*647), round(0.01*647), 647,
  "2020-04-01", round(0.51*708), round(0.30*708), round(0.18*708), round(0.01*708), 708,
  "2020-04-02", round(0.51*797), round(0.31*797), round(0.17*797), round(0.01*797), 797,
  "2020-04-03", round(0.49*868), round(0.33*868), round(0.17*868), round(0.01*868), 868,
  "2020-04-04", round(0.47*950), round(0.34*950), round(0.17*950), round(0.01*950), 950,
  "2020-04-05", round(0.45*1039), round(0.36*1039), round(0.18*1039), round(0.01*1039), 1039,
  "2020-04-06", round(0.43*1106), round(0.38*1106), round(0.17*1106), round(0.02*1106), 1106,
  "2020-04-07", round(0.42*1160), round(0.41*1160), round(0.15*1160), round(0.02*1160), 1160,
  ) %>% mutate(Date=as.Date(Date))

communityTransmissionDates <- tribble(
  ~Date, ~`Community Transmission`,
  "2020-03-23", 2,
  "2020-03-24", 2, # https://www.health.govt.nz/news-media/media-releases/40-new-confirmed-cases-covid-19-new-zealand
  "2020-03-25", 0,
  "2020-03-26", 0, # More discussed by no numbers given
  ) %>% mutate(Date=as.Date(Date))

testDates <- tribble(
  ~Date, ~Tests, ~`Total Tests`, ~`Test Count`,
  "2020-03-23", NA, 9780-1421-900, "Estimate",
  "2020-03-24", 900, 9780-1421, "Estimate",
  "2020-03-25", 1421, 9780, "Accurate",
  "2020-03-26", 2417, 12683, "Accurate",
  ) %>% mutate(Date=as.Date(Date))

# Tests completed, 7 day running average,
# 15 March, 142, 61, NA,
# 16 March, 325, 106, NA,
# 17 March, 659, 187, NA,
# 18 March, 1209, 348, NA,
# 19 March, 1291, 528, NA,
# 20 March, 1554, 745, NA,
# 21 March, 1776, 908, NA,
# 22 March, 1256, 1067, NA,
# 23 March, 1050, 1171, NA,
# 24 March, 1544, 1297, NA,
# 25 March, 2592, 1495, NA,
# 26 March, 2117, 1613, NA,
# 27 March, 2067, 1686, NA,
# 28 March, 1809, 1776, NA,
# 29 March, 918, 1728, NA,
# 30 March, 1391, 1777, 21384,
# 31 March, 2093, 1855, 23481,
# 1 April, 2563, 1835, 26015
# 2 April, 29485-26015, 2041, 29485,
# 3 April, 3631, 2264, 33116,
# 4 April, 3903, 2448, 36209,
# 5 April, 3709, 2846, 39918,
# 6 April



todayCsv <- paste0("data/daily/dhb-cases-", format(Sys.Date(), "%Y-%m-%d"), ".csv")
todayXlsx <- paste0("data/daily/dhb-cases-", format(Sys.Date(), "%Y-%m-%d"), ".xlsx")



views <- function(d) {
list(
      age=d %>% group_by(age) %>% summarise(total=n(), confirmed=length(age[status=="Confirmed"]), probable=length(age[status=="Probable"])) %>% ungroup() %>% rename(variable=age),
      sex=d %>% group_by(sex) %>% summarise(total=n(), confirmed=length(sex[status=="Confirmed"]), probable=length(sex[status=="Probable"])) %>% ungroup() %>% rename(variable=sex),
      origin=d %>% group_by(origin) %>% summarise(total=n(), confirmed=length(origin[status=="Confirmed"]), probable=length(origin[status=="Probable"])) %>% ungroup() %>% rename(variable=origin),
      dhb=d %>% group_by(dhb) %>% arrange(dhb) %>% summarise(total=n(), confirmed=length(dhb[status=="Confirmed"]), probable=length(dhb[status=="Probable"])) %>% ungroup() %>% rename(variable=dhb),
      reported=d %>% group_by(reported) %>% arrange(reported) %>% summarise(total=n(), confirmed=length(reported[status=="Confirmed"]), probable=length(reported[status=="Probable"])) %>% ungroup() %>% rename(variable=reported),
      total=d %>% nrow(),
      confirmed=d %>% filter(status=="Confirmed") %>% nrow(),
      probable=d %>% filter(status=="Probable") %>% nrow()
      )
}


tidyCases <- function(df, status) {
  df %>% mutate(
    Origin=case_when(
      `International travel`=="Yes" ~ 'Overseas',
      `International travel`=="No" ~ 'In New Zealand',
      TRUE ~ 'Unknown'
      ),
    Status=status) %>%
  rename(Reported=`Date of report`,
      Age = `Age group`)
}


plan <- drake_plan(
    # https://services2.arcgis.com/9V7Qc4NIcvZBm0io/ArcGIS/rest/services
    esrRaw = read_json("https://services2.arcgis.com/9V7Qc4NIcvZBm0io/ArcGIS/rest/services/Daily_ESR_Update_Cases/FeatureServer/0/query?f=json&where=1%3D1&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&orderByFields=FID%20ASC&resultOffset=0&resultRecordCount=5000&cacheHint=true"),
    esrData = esrRaw$features %>% map_dfr(~(first(.) %>% as_tibble())) %>%
      mutate(ReportDate=as.POSIXct(ReportDate/1000, origin = "1970-01-01", tz="UTC") %>%
        lubridate::force_tz("Pacific/Auckland"),
      Sex=case_when(Sex=="NA"~NA_character_, TRUE~Sex)),

    casefile = file_in(here::here("data/moh/covid-casedeatails-7april2020.xlsx")),
    confirmedCases = readxl::read_excel(casefile, skip=3) %>% tidyCases("Confirmed"),


    probableCases = readxl::read_excel(casefile, skip=3, sheet=2) %>% tidyCases("Probable"),


    write_cases_tidy_csv = bind_rows(confirmedCases, probableCases) %>%
      arrange(Reported) %>%
      write_csv(file_out(here("data/cases.csv"))),
    write_cases_tidy_xlsx = bind_rows(confirmedCases, probableCases) %>%
      arrange(Reported) %>%
      writexl::write_xlsx(file_out(here("data/cases.xlsx"))),


    allCasesMoH = bind_rows(confirmedCases, probableCases) %>%
      rename_all(str_to_lower) %>%
      mutate(reported=lubridate::force_tz(reported, "Pacific/Auckland"),
        age=case_when(
          age %in% c("<1","1 to 4","5 to 9") ~ "0 to 9",
          age %in% c("10 to 14", "15 to 19") ~ "10 to 19",
          TRUE ~ age)),

    esrMohDiff = allCasesMoH %>%
          count(status, reported, sex, age, dhb) %>%
        full_join(esrData %>%
        count(Status, ReportDate, Sex, AgeGrp1, DHB), by=c("status"="Status","reported"="ReportDate","sex"="Sex","age"="AgeGrp1","dhb"="DHB")) %>%
        filter(n.x != n.y | is.na(n.y) | is.na(n.x)),

    allCases = allCasesMoH ,# %>% bind_rows(esrMohDiff %>% select(-n.x,-n.y) %>% mutate(origin="Unknown")),

    nzTotals = allCases %>% views,
    ageTotals = allCases %>% split(.$age) %>% map(views) %>% unname(),
    sexTotals = allCases %>% split(.$sex) %>% map(views) %>% unname(),
    originTotals = allCases %>% split(.$origin) %>% map(views) %>% unname(),
    dhbTotals = allCases %>% split(.$dhb) %>% map(views) %>% unname(),
    reportedTotals = allCases %>% split(.$reported) %>% map(views) %>% unname(),


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


    write_everything = list(
      cases=allCases,
      nz=nzTotals,
      age=ageTotals,
      sex=sexTotals,
      origin=originTotals,
      dhb=dhbTotals,
      reported=reportedTotals,
      manual=manual
      ) %>%
      as_d3_data() %>%
      write_json(file_out(here("data/cases.json")), auto_unbox=T, POSIXt="ISO8601", Date="ISO8601", UTC=T),



  write_timeseries = manual %>%
    write_csv(file_out(here("data/days.csv"))),

  write_timeseries_xlsx = manual %>%
      writexl::write_xlsx(file_out(here("data/days.xlsx")))


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
