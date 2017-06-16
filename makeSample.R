load("../Data/blogs.RData")
load("../Data/news.RData")
load("../Data/twitter.RData")

sampleFrac <- 0.01
sampleBlogs <- blogs[sample(1:length(blogs), length(blogs) * sampleFrac)]
sampleNews <- news[sample(1:length(news), length(news) * sampleFrac)]
sampleTwitter <- twitter[sample(1:length(twitter), length(twitter) * sampleFrac)]
sampleAll <- c(sampleTwitter, sampleNews, sampleBlogs)
writeLines(sampleAll, "sampleAll.txt")
