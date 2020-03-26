
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
