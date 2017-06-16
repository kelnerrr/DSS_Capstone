data_2gram <- readRDS(file = "data/data_2-gram.RData")
data_3gram <- readRDS(file = "data/data_3-gram.RData")
data_4gram <- readRDS(file = "data/data_4-gram.RData")


cleanInput <- function(text) {
  cleanText <- tolower(text)
  cleanText <- removePunctuation(cleanText)
  cleanText <- removeNumbers(cleanText)
  cleanText <- str_replace_all(cleanText, "[^[:alnum:]]", " ")
  cleanText <- stripWhitespace(cleanText)
  textInput <-
    txt.to.words.ext(cleanText, language = "English.all", preserve.case = TRUE)

  return(textInput)
}


nextWordPrediction <- function(wordCount, textInput) {
  if (wordCount >= 3) {
    textInput <- textInput[(wordCount - 2):wordCount]
  }

  else if (wordCount == 2) {
    textInput <- c(NA, textInput)
  }

  else {
    textInput <- c(NA, NA, textInput)
  }

  wordsPrediction_4gram <-
    as.character(data_4gram[data_4gram$unigram == textInput[1] &
                              data_4gram$bigram == textInput[2] &
                              data_4gram$trigram == textInput[3], ][1:3, ]$quadgram)
  wordsPrediction_3gram <-
    as.character(data_3gram[data_3gram$unigram == textInput[2] &
                              data_3gram$bigram == textInput[3], ][1:3, ]$trigram)

  wordsPrediction_2gram <-
    as.character(data_2gram[data_2gram$unigram == textInput[3], ][1:3, ]$bigram)

  wordsPrediction <- wordsPrediction_4gram
  wordsToPredictCount <- sum(is.na(wordsPrediction))
  if (wordsToPredictCount > 0) {
    wordsPrediction[is.na(wordsPrediction)] = wordsPrediction_3gram[1:wordsToPredictCount]
  }
  wordsToPredictCount <- sum(is.na(wordsPrediction))
  if (wordsToPredictCount > 0) {
    wordsPrediction[is.na(wordsPrediction)] = wordsPrediction_2gram[1:wordsToPredictCount]
  }

  cat(wordsPrediction, sep=" | ")
}
