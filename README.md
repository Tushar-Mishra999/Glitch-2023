# StockPulse Glitch

## Why Stock Pulse?
- It provides valuable insights into a company's performance by analyzing news articles and reports related to the company.
- It is a user-friendly application that can help a novice to become an expert trader in no time. 
- It saves time and effort by automating the process of web crawling and scraping content from various sources. 
- Additionally, it also analyzes all the data and estimates if the news is postive/negative/neutral with respect to share value of the company.


## Description
A mobile application designed to provide users with valuable insights into a company's performance by analyzing news articles and reports related to the company. The app takes input from the user in the form of the company name and uses web scraping and crawling techniques to gather relevant data from various sources.

Natural language processing (NLP) techniques and machine learning (ML) algorithms are employed to analyze news articles related to the company. It will identify the key topics discussed in the news articles and determine the sentiment associated with each topic. The application will then aggregate the sentiment scores to provide an overall sentiment of the news articles.

The app provides users with a user-friendly interface where they can input the company name and receive an insight on how its performing lately. The users will also be provided links to the latest, relevant news articles.

This project provides a valuable tool for investors and traders who want to stay informed about the latest news related to a company and make informed decisions based on sentiment analysis. The app's machine learning model makes it easy for users to get a quick snapshot of a company's performance, saving them time and effort in analyzing large amounts of data from various resources.


## Techstack
- ### Flutter : 
For front end development, it offers advantages which speeds up the development process, a reactive programming model that simplifies UI updates, a single codebase for building apps on multiple platforms, and a rich set of customizable widgets and tools for creating beautiful and performant user interfaces
- ### NLTK : 
Natural Language Toolkit is a popular Python library used for natural language processing tasks. It provides various tools and functionalities such as tokenization, stemming, and machine learning algorithms to process and analyze text data. These features make it an ideal choice for sentiment analysis of documents.
- ### Node.js and Express.js : 
Web scraping involves extracting data from websites, and Node.js and Express.js are ideal choices for this task because of their non-blocking I/O model, which allows for fast and efficient processing of web requests and responses. They also provide a rich set of libraries and modules for handling HTTP requests, parsing HTML documents, and managing data, making web scraping easier and more streamlined.
- ### Flask: 
Flask is an ideal choice for building APIs due to its simplicity, flexibility, and scalability. It allows for easy creation of RESTful APIs using standard HTTP methods, making it easy to interface with other applications and services.
- ### AWS S3: 
Using it for storing the scraped data and using it later for sentiment analysis
- ### AWS DynamoDB: 
Storing the recent sentiment analysis scores of documents
- ### AWS EC2: 
Using it for running the server and scraping purpose since it is scalable, flexibile, cost effective. EC2 provides a highly available and fault-tolerant infrastructure, ensuring that your server and scraping jobs can continue running even if one or more instances fail.


## Installation Guide
Find the ".apk" file in the root folder and download it and install it on an Android device.

