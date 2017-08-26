package
{
	import com.doitflash.consts.Easing;
	import com.doitflash.consts.Orientation;
	import com.doitflash.starling.utils.scroller.Scroller;
	import com.doitflash.starling.utils.list.List;
	import com.doitflash.consts.Direction;
	import com.doitflash.text.modules.MySprite;
	import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.desktop.NativeApplication;
	
	import com.myflashlab.air.extensions.dependency.OverrideAir;
	import com.myflashlab.air.extensions.nativePermissions.PermissionCheck;
	import com.myflashlab.air.extensions.ar.*;
	

/**
 * ...
 * @author Hadi Tavakoli - 8/8/17 9:42 AM
 */
public class Main extends Sprite
{
	private var _header:MySprite;
	private var _headerTxt:TextField;
	private var _list:List;
	private var _scroll:Scroller;
	
	private var _permissionANE:PermissionCheck = new PermissionCheck();
	private var _arSupported:Boolean;
	private var _arSettings:Config = new Config();
	
	private var _samples:Array = [
			"01_ImageTracking_1_ImageOnTarget",
			"01_ImageTracking_2_DifferentTargets",
			"01_ImageTracking_3_Interactivity",
			"01_ImageTracking_4_HtmlDrawable",
			"01_ImageTracking_5_Bonus-Sparkles",
			"02_AdvancedImageTracking_1_Gestures",
			"02_AdvancedImageTracking_2_DistanceToTarget",
			"02_AdvancedImageTracking_3_ExtendedTracking",
			"03_MultipleTargets_1_MultipleTargets",
			"03_MultipleTargets_2_DistanceBetweenTargets",
			"03_MultipleTargets_3_TransformationBetweenTargets",
			"04_CloudRecognition_1_SingleImageRecognition",
			"04_CloudRecognition_2_ContinuousImageRecognition",
			"04_CloudRecognition_3_UsingMetainformationInTheResponse",
			"05_InstantTracking_1_SimpleInstantTracking",
			"05_InstantTracking_2_3dModelOnPlane",
			"05_InstantTracking_3_Interactivity",
			"05_InstantTracking_4_SceneInteraction",
			"06_ObjectTracking_1_BasicObjectTracking",
			"06_ObjectTracking_2_2dImageAndSoundAugmentations",
			"06_ObjectTracking_3_Animated3dAugmentations",
			"07_3dModels_1_3dModelOnTarget",
			"07_3dModels_2_AppearingAnimation",
			"07_3dModels_3_Interactivity",
			"07_3dModels_4_SnapToScreen",
			"07_3dModels_5_AnimatedModelParts",
			"07_3dModels_6_3dModelAtGeoLocation",
			"08_PointOfInterest_1_PoiAtLocation",
			"08_PointOfInterest_2_PoiWithLabel",
			"08_PointOfInterest_3_MultiplePois",
			"08_PointOfInterest_4_SelectingPois",
			"09_ObtainPoiData_1_FromApplicationModel",
			"09_ObtainPoiData_2_FromLocalResource",
			"09_ObtainPoiData_3_FromWebservice",
			"10_BrowsingPois_1_PresentingDetails",
			"10_BrowsingPois_2_AddingRadar",
			"10_BrowsingPois_3_LimitingRange",
			"10_BrowsingPois_4_ReloadingContent",
			"10_BrowsingPois_5_NativeDetailScreen",
			"10_BrowsingPois_6_Bonus-CaptureScreen",
			"11_Video_1_SimpleVideo",
			"11_Video_2_PlaybackStates",
			"11_Video_3_SnappingVideo",
			"11_Video_4_Bonus-TransparentVideo",
			"12_HardwareControl_1_FrontCamera",
			"12_HardwareControl_2_CameraSwitching",
			"12_HardwareControl_3_AdvancedFeatures",
			"x_Demo_1_2dTrackingAndGeo",
			"x_Demo_2_SolarSystem(Geo)",
			"x_Demo_3_SolarSystem(2dTracking)"
	];
	
	public function Main()
	{
		OverrideAir.enableDebugger(myDebuggerDelegate);
		
		Multitouch.inputMode = MultitouchInputMode.GESTURE;
		NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys);
		
		stage.addEventListener(Event.RESIZE, onResize);
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		stage.frameRate = 30;
		
		this.scaleX = this.scaleY = DeviceInfo.dpiScaleMultiplier;
		
		AR.init(
				"QB1lsPYkkFrfbpb+rsbo4MfOg970tAnXOpFuOwASkkSziNYy55GwGbCZPn9v3BzqkLFzIW0kmZJsaUFi87u2Dee95f03lH6w0oBdcoXMlde4SFomMqpVZ96pBHvLXhTmViH4khuD3zithNg2vnh26Lh0yOcLVeYL9t9hWaffdIBTYWx0ZWRfX2alYHaopJlL7By3AC67xmemY6Z73Lp+rRsKwww7RgLv+HHppI3gmDw+RRgevIrK0RGZ1R+37J8eoWiW5r0Ltk91o6V1Ts9jOAIafqAnaxlDfvbXrKvXYzlMn6xA5SqQJSmrIGaC4juaTBaVRFXBAFUfAsmp7aB5EajVoxdjCdTwHLQcaJ8YRffDVRzOXLo91W23iHxl5ltXcU/bRJNQcOuPZbBgsHwOQv9SIEy7sGVJ8PmTWTUh89iwarsFqNaEY7tUgweG5uw6+T5IklyhcDOv7vbxxM8lE3KmMssKyQBnmqYMAuSFgLAxtwC2/0Z7Hss2+ucG4vssOvDZw1oRV1QbqsCttFWNyIWoKSaUukFoHxmWfd+x017OJ4HdAeF2c+lB/XukUf6Ti0fPcr7lUzn01w3BnEZaUtdkCONRdTUSfj3fVNpsaqB9Fi+1XIkdVF8tUjqa2guGMwdpZk12zqkH8j/YXTVUNi4UozBMjHCUlG8XojKQnso=",
				"QB1lsPYkkFrfbpb+rsbo4MfOg970tAnXOpFuOwASkkSziNYy55GwGbCZPn9v3BzqkLFzIW0kmZJsaUFi87u2Dee95f03lH6w0oBdcoXMlde4SFomMqpVZ96pBHvLXhTmViH4khuD3zithNg2vnh26Lh0yOcLVeYL9t9hWaffdIBTYWx0ZWRfX2alYHaopJlL7By3AC67xmemY6Z73Lp+rRsKwww7RgLv+HHppI3gmDw+RRgevIrK0RGZ1R+37J8eoWiW5r0Ltk91o6V1Ts9jOAIafqAnaxlDfvbXrKvXYzlMn6xA5SqQJSmrIGaC4juaTBaVRFXBAFUfAsmp7aB5EajVoxdjCdTwHLQcaJ8YRffDVRzOXLo91W23iHxl5ltXcU/bRJNQcOuPZbBgsHwOQv9SIEy7sGVJ8PmTWTUh89iwarsFqNaEY7tUgweG5uw6+T5IklyhcDOv7vbxxM8lE3KmMssKyQBnmqYMAuSFgLAxtwC2/0Z7Hss2+ucG4vssOvDZw1oRV1QbqsCttFWNyIWoKSaUukFoHxmWfd+x017OJ4HdAeF2c+lB/XukUf6Ti0fPcr7lUzn01w3BnEZaUtdkCONRdTUSfj3fVNpsaqB9Fi+1XIkdVF8tUjqa2guGMwdpZk12zqkH8j/YXTVUNi4UozBMjHCUlG8XojKQnso="
		);
		
		AR.listener.addEventListener(ArEvents.WORLD_LOAD_RESULT, onWorldLoadResult);
		AR.listener.addEventListener(ArEvents.NATIVE_WINDOW_CLOSED, onArClosed);
		AR.listener.addEventListener(ArEvents.CALIBRATION_NEEDED, onCalibrationNeeded);
		AR.listener.addEventListener(ArEvents.CALIBRATION_DONE, onCalibrationDone);
		AR.listener.addEventListener(ArEvents.JS_TALK, onJsTalk);
		AR.listener.addEventListener(ArEvents.SCREENSHOT_RESULT, onScreenshotresult);
		
		var features:Array = [];
		features.push(Features.GEO);
		features.push(Features.IMAGE_TRACKING);
		features.push(Features.INSTANT_TRACKING);
		features.push(Features.OBJECT_TRACKING);
		
		AR.checkFeatureSupport(features, onCheckResult);
		
		function onCheckResult($status:int, $msg:String):void
		{
			if($status == AR.RESULT_OK)
			{
				_arSupported = true;
				trace("Device supports all requested AR features");
				checkPermissions();
			}
			else if($status == AR.RESULT_ERROR)
			{
				trace("Device does not support all features: " + $msg);
			}
		}
	}
	
	private function myDebuggerDelegate($ane:String, $class:String, $msg:String):void
	{
		trace("["+$ane+"-"+$class+"]"+$msg);
	}
	
	private function handleKeys(e:KeyboardEvent):void
	{
		if(e.keyCode == Keyboard.BACK)
		{
			e.preventDefault();
			NativeApplication.nativeApplication.exit();
		}
	}
	
	private function checkPermissions():void
	{
		if(_permissionANE.check(PermissionCheck.SOURCE_CAMERA) == PermissionCheck.PERMISSION_GRANTED)
		{
			onCameraRequestResult(PermissionCheck.PERMISSION_GRANTED);
		}
		else
		{
			_permissionANE.request(PermissionCheck.SOURCE_CAMERA, onCameraRequestResult);
		}
		
		function onCameraRequestResult($state:int):void
		{
			if($state != PermissionCheck.PERMISSION_GRANTED)
			{
				trace("AR ANE needs Camera access to work properly");
				return;
			}
			
			if(AR.os == AR.ANDROID && _permissionANE.check(PermissionCheck.SOURCE_LOCATION) == PermissionCheck.PERMISSION_GRANTED)
			{
				onLocationRequestResult(PermissionCheck.PERMISSION_GRANTED);
			}
			else if(AR.os == AR.IOS && _permissionANE.check(PermissionCheck.SOURCE_LOCATION_WHEN_IN_USE) == PermissionCheck.PERMISSION_GRANTED)
			{
				onLocationRequestResult(PermissionCheck.PERMISSION_GRANTED);
			}
			else
			{
				if(AR.os == AR.ANDROID)
				{
					_permissionANE.request(PermissionCheck.SOURCE_LOCATION, onLocationRequestResult);
				}
				else if(AR.os == AR.IOS)
				{
					_permissionANE.request(PermissionCheck.SOURCE_LOCATION_WHEN_IN_USE, onLocationRequestResult);
				}
			}
		}
		
		function onLocationRequestResult($state:int):void
		{
			if($state != PermissionCheck.PERMISSION_GRANTED)
			{
				trace("AR ANE needs Location access to work properly");
				return;
			}
			
			trace("Cheers, All permissions are allowed for AR to work correctly.");
			
			init();
			onResize();
		}
	}
	
	private function init():void
	{
		_header = new MySprite();
		_header.bgAlpha = 1;
		_header.bgColor = 0x039be5;
		_header.drawBg();
		this.addChild(_header);
		
		_headerTxt = new TextField();
		_headerTxt.antiAliasType = AntiAliasType.ADVANCED;
		_headerTxt.autoSize = TextFieldAutoSize.LEFT;
		_headerTxt.defaultTextFormat = new TextFormat("Arimo", 15, 0xEEEEEE);
		_headerTxt.scaleX = _headerTxt.scaleY = DeviceInfo.dpiScaleMultiplier;
		_headerTxt.htmlText = "<p align='left'><b>AR ANE V"+AR.VERSION+" examples</b></p>";
		_header.addChild(_headerTxt);
		
		// init the list
		_list = new List();
		_list.holder = new MySprite();
		_list.itemsHolder = new Sprite();
		_list.orientation = Orientation.VERTICAL;
		_list.hDirection = Direction.LEFT_TO_RIGHT;
		_list.vDirection = Direction.TOP_TO_BOTTOM;
		_list.space = 2;
		_list.row = 1;
		
		// build scroller holder
		_list.holder.addEventListener(MouseEvent.MOUSE_DOWN, onScrollDown);
		_list.holder.bgAlpha = 0;
		_list.holder.bgColor = 0xFFFFFF;
		_list.holder.drawBg();
		_list.holder.mask = new MySprite();
		this.addChild(_list.holder);
		
		// build the scroller mask
		_list.holder.mask.bgAlpha = 1;
		_list.holder.mask.bgColor = 0xFFFFFF;
		_list.holder.mask.drawBg();
		this.addChild(_list.holder.mask);
		
		// init the scroller itself
		_scroll = new Scroller();
		_scroll.content = _list.itemsHolder;
		_scroll.orientation = Orientation.VERTICAL;
		_scroll.easeType = Easing.Expo_easeOut;
		_scroll.duration = 0.2;
		_scroll.holdArea = 25;
		_scroll.isStickTouch = false;
		_scroll.dpiScaleMultiplier = DeviceInfo.dpiScaleMultiplier;
		
		for(var i:int=0; i<_samples.length; i++)
		{
			var item:Item = new Item();
			item.addEventListener(MouseEvent.CLICK, onItemClick);
			item.sample = _samples[i];
			_list.add(item);
		}
	}
	
	private function onItemClick(e:MouseEvent):void
	{
		var selectedItem:Item = e.currentTarget as Item;
		
		if(!_arSupported)
		{
			trace("AR features are not supported on your device. sorry!");
			return;
		}
		
		trace("launching AR, please wait...");
		
		_arSettings.camFocusMode = CameraFocusMode.CONTINUOUS;
		_arSettings.camPosition = CameraPosition.BACK;
		_arSettings.camResolution = CameraResolution.SD_640x480;
		
		// for best performance, you must activated only the AR features which you will use.
		_arSettings.hasGeo = true;
		_arSettings.hasInstant = true;
		_arSettings.hasIR = true;
		_arSettings.hasObject = true;
		
		if(AR.os == AR.ANDROID)
		{
			// Android specific settings
			_arSettings.android.cam2Enabled = false;
			_arSettings.android.fullscreenMode = true;
			_arSettings.android.camFocusDistanceAndroid = 1;
		}
		else if(AR.os == AR.IOS)
		{
			// iOS specific settings
			_arSettings.ios.camFocusDistance = -1.0;
			_arSettings.ios.camFocusRange = FocusRange.NONE;
			_arSettings.ios.framerate = 30;
			_arSettings.ios.excludeBinnedVideo = true;
			
			// you should create a close button in your html view. (check sample 01_ImageTracking_1_ImageOnTarget)
			// This property is only used for demo reasons. We have put it here for the iOS side only so you can
			// close the AR camera easily.
			_arSettings.btnExit = File.applicationDirectory.resolvePath("exit.png"); // does not do anything on Android
		}
		
		AR.config(_arSettings);
		AR.launchAR(selectedItem.sample+"/index.html");
	}
	
	private function onResize(e:*=null):void
	{
		if(_list)
		{
			for(var i:int=0; i<_list.items.length; i++)
			{
				var item:MySprite = _list.items[i].content as MySprite;
				item.width = (stage.stageWidth/DeviceInfo.dpiScaleMultiplier - _list.space*2);
				item.height = 55;
			}
			_list.itemArrange();
			
			_header.x = _list.space;
			_header.y = _list.space;
			_header.width = (stage.stageWidth/DeviceInfo.dpiScaleMultiplier - _list.space*2);
			_header.height = 100;
			_headerTxt.x = 10;
			_headerTxt.y = _header.height - _headerTxt.height >> 1;
			
			_list.holder.x = _list.space;
			_list.holder.y = _header.y + _header.height + _list.space;
			_list.holder.width = _header.width;
			_list.holder.height = (stage.stageHeight/DeviceInfo.dpiScaleMultiplier - _list.space*2) - _header.height;
			
			_list.holder.mask.x = _list.holder.x;
			_list.holder.mask.y = _list.holder.y;
			_list.holder.mask.width = _list.holder.width;
			_list.holder.mask.height = _list.holder.height;
			
			_scroll.boundWidth = _list.holder.width;
			_scroll.boundHeight = _list.holder.height;
		}
	}
	
	private function onScrollDown(e:MouseEvent):void
	{
		_scroll.startScroll(new Point(e.stageX, e.stageY));
		
		this.stage.addEventListener(MouseEvent.MOUSE_MOVE, 		onScrollMove);
		this.stage.addEventListener(MouseEvent.MOUSE_UP, 		onScrollUp);
	}
	
	private function onScrollMove(e:MouseEvent):void
	{
		_scroll.startScroll(new Point(e.stageX, e.stageY));
		
		if(_scroll.isHoldAreaDone) _list.itemsHolder.mouseChildren = false;
	}
	
	private function onScrollUp(e:MouseEvent):void
	{
		this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onScrollMove);
		this.stage.removeEventListener(MouseEvent.MOUSE_UP, onScrollUp);
		
		_scroll.fling();
		
		_list.itemsHolder.mouseChildren = true;
	}
	
	private function onWorldLoadResult(e:ArEvents):void
	{
		if(e.status == AR.RESULT_OK)
		{
			trace("AR World load succeeded for URL: " + e.url);
		}
		else if(e.status == AR.RESULT_ERROR)
		{
			trace("AR World load failed for URL: " + e.url);
			trace("failed reason: " + e.msg);
		}
	}
	
	private function onArClosed(e:ArEvents):void
	{
		trace("AR closed");
	}
	
	private function onCalibrationNeeded(e:ArEvents):void
	{
		trace("onCalibrationNeeded");
	}
	
	private function onCalibrationDone(e:ArEvents):void
	{
		trace("onCalibrationDone");
	}
	
	private function onJsTalk(e:ArEvents):void
	{
		trace("onJsTalk: " + e.msg);
		
		// you may call functions on the js side using the AR.callJS method.
//		AR.callJS("remoteJSfunction('value1', 'value2')");
		
		// The best practice is to send a json string from js to AIR
		var obj:Object = JSON.parse(e.msg);
		
		if(obj.action == "close_ar")
		{
			AR.endAR();
		}
		else if(obj.action == "capture_screen")
		{
			AR.captureScreen(
					Screenshot.CAPTURE_MODE_CAM,
					"test2.png" // relative path to File.applicationStorageDirectory
			);
		}
	}
	
	private function onScreenshotresult(e:ArEvents):void
	{
		if(e.status == AR.RESULT_OK)
		{
			trace("screenshot success", e.screenshot.nativePath + " = " + e.screenshot.size);
		}
		else if(e.status == AR.RESULT_ERROR)
		{
			trace("screenshot failed reason: " + e.msg);
		}
	}
}
}
