# Title: RRP-Data-Visualization - Barplot sketches

library(ggplot2)

# -----------------------------------------------------------|
# ABORTIONS AS A PERCENTAGE OF REPORTED PREGNANCIES IN TEXAS |
# -----------------------------------------------------------|

dat <- read.table("Data/Demographic_data/Pregnancies vs. Abortions, Ages 15-44.tsv", sep = "\t", header = TRUE, stringsAsFactors = FALSE)

# Convert string variables to numeric
dat$Total.Pregnancies <- as.numeric(gsub(",", "", dat$Total.Pregnancies))
dat$Abortions <- as.numeric(gsub(",", "", dat$Abortions))
# Convert numeric to factor
dat$Year <- as.factor(dat$Year)

# Create variables for stacked barplot
dat$Term.Pregnancies <- dat$Total.Pregnancies - dat$Abortions
dat$Abortion.Percentage <- round(dat$Abortions / dat$Total.Pregnancies * 100)
dat$Null <- rep(0, dim(dat)[1])

for (i in 1:length(dat$Year))
  dat$Abortion.Percentage[i] <- paste0(dat$Abortion.Percentage[i], "%")

attach(dat)

# Default barplot w/abortions in grey
ggplot(data = dat, aes(x = Year, y = Total.Pregnancies)) + 
  geom_bar(stat = "identity", fill="lightblue") + 
  geom_bar(data = dat, aes(x=Year, y=Abortions), stat="identity", fill="grey") +
  geom_text(aes(x=Year, y=Null, label = Abortion.Percentage), vjust = -1, size = 4, color = "white") +
  theme_minimal() +
  ggtitle("Abortions as a Percentage of Reported Pregnancies in Texas")


# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

#
#
#

pop <- read.table("Data/Demographic_data/Population Data by Ethnicity (Texas), 2006-2015.tsv", sep = "\t", header = TRUE, stringsAsFactors = FALSE)

births <- read.table("Data/Demographic_data/Birth Statistics by Ethnicity, 2005-2014.tsv", sep = "\t", header = TRUE, stringsAsFactors = FALSE)

terminations <- read.table("Data/Demographic_data/Terminations by Ethnicity, 2006-2015.tsv", sep = "\t", header = TRUE, stringsAsFactors = FALSE)


# Create proportion-based data frame:
# year | ethnicity | pP | bP | aP
year <- rep(2006:2014, times = 3)
length(year)

races <- c("white", "hispanic", "black")
ethnicity <- rep(races, each=9)

# Demographic proportions relative to total state population
popProp_white <- pop$propWhite[1:9]
popProp_black <- pop$propBlack[1:9]
popProp_hisp <- pop$propHispanic[1:9]
popProp <- c(popProp_white, popProp_hisp, popProp_black)

# Demographic proportions relative to total state births
bPw <- births$propWhite[2:10]
bPb <- births$propBlack[2:10]
bPh <- births$propHispanic[2:10]
birthProp <- c(bPw, bPh, bPb)

# Demographic proportions relative to total state abortions
tPw <- terminations$propWhite[1:9]
tPb <- terminations$propBlack[1:9]
tPh <- terminations$propHispanic[1:9]
termProp <- c(tPw, tPh, tPb)


# Demographic proportions relative to post-natal infant deaths
# ...

df <- data.frame(year=year, ethnicity=ethnicity, populationProp=popProp, birthProp=birthProp, abortionProp=termProp)
df

# Set plot matrix
par(mfrow=c(3,2))

# White demographic stats
barplot(as.matrix(df[1, 3:5]), main = "White demographic stats, 2006", col = "white")
barplot(as.matrix(df[9, 3:5]), main = "White demographic stats, 2014", col = "white")

# Hispanic demographic stats
barplot(as.matrix(df[10, 3:5]), main = "Hispanic demographic stats, 2006", col = "grey")
barplot(as.matrix(df[18, 3:5]), main = "Hispanic demographic stats, 2014", col = "grey")

# Black demographic stats
# Population remains stable
barplot(as.matrix(df[19, 3:5]), main = "Black demographic stats, 2006")
barplot(as.matrix(df[27, 3:5]), main = "Black demographic stats, 2014")

# Unset plot matrix
par(mfrow=c(1,1))

# Reshape data for grouped barplot
eth <- rep(races, each = 3)
attrProp <- rep(c("population", "births", "abortions"), times = 3)

df2 <- data.frame(factor(eth), factor(attrProp))
df2

df

df2$value[1:3] <- df[1, 3:5]
df2$value[4:6] <- df[10, 3:5]
df2$value[7:9] <- df[19, 3:5]

df2$value <- unlist(df2$value)

# Grouped
ggplot(df2, aes(fill=eth, y=value, x=attrProp)) + 
  geom_bar(position="dodge", stat="identity")