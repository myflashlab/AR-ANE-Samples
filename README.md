# Augmented Reality ANE for Android+iOS

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

You have access to the [demo ANE](https://www.myflashlabs.com/anelab/ar114.ane) and [sample .apk file](https://drive.google.com/drive/folders/0B7eHG2CEml2TN3B5emFxYlNkQXM?usp=sharing)

**Note:** The size of the ANE is huge! This does NOT mean that your final app build would be that large. ANEs include different build archs but when you compile your app, only the required archs will be compiled into your final app. That said, the AR ANE is still the biggest ANE we have ever built, byte-size wise talking.

# Sample AIR Project

In this repository you can find a sample intelliJ project which has all the necessary settings and configuration. Feel free to run the project and see the Augmented Reality samples in action.

# Sample AR Targets

While running the sample AIR project, you will need some targets to initiate the AR experience. You can download these sample targets from [this page](https://www.wikitude.com/external/doc/documentation/7.2.1/ios/targetimages.html#target-images). Some of the samples provided by Myflashlabs may have different image targets. grab them from [here](https://github.com/myflashlab/AR-ANE-Samples/tree/master/targets).

# Requirements

1. Android API 19+
2. iOS SDK 9.0+
3. AIR SDK 30+
4. This ANE is dependent on **[overrideAir.ane](https://github.com/myflashlab/common-dependencies-ANE/tree/master/overridAir)** and **[permissionCheck.ane](https://github.com/myflashlab/PermissionCheck-ANE/tree/master/AIR/lib)**. You need to add these ANEs to your project too.
5. To compile on iOS, you will need to create a folder named ```Frameworks``` at the root of your project and copy the [WikitudeSDK.framework V7.2.1](https://github.com/myflashlab/AR-ANE-Samples/blob/master/Wikitude_iOS_SDK.zip) file to this folder and make sure it is packaged in your iOS build. (it must be included in your project, just like any resources).

# Commercial Version
http://www.myflashlabs.com/product/augmented-reality-ane-adobe-air-native-extension/

![Augmented Reality ANE](https://www.myflashlabs.com/wp-content/uploads/2015/11/product_adobe-air-ane-augmented-reality-595x738.jpg)

**IMPORTANT: After purchasing the commercial version of the ANE from Myflashlabs store, you will receive a discount coupon. You can use that coupon to purchase Wikitude license.**

Here's an example of how the coupon works: If the ANE price is $x and the Wikitude license is $y, you will get the wikitude license for $y - $x. Check out their [pricing table](https://www.wikitude.com/store/) and pick the best option which suits you.

**Notice:** to get the wikitude coupon, you need to get the ANE commercial version first

# Premium Support #
[![Premium Support package](https://www.myflashlabs.com/wp-content/uploads/2016/06/professional-support.jpg)](https://www.myflashlabs.com/product/myflashlabs-support/)
If you are an [active MyFlashLabs club member](https://www.myflashlabs.com/product/myflashlabs-club-membership/), you will have access to our private and secure support ticket system for all our ANEs. Even if you are not a member, you can still receive premium help if you purchase the [premium support package](https://www.myflashlabs.com/product/myflashlabs-support/).

Any question regarding how the AR works in action is considered the [Wikitude's area of support](https://support.wikitude.com/support/home).