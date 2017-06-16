library(RWekajars)
library(ggplot2)
library(qdapDictionaries)
library(qdapRegex)
library(qdapTools)
library(RColorBrewer)
library(qdap)
library(NLP)
library(tm)
library(SnowballC)
library(slam)
library(RWeka)
library(rJava)


theSampleCon <- file("./sampleAll.txt")
theSample <- readLines(theSampleCon)
close(theSampleCon)

cleanSample <- Corpus(VectorSource(theSample))
rm(theSample)

cleanSample <- tm_map(cleanSample, content_transformer(function(x) {
  iconv(x, to = "UTF-8", sub = "byte")
}))
cleanSample <- tm_map(cleanSample, content_transformer(tolower))
cleanSample <- tm_map(cleanSample, content_transformer(removePunctuation))
cleanSample <- tm_map(cleanSample, content_transformer(removeNumbers))
removeURL <- function(x) {
  gsub("http[[:alnum:]]*", "", x)
}
cleanSample <- tm_map(cleanSample, content_transformer(removeURL))
cleanSample <- tm_map(cleanSample, stripWhitespace)
cleanSample <- tm_map(cleanSample, removeWords, stopwords("english"))
cleanSample <- tm_map(cleanSample, stemDocument)
cleanSample <- tm_map(cleanSample, stripWhitespace)

saveRDS(cleanSample, file = "./Corpus.RData")
