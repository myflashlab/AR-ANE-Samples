Copy the "WikitudeSDK.framework" V7.2.1 file to this folder and make sure it is packaged in your iOS build. (it must be included in your project, just like any resources.)
https://github.com/myflashlab/AR-ANE-Samples/blob/master/Wikitude_iOS_SDK.zip

Make sure you are using AIR SDK 30+ to compile your app.

To double check if the framework is available in your app packaging, open the final .ipa file and you should be able to see the Framework folder at the root of your app content.

Tip: You must remove this file before packaging your app. The applicationLoader app will nag about it.