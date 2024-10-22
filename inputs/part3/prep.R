d <- read.csv("inputs/part3/raw/cases.csv.xz", row.names = 1)
convert <- read.csv("inputs/part3/raw/regions.csv")

i <- match(d$areaCode, convert$LAD21CD)
d <- cbind(Region = convert$RGN21NM[i], d)
d <- d[!is.na(i), ]
d <- d[order(d$Region, d$areaName, d$Week), ]
rownames(d) <- NULL
d$date_begin <- as.Date(d$date_begin, "%d/%m/%Y")

## The whole thing
saveRDS(d, "inputs/part3/cases.rds")

regions <- unique(d$Region)

## Split versions for us to easily use as inputs to reports:
for (year in 2020:2022) {
  for (region in regions) {
    dsub <- d[d$Region == region & d$date_begin <= as.Date("2020-12-31"), ]
    rownames(dsub) <- NULL
    write.csv(dsub,
              sprintf("inputs/part3/cases-%s-%d.csv", region, year),
              row.names = FALSE)
  }
}
