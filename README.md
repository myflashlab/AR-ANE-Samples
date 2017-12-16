# Augmented Reality ANE V7.0.0-1.0.2 for Android+iOS

This ANE is built on Wikitude SDK and allows you to create Augmented Reality in your apps without knowing any 3D engine programming. You can create complex AR scenes using HTML/JS only.

In this repository, you will find all the necessary information about how to implement the AR ANE in your project. make sure you are reading the [wiki pages](https://github.com/myflashlab/AR-ANE-Samples/wiki) for more detailed information. You may also find the latest asdoc for this ANE [here](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/ar/package-detail.html).

**Main Features:**

* Geo Augmentation
* 2D Image Recognition
* 3D Engine controlled by HTML/JS
* Instant Tracking (SLAM)
* Object Recognition
* Cloud Recognition

# Download The ANE

You have access to the [demo ANE](https://www.myflashlabs.com/anelab/ar102.ane) and [sample .apk file](https://drive.google.com/drive/folders/0B7eHG2CEml2TN3B5emFxYlNkQXM?usp=sharing)

**Note:** The size of the ANE is huge! This does NOT mean that your final app build would be that large. ANEs include different build archs but when you compile your app, only the required archs will be compiled into your final app. That said, the AR ANE is still the biggest ANE we have ever built, byte-size wise talking.

# Sample AIR Project

In this repository you can find a sample intelliJ project which has all the necessary settings and configuration. Feel free to run the project and see the Augmented Reality samples in action.

# Sample AR Targets

While running the sample AIR project, you will need some targets to initiate the AR experience. You can download these sample targets from [this page](https://www.wikitude.com/external/doc/documentation/latest/ios/targetimages.html#target-images). Some of the samples provided by Myflashlabs may have different image targets. grab them from [here](https://github.com/myflashlab/AR-ANE-Samples/tree/master/targets).

# Requirements

1. Android API 19+
2. iOS SDK 9.0+
3. AIR SDK 27+
4. This ANE is dependent on **[androidSupport.ane](https://github.com/myflashlab/common-dependencies-ANE/tree/master/androidSupport)**, **[overrideAir.ane](https://github.com/myflashlab/common-dependencies-ANE/tree/master/overridAir)** and **[permissionCheck.ane](https://github.com/myflashlab/PermissionCheck-ANE/tree/master/FD/lib)**. You need to add these ANEs to your project too.
5. To compile on iOS, you will need to create a folder named ```Frameworks``` at the root of your project and copy the [WikitudeSDK.framework V7.0.0](https://cdn.wikitude.com/sdk/7_0_0/WikitudeSDK_iOS_7-0-0_2017-07-12_18-00-55.zip) file to this folder and make sure it is packaged in your iOS build. (it must be included in your project, just like any resources). Moreover, You need to open "WikitudeSDK.framework" and delete the folder "_CodeSignature" so the AIR SDK can correctly sign the framework for you.

# Commercial Version
http://www.myflashlabs.com/product/augmented-reality-ane-adobe-air-native-extension/

![Augmented Reality ANE](http://www.myflashlabs.com/wp-content/uploads/2015/11/product_adobe-air-ane-augmented-reality-595x738.jpg)

**IMPORTANT: After purchasing the commercial version of the ANE from Myflashlabs store, you will receive a discount coupon from Wikitude. You can use that coupon to purchase Wikitude license.**

Here's an example of how the coupon works: If the ANE price is $x and the Wikitude license is $y, you will get the wikitude license for $y - $x. Check out their [pricing table](https://www.wikitude.com/store/) and pick the best option which suits you.

**Notice:** to get the wikitude coupon, you need to get the ANE commercial version first.

![Augmented Reality ANE](http://www.myflashlabs.com/wp-content/uploads/2015/11/product_adobe-air-ane-augmented-reality-1-595x738.jpg)

# Support

Similar to all our other ANEs, our dev team is ready to help you with any questions you might have about the ANE side of this project. Any question regarding how the ANE should be implemented in your AIR projects can be asked here in the [issues section](https://github.com/myflashlab/AR-ANE-Samples/issues). However,  any question regarding how the AR works in action is considered the [Wikitude's area of support](https://support.wikitude.com/support/home).

# Changelog

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
