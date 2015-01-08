#MyTwitter
=========

Week 1 iOS DevAccel Project

#Day1:
------

Add initial files for home-grown Twitter App:

* Create your MVC groups
* Create your Tweet class with an initializer that takes a Dictionary in as a parameter
* In addition to the text property, add a property to hold the username of the person who tweeted the tweet
* Drag the tweet.json file into your Xcode project
* Parse the json file into tweet objects
* In addition to text, pull out the username from the json for each tweet and use that property you added to hold it
* Display those tweet objects in the table view
* Create a custom table view cell class with your own custom label and image view

#Day 2
------

* Use the Accounts framework to access the user's twitter account on their iOS device
* Use the Social framework to make a request to twitter for the users home timeline
* Use a ranged switch statement to make sure the status code of the response is good
* Reload the table view on the main thread once you are done parsing the JSON data from the response

#Day3
-----

* Setup your cells with autolayout so you can see the entire tweets text. If you get any .... at the end that is probably twitters API being stupid
* Move all of your network code into a network controller, and create a method to fetch the users timeline with a completion handler
* Create a 2nd view controller that fetches more specific information on the tweet that the user presses on.
* The API URL for that is "https://api.twitter.com/1.1/statuses/show.json?id=\(id)" where id is the id of the tweet that was pressed on. You should create a 2nd method in your network controller that fetches more info for the tweet that was selected, using this URL in the SLRequest.
* Upon clicking a tweet, your interface should pop to the 2nd view controller and display the tweet selected and additional info that was retrieved by the 2nd network call.
