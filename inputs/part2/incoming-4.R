orderly_description(
  display = "Incoming data from Otherlandia",
  long = "Data as given to us from the MoH in Otherlandia.",
  custom = list(received = "2024-10-22"))
orderly_resource("data.xlsx")
orderly_artefact(files = "data.csv", description = "Cleaned data")
d <- readxl::read_excel("data.xlsx", sheet = 2, skip = 2)
names(d) <- gsub(" ", "_", tolower(names(d)))
d$date <- as.Date(d$date)
write.csv(d, "data.csv", row.names = FALSE)
