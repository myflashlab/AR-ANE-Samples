MyAR Adobe Air Native Extension

*Apr 04, 2020 - V7.2.1-2.0.2*
* Upgraded to Androidx

*Aug 2, 2019 - V7.2.1-1.1.41*
* Added Android 64-bit support
* Supports iOS 10.0+
* removed static property ```AR.os```. You should use ```OverrideAir.os``` instead.

*Nov 16, 2018 - V7.2.1-1.1.4*
* Works with OverrideAir ANE V5.6.1 or higher
* Works with ANELAB V1.1.26 or higher

*Sep 21, 2018 - V7.2.1-1.1.1*
* Removed AndroidSupport dependency
* fixed [bug #16](https://github.com/myflashlab/AR-ANE-Samples/issues/16)

*Apr 28, 2018 - V7.2.1-1.1.0*
* Updated to Wikitude SDK V7.2.1 which has updates for [Android 8 and iOS 11 latest features](https://www.wikitude.com/blog-sdk-support-ios-11-android-8/).
* Use the new demo ANE: https://www.myflashlabs.com/anelab/ar110.ane
* Update Android resources from [wikitude_res.zip](https://github.com/myflashlab/AR-ANE-Samples/blob/master/wikitude_res.zip)
* Wikitude iOS uses dynamic frameworks. You need to download iOS [SDK V7.2.1 from here](https://github.com/myflashlab/AR-ANE-Samples/blob/master/Wikitude_iOS_SDK.zip) and add it to your project under a folder named exactly **"Frameworks"**. Then you must add the *Frameworks* folder to your project resources so the *WikitudeSDK.framework* will be added to your app final binary. If you're not sure how this should look like, checkout our [sample project setup](https://github.com/myflashlab/AR-ANE-Samples/tree/master/AIR).
  - Unlike the old version of this ANE, you can't download the framework directly from Wikitude download page. Because AIR SDK 29 is not correctly striping the unncessary archs. You should use the version linked above. We have [notified Adobe about](#) this bug so they can fix it in future versions hopefully.
  - You no longer need to open the .framework file to remove the codesignature folder.
* Compile your project using AIR SDK 29+
* Refer to [JS API documentation V7.2.1](https://www.wikitude.com/external/doc/documentation/7.2.1/Reference/JavaScript%20API/index.html)

*Dec 15, 2017 - V7.0.0-1.0.2*
* Optimized to be used with the [ANE-LAB software](https://github.com/myflashlab/ANE-LAB/).
* Make sure you are using the latest version of dependencies.

*Aug 26, 2017 - V7.0.0-1.0.0*

* Added AR screenshot support
* Added camera hardware settings

*Aug 22, 2017 - V7.0.0-0.0.2*

* Added support for JS/AIR and vice versa communication. listen to ```ArEvents.JS_TALK``` for messages from JS and use ```AR.callJS("")``` to call functions on the JS side.
* The first sample, **01_ImageTracking_1_ImageOnTarget** shows how you can have a close button on the JS side to close the AR window when clicked.

*Aug 17, 2017 - V7.0.0-0.0.1*

* Fixed blackscreen problem.
* Added calibration listeners. ```ArEvents.CALIBRATION_NEEDED```, ```ArEvents.CALIBRATION_DONE```.

*Aug 09, 2017 - V7.0.0-0.0.0*

* Rebuilt the ANE from scratch with Wikitude SDK 7.0.0 including Android+iOS support.

*Sep 07, 2015 - V5.0.0*

* Added Wikitude SDK for Android

*Jun 01, 2015 - V4.0.0*

* This version was never release because apple bought Metaio! and we shifted the extension core to be based on Wikitude

*May 14, 2015 - V3.2.0*

* fixed ANE conflicts with other ANEs must add commonDependencies.ane to your project https://github.com/myflashlab/common-dependencies-ANE

*Apr 15, 2015 - V3.1.0*

* added support for location based billboards in AREL

*Mar 15, 2015 - V3.0.0*

* supporting AREL based on MetaioSDK V6.0.2 with android and iOS 64-bit

*Dec 15, 2014 - V2.0.0*

* This version was never release and we shifted the extension core to be based on MetaioSDK

*Apr 23, 2014 - V1.6.0*

* Added support for iOS 32-bit

*Feb 05, 2014 - V1.0.0*

* beginning of the journey supporting Android only
