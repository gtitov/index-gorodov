library(jsonlite)
library(dplyr)
library(RSQLite)
library(DBI)



cities2021 = fromJSON("./json/cities2021.json")
cities2020 = fromJSON("./json/cities2020.json")
cities2019 = fromJSON("./json/cities2019.json")
cities2018 = fromJSON("./json/cities2018.json")
cities = bind_rows(cities2018 %>% mutate(year = 2018), 
                   cities2019 %>% mutate(year = 2019),
                   cities2020 %>% mutate(year = 2020),
                   cities2021 %>% mutate(year = 2021))
cities$id = 1:nrow(cities)

write.csv(cities2021, "./csv/cities2021.csv", fileEncoding = "UTF-8")
write.csv(cities2020, "./csv/cities2020.csv", fileEncoding = "UTF-8")
write.csv(cities2019, "./csv/cities2019.csv", fileEncoding = "UTF-8")
write.csv(cities2018, "./csv/cities2018.csv", fileEncoding = "UTF-8")

write.csv(cities, "cities.csv", fileEncoding = "UTF-8")

db = dbConnect(RSQLite::SQLite(), "cities.sqlite")
dbWriteTable(db, "cities", cities)
dbDisconnect(db)
