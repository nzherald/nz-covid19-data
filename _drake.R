

suppressPackageStartupMessages(library(drake))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(here))
suppressPackageStartupMessages(library(r2d3))
suppressPackageStartupMessages(library(jsonlite))
suppressPackageStartupMessages(library(rvest))

regionSummary <- function(x) {
  x %>%
    group_by(Region) %>%
    summarise(Total=n(), Confirmed=length(Case[Classification=="Confirmed"]), Probable=length(Case[Classification=="Probable"])) %>%
    arrange(desc(Total))
}


probableDates <- c(
  rep("2020-03-24", 13), # https://www.health.govt.nz/news-media/media-releases/40-new-confirmed-cases-covid-19-new-zealand
  rep("2020-03-25", 3) # https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-novel-coronavirus-news-and-media-updates
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
  rep("2020-03-25", 47) # https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-novel-coronavirus-news-and-media-updates
) %>% as.Date()



plan <- drake_plan(
    dataurl = file_in("https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-current-cases"),
    caseTables = (read_html(dataurl) %>%
      html_nodes("table") %>%
      html_table())[1:2],
    casesTable = bind_rows(
      caseTables[[1]] %>%
        arrange(Case) %>%
        mutate(Classification="Confirmed", Date=confirmedDates),
      caseTables[[2]] %>%
        mutate(Classification="Probable", Date=probableDates)) %>%
      mutate(Location=case_when(
          Location=="Southern DHB" ~ "Queenstown",
          Location == "Hawkes Bay" ~ "Hawke’s Bay",
          TRUE ~ Location),
        Region=case_when(
          Location %in% c("Queenstown", "Dunedin", "Waitaki", "Wanaka") ~ "Otago",
          Location %in% c("Christchurch") ~ "Canterbury",
          Location %in% c("Hamilton", "Taupo") ~ "Waikato",
          Location %in% c("Wairarapa", "Wellington Region", "Kapiti Coast", "Upper Hutt") ~ "Wellington",
          Location %in% c("Invercargill") ~ "Southland",
          Location %in% c("Rotorua") ~ "Bay of Plenty",
          Location %in% c("New Plymouth") ~ "Taranaki",
          Location %in% c("Manawatu") ~ "Manawatu-Whanganui",
          Location %in% c("Waitemata") ~ "Auckland",
          Location %in% c("Blenheim") ~ "Marlborough",
          TRUE ~ Location
          )),
    write_cases_tidy_csv = casesTable %>%
      write_csv(file_out(here("data/cases.csv"))),
    write_cases_tidy_xlsx = casesTable %>%
      writexl::write_xlsx(file_out(here("data/cases.xlsx"))),
    write_regions = casesTable %>%
    regionSummary() %>%
    writexl::write_xlsx(file_out(here("data/cases-regions.xlsx"))),
    write_cases = casesTable %>%
      group_nest(Region) %>%
      as_d3_data() %>%
      write_json(file_out(here("data/cases.json")))
  )

drake_config(plan)
