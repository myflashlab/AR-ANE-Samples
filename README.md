# AR-ANE-Samples

###Sep 07 , 2015 Update: We just finished Beta development on the Android side of the Wikitude SDK. You can use this version to test it in your projects but please note that it's not in release mode yet and we may change a lot of things about it. This is just a showcase to keep you devs updated with the process [read here for more information](http://myappsnippet.com/ar-sdk-ane-poll/)

![MyAR ANE](http://myappsnippet.com/wp-content/uploads/2014/12/augmented-reality-adobe-air-extension_preview.jpg)

# AS3 API:
```actionscript
import com.doitflash.air.extensions.AR.MyAR;
import com.doitflash.air.extensions.AR.MyAREvent;
import com.doitflash.air.extensions.AR.CameraPosition;

var _ex:MyAR = new MyAR([YOUR Wikitude License for Android], [YOUR Wikitude License for iOS], true);
_ex.addEventListener(MyAREvent.STATUS, onArStatus);
_ex.addEventListener(MyAREvent.COMMUNICATION, onCommunication);
_ex.addEventListener(MyAREvent.COMPASS_ACCURACY_CHANGED, onCompassAccuracyChanged);

var isSupported:Boolean = _ex.isSupported;
trace("is Supported = ", isSupported);

// can read Artichect path from assets, sdcard or online
_ex.startAR("samples/1_Client$Recognition_1_Image$On$Target/index.html", false, true, CameraPosition.DEFAULT, true) // returns false if the file is not found
// _ex.finishAR(); // call this method to close the AR camera and return back to flash

function onArStatus(e:MyAREvent):void
{
	trace("onArStatus = " + e.param);
}

function onCompassAccuracyChanged(e:MyAREvent):void
{
	trace("Compass Accuracy = " + e.param);
}

function onCommunication(e:MyAREvent):void
{
	trace("msg from JS = " + e.param);
	
	// send a msg to JS
	_ex.callJavascript("javascript:msgFromFlash('param 1 from Flash!')");
}
```