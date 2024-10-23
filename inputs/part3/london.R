orderly_dependency("cases",
                   'latest(parameter:region == "london")',
                   c("london.csv" = "cases.csv"))
d <- read.csv("london.csv")
png("london.png")
plot(Week_Cases ~ Week, d)
dev.off()
