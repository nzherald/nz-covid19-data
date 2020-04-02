source(here::here("packages.R"))

dateRange <- tibble(Date=seq(as.Date("2020-02-28"), as.Date("2020-04-02"), "days"))
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
  ) %>% mutate(Date=as.Date(Date))

  deathsDates <- tribble(
    ~Date, ~Deaths, ~`Total Deaths`,
    "2020-03-29", 1, 1,
    "2020-03-30", 0, 1,
    "2020-03-31", 0, 1,
    "2020-04-01", 0, 1,
    "2020-04-02", 0, 1,
  ) %>% mutate(Date=as.Date(Date))

transmissionDates <- tribble(
  ~Date, ~Overseas, ~Contact, ~Investigating, ~Community, ~Established,
  # "2020-03-30", round(0.57*455), round(0.26*455), round(0.15*455), round(0.02*455), 455,
  "2020-03-31", round(0.53*647), round(0.29*647), round(0.17*647), round(0.01*647), 647,
  "2020-04-01", round(0.51*708), round(0.30*708), round(0.18*708), round(0.01*708), 708,
  "2020-04-02", round(0.51*797), round(0.31*797), round(0.17*797), round(0.01*797), 797,
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


    casefile = file_in(here::here("data/moh/covid-19_case_list_2_april_2020.xlsx")),
    confirmedCases = readxl::read_excel(casefile, skip=3) %>% tidyCases("Confirmed"),


    probableCases = readxl::read_excel(casefile, skip=3, sheet=2) %>% tidyCases("Probable"),

    allCases = bind_rows(confirmedCases, probableCases) %>%
      rename_all(str_to_lower) %>%
      mutate(reported=lubridate::force_tz(reported, "Pacific/Auckland")),


    write_cases_tidy_csv = bind_rows(confirmedCases, probableCases) %>%
      arrange(Reported) %>%
      write_csv(file_out(here("data/cases.csv"))),
    write_cases_tidy_xlsx = bind_rows(confirmedCases, probableCases) %>%
      arrange(Reported) %>%
      writexl::write_xlsx(file_out(here("data/cases.xlsx"))),


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
      Total=Confirmed+coalesce(Probable,0),
      `Cumulative`=`Total Confirmed`+coalesce(`Total Probable`,0),
      ) %>%
    left_join(recoveredDates, by="Date") %>%
    mutate(`Total Recovered`=na_if(cumsum(coalesce(Recovered,0)),0)) %>%
    left_join(hospitalisationDates, by="Date") %>%
    left_join(deathsDates, by="Date") %>%
    left_join(transmissionDates, by="Date") %>%
    rename_all(snakecase::to_lower_camel_case) %>%
    mutate(date=as.POSIXct(date)),


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
