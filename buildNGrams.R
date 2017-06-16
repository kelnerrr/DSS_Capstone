corpus <- readRDS("./Corpus.RData")
corpus <- data.frame(text=sapply(corpus, identity), stringsAsFactors=F)

## Building the tokenization function for the n-grams
ngramTokenizer <- function(theCorpus, ngramCount) {
  ngramFunction <- NGramTokenizer(
    theCorpus,
    Weka_control(
      min = ngramCount,
      max = ngramCount,
      delimiters = " \\r\\n\\t.,;:\"()?!"
    )
  )
  ngramFunction <- data.frame(table(ngramFunction))
  ngramFunction <- ngramFunction[order(ngramFunction$Freq, decreasing = TRUE), ]
  colnames(ngramFunction) <- c("String", "Count")
  ngramFunction
}

data_1-gram <- ngramTokenizer(corpus, 1)
saveRDS(data_1-gram, file = "./data_1-gram.RData")
data_2-gram <- ngramTokenizer(corpus, 2)
saveRDS(data_2-gram, file = "./data_2-gram.RData")
data_3-gram <- ngramTokenizer(corpus, 3)
saveRDS(data_3-gram, file = "./data_3-gram.RData")
data_4-gram <- ngramTokenizer(corpus, 4)
saveRDS(data_4-gram, file = "./data_4-gram.RData")
