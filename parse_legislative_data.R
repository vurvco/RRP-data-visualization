# Parse the abortion-bill search output (raw data)

raw_text <- readLines("Data/Abortion-bill search output (raw data).txt")
head(raw_text)

# Find bill authors
author_index <- grep("Author: ", raw_text)
unique(raw_text[author_index])
table(raw_text[author_index])

# Find line indexes for session breaks
session_index <- grep("Session", raw_text)
raw_text[session_index]

# There are sponsors in addition to authors
s84 <- raw_text[session_index[1]+1:(session_index[2]-1)]
head(s84)
s84

# Number of bills per session
length(grep("84th R.S.", s84))

# Break up sessions w/ raw_text[index:index-1]
# 