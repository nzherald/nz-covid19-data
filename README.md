# New Zealand Covid-19 Case Data

This data has been quickly pulled together by the _New Zealand Herald_ data journalism team - if you
have any issues please contact Chris Knox by email <chris.knox@nzherald.co.nz> or via
[Twitter](https://twitter.com/vizowl)



If you are impatient - you probably want the cases
[excel](https://github.com/nzherald/nz-covid19-data/raw/master/data/cases-regions.xlsx)
and
[csv](https://raw.githubusercontent.com/nzherald/nz-covid19-data/master/data/cases.csv)


The data is from https://www.health.govt.nz/our-work/diseases-and-conditions/covid-19-novel-coronavirus/covid-19-current-cases
and was pulled when the page said "Last updated 2:00 pm, 25 March 2020"

The data is downloaded and cleaned up using R - all code is in `_drake.R`

There are a selection of files in the `data` directory.

I am using drake to process manage the update process - I will turn this into an R data package when
I get the time.

Pull requests are very welcome.

The code is a MIT licensed and the data is under the Ministry of Health's creative commons license https://www.health.govt.nz/about-site/copyright
