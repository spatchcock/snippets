data <- read.csv("eurostat_deficit_debt.csv", header=TRUE, na="NA")

plot(data$Deficit , data$Debt)