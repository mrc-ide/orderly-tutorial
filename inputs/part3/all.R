regions <- c("east_of_england", "london", "midlands",
             "north_east_and_yorkshire", "north_west", "south_east",
             "south_west")
orderly_artefact(files = sprintf("%s.png", regions),
                 description = "Plot of cases over time")

fs::dir_create("cases")
for (r in regions) {
  orderly_dependency("cases",
                     'latest(parameter:region == environment:r)',
                     c("cases/${r}.csv" = "cases.csv"))
}

d <- lapply(sprintf("cases/%s.csv", regions), read.csv)
names(d) <- regions

for (r in regions) {
  png(sprintf("%s.png", r))
  plot(Week_Cases ~ Week, d[[r]])
  dev.off()
}
