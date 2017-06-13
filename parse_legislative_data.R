# Parse the legislative data from abortion-bill search output (raw data)

raw_text <- readLines("Data/abortion-bill search output (raw data).txt")
head(raw_text)

# Find line indexes for session breaks
session_index <- grep("Session", raw_text)
raw_text[session_index]

# Seperate raw data by legislative session
s84_reg <- raw_text[session_index[1]:(session_index[2]-1)]
s83_reg <- raw_text[session_index[2]:(session_index[3]-1)]
s83_1st <- raw_text[session_index[3]:(session_index[4]-1)]
s83_2nd <- raw_text[session_index[4]:(session_index[5]-1)]
s83_3rd <- raw_text[session_index[5]:(session_index[6]-1)]
s82_reg <- raw_text[session_index[6]:(session_index[7]-1)]
s82_1st <- raw_text[session_index[7]:(session_index[8]-1)]
s81_reg <- raw_text[session_index[8]:(session_index[9]-1)]
s80_reg <- raw_text[session_index[9]:(session_index[10]-1)]
s79_reg <- raw_text[session_index[10]:(session_index[11]-1)]
s78_reg <- raw_text[session_index[11]:(session_index[12]-1)]
s78_1st <- raw_text[session_index[12]:(session_index[13]-1)]
s77_reg <- raw_text[session_index[13]:(session_index[14]-1)]
s76_reg <- raw_text[session_index[14]:(session_index[15]-1)]
s75_reg <- raw_text[session_index[15]:(session_index[16]-1)]
s74_reg <- raw_text[session_index[16]:(session_index[17]-1)]
s73_reg <- raw_text[session_index[17]:(session_index[18]-1)]
s72_reg <- raw_text[session_index[18]:(session_index[19]-1)]
s72_4th <- raw_text[session_index[19]:(session_index[20]-1)]
s71_reg <- raw_text[session_index[20]:(session_index[21]-1)]
s71_1st <- raw_text[session_index[21]:(session_index[22]-1)]
s71_2nd <- raw_text[session_index[22]:(session_index[23]-1)]
s70_reg <- raw_text[session_index[23]:(session_index[24]-1)]
s69_reg <- raw_text[session_index[24]:(session_index[25]-1)]
s68_reg <- raw_text[session_index[25]:(session_index[26]-1)]
s67_reg <- raw_text[session_index[26]:(session_index[27]-1)]
s66_reg <- raw_text[session_index[27]:(session_index[28]-1)]
s65_reg <- raw_text[session_index[28]:(session_index[29]-1)]
s64_reg <- raw_text[session_index[29]:(session_index[30]-1)]
s63_reg <- raw_text[session_index[30]:(session_index[31]-1)]
s62_reg <- raw_text[session_index[31]:(session_index[32]-1)]
s61_reg <- raw_text[session_index[32]:(session_index[33]-1)]
s60_reg <- raw_text[session_index[33]:(session_index[34]-1)]
s39_reg <- raw_text[session_index[34]:(session_index[35]-1)]
s30_reg <- raw_text[session_index[35]:length(raw_text)]

legislative_sessions <- list(s84_reg, s83_reg, s83_1st, s83_2nd, s83_3rd, s82_reg, s82_1st, s81_reg, s80_reg, s79_reg, s78_reg, s78_1st, s77_reg, s76_reg, s75_reg, s74_reg, s73_reg, s72_reg, s72_4th, s71_reg, s71_1st, s71_2nd, s70_reg, s69_reg, s68_reg, s67_reg, s66_reg, s65_reg, s64_reg, s63_reg, s62_reg, s61_reg, s60_reg, s39_reg, s30_reg)

session_names <- c("s84_reg", "s83_reg", "s83_1st", "s83_2nd", "s83_3rd", "s82_reg", "s82_1st", "s81_reg", "s80_reg", "s79_reg", "s78_reg", "s78_1st", "s77_reg", "s76_reg", "s75_reg", "s74_reg", "s73_reg", "s72_reg", "s72_4th", "s71_reg", "s71_1st", "s71_2nd", "s70_reg", "s69_reg", "s68_reg", "s67_reg", "s66_reg", "s65_reg", "s64_reg", "s63_reg", "s62_reg", "s61_reg", "s60_reg", "s39_reg", "s30_reg")

# Set the list names for each legislative session
# Variable suffixes: reg = regular session, 1st/2nd/3rd/4th = nth called session
`names<-`(legislative_sessions, session_names)

# Display the number of bills per legislative session
for (i in 1:length(legislative_sessions)) {
  print(length(grep("Caption:", legislative_sessions[[i]])))
}

# Find bill authors
author_index <- grep("Author: ", raw_text)
unique(raw_text[author_index])
table(raw_text[author_index])

# There are sponsors in addition to authors
s84 <- raw_text[session_index[1]+1:(session_index[2]-1)]
head(s84)
s84
