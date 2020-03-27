source(here::here("packages.R"))



probableDates <- c(
  rep("2020-03-24", 13), # https://www.health.govt.nz/news-media/media-releases/40-new-confirmed-cases-covid-19-new-zealand
  rep("2020-03-25", 3), # https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-novel-coronavirus-news-and-media-updates
  rep("2020-03-26", 5), # https://www.health.govt.nz/news-media/news-items/covid-19-media-update-26-march
  rep("2020-03-27", 9)
) %>% as.Date()

confirmedDates <- c(
  rep("2020-02-28", 1), # https://www.health.govt.nz/news-media/media-releases/single-case-covid-19-confirmed-new-zealand
  rep("2020-03-04", 1), # https://www.health.govt.nz/news-media/media-releases/second-case-covid-19-confirmed-nz
  rep("2020-03-05", 1), # https://www.health.govt.nz/news-media/media-releases/third-case-covid-19-confirmed-new-zealand
  rep("2020-03-06", 1), # https://www.health.govt.nz/news-media/media-releases/fourth-case-covid-19-confirmed-new-zealand
  rep("2020-03-07", 1), # https://www.health.govt.nz/news-media/news-items/covid-19-novel-coronavirus-update-7-march
  rep("2020-03-14", 1), # https://www.health.govt.nz/news-media/media-releases/covid-19-6th-case-overseas-link
  rep("2020-03-15", 2), # https://www.health.govt.nz/news-media/media-releases/covid-19-7th-and-8th-cases-overseas-links
  rep("2020-03-17", 4), # https://www.health.govt.nz/news-media/media-releases/covid-19-one-additional-case-linked-overseas-travel https://www.health.govt.nz/news-media/media-releases/covid-19-three-new-cases-linked-overseas
  rep("2020-03-18", 8), # https://www.health.govt.nz/news-media/media-releases/covid-19-eight-new-cases-linked-overseas-travel
  rep("2020-03-19", 8), # https://www.health.govt.nz/news-media/media-releases/new-cases-covid-19-confirmed-no-community-transmission
  rep("2020-03-20", 11), # https://www.health.govt.nz/news-media/media-releases/11-new-cases-covid-19
  rep("2020-03-21", 13), # https://www.health.govt.nz/news-media/media-releases/covid-19-update-21-march
  rep("2020-03-22", 14), # https://www.health.govt.nz/news-media/media-releases/covid-19-update-22-march-2020
  rep("2020-03-23", 36), # https://www.health.govt.nz/news-media/media-releases/36-new-cases-covid-19-new-zealand
  rep("2020-03-24", 40), # https://www.health.govt.nz/news-media/media-releases/40-new-confirmed-cases-covid-19-new-zealand
  rep("2020-03-25", 47), # https://www.health.govt.nz/news-media/news-items/covid-19-media-update-25-march
  rep("2020-03-26", 73), # https://www.health.govt.nz/news-media/news-items/covid-19-media-update-26-march
  rep("2020-03-27", 76)
) %>% as.Date()


# recovered numbers are read from main page manually or pulled from livestream
recoveredDates <- tribble(
  ~Date, ~Recovered,
  "2020-03-24", 12,
  "2020-03-25", 10,
  "2020-03-26", 5,
  "2020-03-27", 10
  ) %>% mutate(Date=as.Date(Date))

# hospitalisations data are the total number of people in hospital on a given
# day - NOT the number admitted that day - making it a different kind of number to the rest
hospitalisationDates <- tribble(
  ~Date, ~`In Hospital Now`, ~`Total Been In Hospital`, ~`In ICU`,
  "2020-03-24", 6, NA, 0,
  "2020-03-25", 6, NA, 0,
  "2020-03-26", 7, NA, 0,
  "2020-03-27", 8, 20, 1,
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


dateRange <- tibble(Date=seq(as.Date("2020-02-28"), Sys.Date(), "days"))

todayCsv <- paste0("data/daily/dhb-cases-", format(Sys.Date(), "%Y-%m-%d"), ".csv")
todayXlsx <- paste0("data/daily/dhb-cases-", format(Sys.Date(), "%Y-%m-%d"), ".xlsx")


plan <- drake_plan(
    dataurl = file_in("https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-current-cases"),

    dhbNumbersTable = (read_html(dataurl) %>%
      html_nodes("table") %>%
      html_table())[[2]],

    # Tomorrow is nothing changes I will work out how to start building a series from this
    dhbNumbers = dhbNumbersTable %>%
       pivot_longer(-DHB, names_to = 'Case Status', values_to = 'Count') %>%
       mutate(Date=Sys.Date()),

     writeDHBToday = dhbNumbers %>%
       write_csv(file_out(here(todayCsv))),

     writeDHBTodayXLSX = dhbNumbers %>%
       writexl::write_xlsx(file_out(here(todayXlsx))),

     allFiles = fs::dir_ls(here("data/daily")),
    csvFiles = allFiles[str_detect(allFiles, "csv")],

    allDHBNumbers = csvFiles %>% map_df(read_csv),

     writeDHB = allDHBNumbers %>%
       write_csv(file_out(here("data/dhb-cases.csv"))),

     writeDHBXLSX = allDHBNumbers %>%
       writexl::write_xlsx(file_out(here("data/dhb-cases.xlsx"))),

    covidSeries = dateRange %>%
      left_join(tibble(Date=confirmedDates) %>%
        count(Date, name="Confirmed") %>%
        mutate(Confirmed=as.numeric(Confirmed), `Total Confirmed`=cumsum(Confirmed)), by="Date") %>%
    fill(Confirmed, `Total Confirmed`) %>%
    left_join(tibble(Date=probableDates) %>%
      count(Date, name="Probable") %>%
      mutate(Probable=as.numeric(Probable)), by="Date") %>%
    mutate(`Total Probable`=na_if(cumsum(coalesce(Probable,0)),0)) %>%
    left_join(recoveredDates, by="Date") %>%
    mutate(`Total Recovered`=na_if(cumsum(coalesce(Recovered,0)),0)) %>%
    left_join(hospitalisationDates, by="Date"),
  # %>%
  #   left_join(communityTransmissionDates, by="Date") %>%
  #   mutate(`Total Community Transmission`=na_if(cumsum(coalesce(`Community Transmission`,0)),0)) %>%
  #   left_join(testDates, by="Date"),

  write_timeseries = covidSeries %>%
    write_csv(file_out(here("data/days.csv"))),

  write_timeseries_xlsx = covidSeries %>%
      writexl::write_xlsx(file_out(here("data/days.xlsx"))),

   casedataurl = file_in("https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-current-cases/covid-19-current-cases-details"),

   casesTable = read_html(casedataurl) %>%
      html_node("table") %>%
      html_table() %>%
      mutate(Date=rev(confirmedDates[confirmedDates != "2020-03-27"])),  # waiting until cases are updated

    write_cases_tidy_csv = casesTable %>%
      write_csv(file_out(here("data/cases.csv"))),
    write_cases_tidy_xlsx = casesTable %>%
      writexl::write_xlsx(file_out(here("data/cases.xlsx"))),


)

drake_config(plan)
