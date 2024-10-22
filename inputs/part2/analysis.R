orderly_dependency("incoming", "latest", "data.csv")
orderly_artefact(files = c("coverage-gf.png", "coverage-bf.png"),
                 description = "Plots of coverage")

d <- read.csv("data.csv")
d$date <- as.Date(d$date)

png("coverage-gf.png")
plot(gf_coverage ~ date, d, type = "l")
dev.off()

png("coverage-bf.png")
plot(bf_coverage ~ date, d, type = "l")
dev.off()
