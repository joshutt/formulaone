library(dplyr)

loadDrivers <- function() {
    drivers <- read.csv("drivers.csv")
    teams <- read.csv("teams.csv")

    maxLength <- length(drivers)
    drivers$avg <- rowMeans(drivers[,3:maxLength])
    drivers$med <-  apply(drivers[,3:maxLength], 1, median)
    drivers$adj <- apply(drivers[,3:maxLength], 1, function(x) (sum(x)-max(x)-min(x))/(length(x)-2))

    teams$avg <- rowMeans(teams[,3:maxLength])
    teams$med <-  apply(teams[,3:maxLength], 1, median)
    teams$adj <- apply(teams[,3:maxLength], 1, function(x) (sum(x)-max(x)-min(x))/(length(x)-2))

    drivers <<- drivers
    teams <<- teams
}


factor <- "Race.6"
#factor <- "adj"

calculateLineup <- function(factor="adj") {
    pos <- combn(drivers$Driver, 5)
    numOpt <- dim(pos)[2]
    possibles <- c()
    optTeams <- data.frame(id=c(0), cost=c(0), baseVal=c(0), turboVal=c(0))
    for (x in 1:numOpt) {
        driverSet <- drivers[drivers$Driver %in% pos[,x],]
        totCost <- sum(driverSet$Cost)
        if (totCost >= 100) {
            next
        }
        #print (totCost)
        possibles <- c(possibles, x)
        baseVal <- sum(driverSet[,factor])
        #baseVal <- sum(driverSet$adj)
        ds <- filter(driverSet, Cost < 19)
        optTeams <- rbind(optTeams, c(x, totCost, baseVal, baseVal+max(ds[,factor])))
        #optTeams <- rbind(optTeams, c(x, totCost, baseVal, baseVal+max(ds$adj)))
    }
    optTeams <- optTeams[-1,]
    optTeams <- optTeams[order(optTeams$turboVal, decreasing=T),]
    optTeams <- cbind(optTeams, Driver1=pos[,optTeams$id][1,], Driver2=pos[,optTeams$id][2,], Driver3=pos[,optTeams$id][3,], Driver4=pos[,optTeams$id][4,], Driver5=pos[,optTeams$id][5,])

    finalTeams <- filter(optTeams, FALSE)
    for (y in 1:nrow(teams)) {
        workSet <- optTeams
        workSet$cost <- workSet$cost + teams[y, "Cost"]
        workSet$baseVal <- workSet$baseVal + teams[y, factor]
        workSet$turboVal <- workSet$turboVal + teams[y, factor]
        workSet$Team <- teams[y, "Team"]

        finalTeams <- rbind(finalTeams, filter(workSet, cost <= 100))
    }
    return (finalTeams[order(finalTeams$turboVal, decreasing=T),])
}


adjustLineup <- function(factor="adj", team, driverList) {
    posDriver <- calculateLineup(factor)
    posDriver$change <- 0
    posDriver[posDriver$Team == team,]$change <- 1
    for (driver in driverList) {
        driverName <- driver
        posDriver$change <- posDriver$id %in% filter(posDriver, Driver1 == driverName | Driver2 == driverName | Driver3 == driverName | Driver4 == driverName | Driver5 == driverName)$id + posDriver$change
    }
    filter(posDriver, change>=5)
}


findTeam <- function(posDriver, team, driverList) {
    filter(posDriver, Team==team) %>%
        filter(Driver1 == driverList[1] | Driver2 == driverList[1] | Driver3 == driverList[1] | Driver4 == driverList[1] | Driver5 == driverList[1]) %>%
        filter(Driver1 == driverList[2] | Driver2 == driverList[2] | Driver3 == driverList[2] | Driver4 == driverList[2] | Driver5 == driverList[2]) %>%
        filter(Driver1 == driverList[3] | Driver2 == driverList[3] | Driver3 == driverList[3] | Driver4 == driverList[3] | Driver5 == driverList[3])  %>%
        filter(Driver1 == driverList[4] | Driver2 == driverList[4] | Driver3 == driverList[4] | Driver4 == driverList[4] | Driver5 == driverList[4]) %>%
        filter(Driver1 == driverList[4] | Driver2 == driverList[4] | Driver3 == driverList[4] | Driver4 == driverList[4] | Driver5 == driverList[4]) %>%
        filter(Driver1 == driverList[5] | Driver2 == driverList[5] | Driver3 == driverList[5] | Driver4 == driverList[5] | Driver5 == driverList[5])
}
