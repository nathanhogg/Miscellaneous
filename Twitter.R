# Script Name:  Twitter.R
#      Author:  Nathan Hogg
#  Orig. Date:  1/31/2016
#    Overview:  This script looks at trends for the twitter timeline of a user
# 
# Inputs:
#   1) twitter API info - consumer key, access token, etc.
#   2) twitter handle 
#
# Outputs:
#   1) TBD - probably will be plots to summarize trends over time

# Load the required packages
library("twitteR")
library("ROAuth")
library("base64enc")
library("ggplot2")

# Input the twitter API information
consumer_key <- 'W'     # Input actual consumer key
consumer_secret <- 'X'  # Input actual consumer secret
access_token <- 'Y'     # Input actual access token
access_secret <- 'Z'    # Input actual access secret

# Authorize the script to access twitter data
setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)

# Get a data frame of the tweets and corresponding data for a user
tweets <- twListToDF(userTimeline("ti_n89", n = 2500))

# Separate the created date so time trends can be examined
tweets$Month <- substr(tweets$created, 1, 7)
tweets$Day <- weekdays(as.Date(tweets$created))
tweets$Hour <- substr(tweets$created, 12, 13)

# Construct a boxplot to see the average favorites by day of the week
p <- ggplot(tweets, aes(factor(Day), favoriteCount))
p + geom_boxplot()
