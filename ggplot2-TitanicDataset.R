# This script is training on how to use ggplot by Irma Wang.

library(ggplot2)
library(readr)
library(tidyr)

# Load Titanic dataset from Github
titanic <- read.csv("titanic.csv", stringsAsFactors = FALSE)

View(titanic)

# Data cleaning: Survive, Pclass, Embarked and sex data are not numeric data, so I'll set them as factors
titanic$Pclass <- as.factor(titanic$Pclass)
titanic$Survived <- as.factor(titanic$Survived)
titanic$Sex <- as.factor(titanic$Sex)
titanic$Embarked <- as.factor(titanic$Embarked)

# I want to know the survial rate, bar chart is good for categorical or factor data
ggplot(titanic, aes(x = Survived)) +
  geom_bar()
# If I just want a number, I don't need ggplot
prop.table(table(titanic$Survived))

# I want to make the graph more presentable
ggplot(titanic, aes(x = Survived)) +
  geom_bar()+
  theme_bw()+
  labs(y = "Passenger Count", title = "Titanic Survial Rates")

# the survival rate by gender
ggplot(titanic, aes(x = Sex, fill = Survived)) +
  geom_bar()+
theme_bw()+
  labs(y = "Passenger Count", title = "Titanic Survial Rates by Gender")

# the survival rate by class
ggplot(titanic, aes(x = Pclass, fill = Survived)) +
  geom_bar()+
  theme_bw()+
  labs(y = "Passenger Count", title = "Titanic Survial Rates by Pclass")
prop.table(table(titanic$Pclass))

# I want to do a drill-down with everything about survival rate
ggplot(titanic, aes(x = Sex, fill = Survived)) +
  geom_bar()+
  facet_wrap(~ Pclass)+
  theme_bw()+
  labs(y = "Passenger Count", title = "Titanic Survial Rates by Pclass")

# I want to explore the age distribution, numeric data
ggplot(titanic, aes(x = Age))+
  theme_bw()+
  geom_histogram(binwidth = 5)+
  labs(y = "Passenger Count", x = "Age (binwidth = 5)",
       title = "Titanic Age Distribution")

# I want to add in the survival rate
ggplot(titanic, aes(x = Age, fill = Survived ))+
  theme_bw()+
  geom_histogram(binwidth = 5)+
  labs(y = "Passenger Count", x = "Age (binwidth = 5)",
       title = "Titanic Age Distribution")

# I want to use boxplot layer
titanic$Age <- as.numeric(titanic$Age)
ggplot(titanic)+
  geom_boxplot(aes(x = Survived, y= Age),na.rm = TRUE )+
  theme_bw() +
  labs(y = "Age", x = "Survived", title = "Titanic Survival Rates by Age")

### I had problem with this boxplot,it took me an hour to figure out :(  

# I want to the survival distribution with gender, age and class

ggplot(titanic, mapping = aes(x = Age, fill = Survived ))+
  theme_bw()+
  facet_wrap(Sex ~ Pclass)+
  geom_density(alpha = 0.5)+
  labs(y = "Age", x = "Survived",
       title = "Titanic Survival Rates by Age, Pclass and Sex")

# I want to try histograms
ggplot(titanic, mapping = aes(x = Age, fill = Survived ))+
  theme_bw()+
  facet_wrap(Sex ~ Pclass)+
  geom_histogram(binwidth = 5)+
  labs(y = "Age", x = "Survived",
       title = "Titanic Survival Rates by Age, Pclass and Sex")
