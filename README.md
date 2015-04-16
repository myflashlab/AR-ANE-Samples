# AR-ANE-Samples
MyAR is an augmented reality Air Native Extension supporting Android and iOS 64-bit based on Metaio's SDK which gives you full power over your AR content through AREL. http://www.metaio.com/

you may also run the demo .apk in your device to see it in action: https://github.com/myflashlab/AR-ANE-SampleMarkerless3DAnimation/raw/master/FlashDevelop/dist/exAR-captive-runtime.apk

for more information, read "ReadMe.pdf" 

# Sample videos: 
SampleMarkerless3DAnimation.as =	https://www.youtube.com/watch?v=2j6HLW1CzzM
SampleMarkerlessVideoPlayback.as =	https://www.youtube.com/watch?v=bY1YwXFT4t4
SampleLocationBased.as =			https://www.youtube.com/watch?v=XAZr6UxjY_s
Sample360View.as = 					https://www.youtube.com/watch?v=N-S1oQSkuNg

# AS3 API:

     import com.doitflash.air.extensions.AR.MyAR;
     import com.doitflash.air.extensions.AR.MyAREvent;
     
     var _ex:MyAR = new MyAR();
     _ex.stage = stage;
     _ex.fixAirSDKOrientsBug(stage.autoOrients); // this is a bug on iOS 64-bit only. we must wait for adobe to give a final solution. calling this method is just a workaround so the app won't break when returning from AR in iOS devices.
     _ex.addEventListener(MyAREvent.COMMUNICATION, onCommunication); // A listener to listen to messages coming from AREL side
     _ex.addEventListener(MyAREvent.STATUS, onStatus); // A listener to know about the AR status: MyAR.AR_STARTED / MyAR.AR_FINISHED
     
	 var isSupported:Boolean = _ex.isSupported(); // the isSupported() method must always be called after initializing the extension
     trace("is Supported = ", isSupported);
     
     _ex.startAR("/METAIO_AR_ANE_demo/AREL_FILES/index.xml", true); // returns false if the file is not found
     // _ex.finishAR(); // call this method to close the AR camera and return back to flash
     
     function onCommunication(e:MyAREvent):void
     {
         // send a message from AREL to flash like: arel.Media.openWebsite("flash://MY_MESSAGE_FROM_JS")
         trace("message from AREL = " + e.param);
         
         // on the AREL side, you may wish to open a URL in device's browser. for this reason, call:
         // arel.Media.openWebsite("http://www.myappsnippet.com/")
         
         // you can also call functions on the AREL side from flash, like this:
         _ex.toAREL("javascript:myjavascriptfunc('param 1 from Flash!', 'param 2 from Flash!')"); // myjavascriptfunc is a function you may create on the AREL side
     }
     
     function onStatus(e:MyAREvent):void
     {
         trace("AR Status = " + e.param);
     }
