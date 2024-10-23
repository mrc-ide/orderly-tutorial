library(orderly2)
root <- "workdir/part3-upstream"
ids <- orderly_search("parameter:year == 2020", root = root)

orderly_location_add_path("server", tmp, root = root)
orderly_location_add_packit("server",
                            url = "https://packit.dide.ic.ac.uk/training",
                            root = root)

orderly_location_push("parameter:year == 2020",
                      "server",
                      root = root)

orderly_location_push("parameter:year == 2021",
                      "server",
                      root = root)
