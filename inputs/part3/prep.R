d <- read.csv("inputs/part3/raw/cases.csv", row.names = 1)
convert <- read.csv("inputs/part3/raw/ltla-to-region.csv")

i <- match(d$areaCode, convert$LAD21CD)
d2 <- cbind(Region = convert$RGN21NM[i], d)
d2 <- d2[!is.na(i), ]
d2 <- d2[order(d2$Region, d2$areaName, d2$Week), ]
rownames(d2) <- NULL
d2$date_begin <- as.Date(d2$date_begin, "%d/%m/%Y")

saveRDS(d2, "inputs/part3/cases.rds")

d_2020 <- d2[d$date_begin <= as.Date("2020-12-31"), ]
saveRDS(split(d_2020, d_2020$Region), "inputs/part3/cases-2020.rds")

d_2021 <- d2[d$date_begin <= as.Date("2021-12-31"), ]
saveRDS(split(d_2021, d_2021$Region), "inputs/part3/cases-2021.rds")

d_2022 <- d2[d$date_begin <= as.Date("2022-12-31"), ]
saveRDS(split(d_2022, d_2022$Region), "inputs/part3/cases-2022.rds")
