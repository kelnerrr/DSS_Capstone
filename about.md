#### About

This application is the capstone project for the Coursera Data Science specialization in cooperation with SwiftKey.

#### The Objective

The goal of this project was to make a Shiny application that predicts the next word.

#### The methodology

The data were taken from the provided corpora: news, blogs, and Twitter.

After taking a sample from the corpora it was cleaned in the following way:

* Removing numbers.
* Removing punctuation.
* Removing special characters.
* Removing extra white spaces.
* Removing links.

The preprocessed sample was tokeniezed into n-grams (where n = 1..4.) The results are used for predicting the next word as a function of user input and the frequencies in the n-gram tables.

#### The Usage Of The Application

The user interface is kept extremely simple. There is one input for the user to write the text. Below the user is presented with a text box showing 3 most probable next words.
