<?php

$email = "your@email.com";
$password = "yourMetaioPassword";
$dbname = "dbtest1";

/*
	These php files are written based on metaio VS API https://dev.metaio.com/visual-search/rest-api/
	This is just a help for you to know how things should be setup in practice. [you need php_curl extension to be active]
	
	before being able to run these files, you must have your VS license applied to your account. you should read here:
	https://dev.metaio.com/visual-search/general-information/
	
	-------------------
	put these files on a server or your local computer if it can run php files!
	enter your metaio email and password and a name for your new database then, open the following files in your browser
	
	1) addDatabase.php > this will create a new db based on $dbname you provided
	2) getDatabases.php > check and confirm that your new database is added
	3) addApplication.php > open this file and edit 'appIdentifier' value to your own project package name and then run it to add your app to db
	4) addItem.php > open this file and change the name of $item_path to your own trackable image then run it to upload your new image to server
	5) getItems.php > you may check if your trackable is successfully uploaded or not
	
	That's all! now go back to your AREL scripting and set it up to read from your new database.
*/
