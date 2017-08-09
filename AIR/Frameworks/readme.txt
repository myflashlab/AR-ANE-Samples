Copy the "WikitudeSDK.framework" V7.0.0 file to this folder and make sure it is packaged in your iOS build. (it must be included in your project, just like any resources.)
https://cdn.wikitude.com/sdk/7_0_0/WikitudeSDK_iOS_7-0-0_2017-07-12_18-00-55.zip

Open "WikitudeSDK.framework" and delete the folder "_CodeSignature". Make sure you are using AIR SDK 27+ to compile your app.

To double check if the framework is available in your app packaging, open the final .ipa file and you should be able to see the Framework folder at the root of your app content.