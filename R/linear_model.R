data <- read.csv("eurostat_deficit_debt.csv", header=TRUE, na="NA")

model <- lm(data$Deficit ~ data$Debt, data=data)