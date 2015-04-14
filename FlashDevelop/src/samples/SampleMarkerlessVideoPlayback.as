package samples {
	import com.doitflash.air.extensions.AR.MyAR;
	import com.doitflash.air.extensions.AR.MyAREvent;
	import com.doitflash.tools.URLLoader;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	import flash.utils.ByteArray;
	
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	
	import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;
	
	import com.doitflash.starling.utils.list.List;
	
	import com.doitflash.text.modules.MySprite;
	
	import com.doitflash.tools.sizeControl.FileSizeConvertor;
	
	import com.luaye.console.C;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.events.InvokeEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	
	import flash.filesystem.File;
	
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * 
	 * @author Hadi Tavakoli - 3/30/2015 12:17 PM
	 */
	public class SampleMarkerlessVideoPlayback extends Sprite 
	{
		private var _ex:MyAR;
		
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		private var _isCopyDone:Boolean = false;
		
		public function SampleMarkerlessVideoPlayback():void 
		{
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate);
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys, false, 0, true);
			
			stage.addEventListener(Event.RESIZE, onResize);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			C.startOnStage(this, "`");
			C.commandLine = false;
			C.commandLineAllowed = false;
			C.x = 100;
			C.width = 500;
			C.height = 250;
			C.strongRef = true;
			C.visible = true;
			C.scaleX = C.scaleY = DeviceInfo.dpiScaleMultiplier;
			
			_txt = new TextField();
			_txt.autoSize = TextFieldAutoSize.LEFT;
			_txt.antiAliasType = AntiAliasType.ADVANCED;
			_txt.multiline = true;
			_txt.wordWrap = true;
			_txt.embedFonts = false;
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>AR Extension V"+MyAR.VERSION+" for adobe air</b></font>";
			_txt.scaleX = _txt.scaleY = DeviceInfo.dpiScaleMultiplier;
			this.addChild(_txt);
			
			_body = new Sprite();
			this.addChild(_body);
			
			_list = new List();
			_list.holder = _body;
			_list.itemsHolder = new Sprite();
			_list.orientation = Orientation.VERTICAL;
			_list.hDirection = Direction.LEFT_TO_RIGHT;
			_list.vDirection = Direction.TOP_TO_BOTTOM;
			_list.space = BTN_SPACE;
			
			init();
			onResize();
		}
		
		private function onInvoke(e:InvokeEvent):void
		{
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvoke);
		}
		
		private function handleActivate(e:Event):void 
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			trace("flash is active");
		}
		
		private function handleDeactivate(e:Event):void 
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
			trace("flash deactived");
		}
		
		private function handleKeys(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.BACK)
            {
				e.preventDefault();
				
				NativeApplication.nativeApplication.exit();
            }
		}
		
		private function onResize(e:*=null):void
		{
			if (_txt)
			{
				_txt.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
				
				C.x = 0;
				C.y = _txt.y + _txt.height + 0;
				C.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
				C.height = 300 * (1 / DeviceInfo.dpiScaleMultiplier);
			}
			
			if (_list)
			{
				_numRows = Math.floor(stage.stageWidth / (BTN_WIDTH * DeviceInfo.dpiScaleMultiplier + BTN_SPACE));
				_list.row = _numRows;
				_list.itemArrange();
			}
			
			if (_body)
			{
				_body.y = stage.stageHeight - _body.height;
			}
		}
		
		private function init():void
		{
			// check here for trackable rating discussions: http://helpdesk.metaio.com/questions/44103/low-ratings-on-image-targets-for-unity
			
			_ex = new MyAR();
			_ex.stage = stage;
			_ex.fixAirSDKOrientsBug(stage.autoOrients); // this is a bug on iOS 64-bit only. we must wait for adobe to give a final solution. calling this method is just a workaround so the app won't break when returning from AR in iOS devices.
			_ex.addEventListener(MyAREvent.COMMUNICATION, onCommunication);
			_ex.addEventListener(MyAREvent.STATUS, onStatus);
			
			var isSupported:Boolean = _ex.isSupported(); // isSupported() method MUST be always called after initializing the extension
			C.log("is Supported = ", isSupported);
			
			var src:File = File.applicationDirectory.resolvePath("SampleMarkerlessVideoPlayback");
			var dis:File = File.documentsDirectory.resolvePath("MyAR/SampleMarkerlessVideoPlayback");
			if (dis.exists) dis.deleteDirectory(true);
			if (!dis.exists) 
			{
				_isCopyDone = false;
				C.log("Copying AREL assets to sdcard for the sake of this demo sample... please wait...");
				src.addEventListener(Event.COMPLETE, onCopyDone);
				src.copyToAsync(dis);
			}
			else
			{
				_isCopyDone = true;
			}
			
			function onCopyDone(e:Event):void
			{
				src.removeEventListener(Event.COMPLETE, onCopyDone);
				C.log("copy completed. please hit the 'START AR' button now!");
				_isCopyDone = true;
			}
			
			
			var btn1:MySprite = createBtn("START AR");
			btn1.addEventListener(MouseEvent.CLICK, startAR);
			_list.add(btn1);
			
			function startAR(e:MouseEvent):void
			{
				if (_isCopyDone)
				{
					C.log("startAR = ", _ex.startAR("/MyAR/SampleMarkerlessVideoPlayback/content/index.xml", true)); // make sure you are starting with the initial slash at the begining!
				}
				else
				{
					C.log("wait... we're copying the assets to sdcard...")
				}
			}
		}
		
		private function onCommunication(e:MyAREvent):void
		{
			if (String(e.param).indexOf("flash://READY_AR") == 0) // when flash receives this string, it means that AREL is ready to start
			{
				// flash calls this method to get the config.js and change it if needed (it can add availability property to the vids array)
				_ex.toAREL("javascript:getConfig()");
			}
			else if (String(e.param).indexOf("flash://CLOSE_AR") == 0)
			{
				_ex.finishAR();
			}
			else if (String(e.param).indexOf("flash://config=") == 0)
			{
				var newConfig:Object = checkVideoAvailablity(JSON.parse(String(e.param).split("://config=")[1]));
				
				// call init in AREL after we modified the config
				_ex.toAREL("javascript:init("+ JSON.stringify(newConfig) +")");
			}
			else if (String(e.param).indexOf("flash://toDownloadVid=") == 0)
			{
				var obj:Object = JSON.parse(String(e.param).split("://toDownloadVid=")[1]);
				
				trace("toDownloadVid >> " + obj.url);
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.obj = obj;
				urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
				urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
				urlLoader.addEventListener(Event.COMPLETE, onComplete);
				urlLoader.load(new URLRequest(obj.url));
			}
			else if (String(e.param).indexOf("flash://toFullscreen=") == 0)
			{
				var o:Object = JSON.parse(String(e.param).split("://toFullscreen=")[1]);
				
				C.log("toFullscreen >> ");
				for (var name:String in o) 
				{
					trace(name + " = " + o[name]);
				}
			}
		}
		
		private function checkVideoAvailablity($config:Object):Object
		{
			var vids:Array = $config.vids;
			
			var currVideo:Object;
			for (var i:int = 0; i < vids.length; i++) 
			{
				currVideo = vids[i];
				if (File.documentsDirectory.resolvePath("MyAR/SampleMarkerlessVideoPlayback/content/" + currVideo.path).exists)
				{
					currVideo.availability = true;
				}
				else
				{
					currVideo.availability = false;
				}
			}
			
			return $config;
		}
		
		private function onProgress(e:ProgressEvent):void
		{
			var urlLoader:URLLoader = e.target as URLLoader;
			
			var perc:Number = e.bytesLoaded / e.bytesTotal * 100;
			_ex.toAREL("javascript:downloadInProgress("+ urlLoader.obj.id +", "+ int(perc) +")");
		}
		
		private function onComplete(e:Event):void
		{
			var urlLoader:URLLoader = e.target as URLLoader;
			
			urlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			urlLoader.removeEventListener(Event.COMPLETE, onComplete);
			
			// save the video where we need it to be
			var address:File = File.documentsDirectory.resolvePath("MyAR/SampleMarkerlessVideoPlayback/content/" + urlLoader.obj.path);
			var fs:FileStream = new FileStream();
			fs.open(address, FileMode.WRITE);
			fs.writeBytes(urlLoader.data as ByteArray);
			fs.close();
			
			_ex.toAREL("javascript:downloadComplete("+ urlLoader.obj.id +")");
		}
		
		
		
		
		
		
		
		
		
		
		
		
		private function onStatus(e:MyAREvent):void
		{
			C.log("AR Status = " + e.param);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		private function createBtn($str:String):MySprite
		{
			var sp:MySprite = new MySprite();
			sp.addEventListener(MouseEvent.MOUSE_OVER,  onOver);
			sp.addEventListener(MouseEvent.MOUSE_OUT,  onOut);
			sp.addEventListener(MouseEvent.CLICK,  onOut);
			sp.bgAlpha = 1;
			sp.bgColor = 0xDFE4FF;
			sp.drawBg();
			sp.width = BTN_WIDTH * DeviceInfo.dpiScaleMultiplier;
			sp.height = BTN_HEIGHT * DeviceInfo.dpiScaleMultiplier;
			
			function onOver(e:MouseEvent):void
			{
				sp.bgAlpha = 1;
				sp.bgColor = 0xFFDB48;
				sp.drawBg();
			}
			
			function onOut(e:MouseEvent):void
			{
				sp.bgAlpha = 1;
				sp.bgColor = 0xDFE4FF;
				sp.drawBg();
			}
			
			var format:TextFormat = new TextFormat("Arimo", 16, 0x666666, null, null, null, null, null, TextFormatAlign.CENTER);
			
			var txt:TextField = new TextField();
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.mouseEnabled = false;
			txt.multiline = true;
			txt.wordWrap = true;
			txt.scaleX = txt.scaleY = DeviceInfo.dpiScaleMultiplier;
			txt.width = sp.width * (1 / DeviceInfo.dpiScaleMultiplier);
			txt.defaultTextFormat = format;
			txt.text = $str;
			
			txt.y = sp.height - txt.height >> 1;
			sp.addChild(txt);
			
			return sp;
		}
	}
	
}