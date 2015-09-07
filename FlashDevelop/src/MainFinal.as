package 
{
	import com.doitflash.air.extensions.AR.MyAR;
	import com.doitflash.air.extensions.AR.MyAREvent;
	import com.doitflash.air.extensions.AR.CameraPosition;
	import flash.utils.setTimeout;
	
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
	 * @author Hadi Tavakoli - 8/12/2015 12:43 PM
	 */
	public class MainFinal extends Sprite 
	{
		private var _ex:MyAR;
		
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function MainFinal():void 
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
			stage.frameRate = 60;
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			trace("flash is active")
		}
		
		private function handleDeactivate(e:Event):void 
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
			trace("flash deactived")
			stage.frameRate = 4;
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
			var keyAndroid	:String = 	"QzrrlCUrLe+aK0OzFRgJykGDBB7yVVqLA+7+FTh+i+Ht6BcKSm57d/MDoQRVEVxdC8arOP8mhzVL+aBgQTt6PQLa6wZF3MnmS3suBDTaYtmNZMUeyCW8iD1m4m95wR94gWPsX4Vs/tD2bJc8m8h33R3qYkrojJbqYv4MxfAh8wxTYWx0ZWRfX3UeRw4FjSiiMZL4VqT8TAixB5kyAzQxn7EnKZit2BP7eIEJm2cvE7Elwh24pbzlIqLdMUCruds/Qxi+t6lDLfQPN9zRn1Lo+1XYnCna8Ky8teuPcaK3Q+APvUOoFa0YYo/hcTHIGI0x09VktCCOyZr7J6VydlnX07PNbunF+Eclrc9ZyXMf6iIEI6B+RtPits3fJ+7cM7gIsTWM1tKw8fvfehfYLAGHsi8cUE4Gg89qvFhXDxhiZSdRVvn/JqV6jTWfxyBa+NJ9Q7GHYee+0EiUgz8THDX7tiNcJRCmB06nidlX1JZNCvsp+7p13h7CCeR49uw4gypSzrfCFGc8b/vexJsIj/31HqkTAEBKzeE6jGStzOP9Vz3R7AefXMdsjVNexuWLavlpXO60hAcVX+nuebiNaQSQ1yQ7ZVMQt+1G8J6aWp6nlFrTcQ+yP/xfs1/r61/Wn8dlvZSEXRoTQep2FJH8VXj1o5dnIjMB1f7/avVD7CgcFAk=";
			var keyIOS		:String = 	"QzrrlCUrLe+aK0OzFRgJykGDBB7yVVqLA+7+FTh+i+Ht6BcKSm57d/MDoQRVEVxdC8arOP8mhzVL+aBgQTt6PQLa6wZF3MnmS3suBDTaYtmNZMUeyCW8iD1m4m95wR94gWPsX4Vs/tD2bJc8m8h33R3qYkrojJbqYv4MxfAh8wxTYWx0ZWRfX3UeRw4FjSiiMZL4VqT8TAixB5kyAzQxn7EnKZit2BP7eIEJm2cvE7Elwh24pbzlIqLdMUCruds/Qxi+t6lDLfQPN9zRn1Lo+1XYnCna8Ky8teuPcaK3Q+APvUOoFa0YYo/hcTHIGI0x09VktCCOyZr7J6VydlnX07PNbunF+Eclrc9ZyXMf6iIEI6B+RtPits3fJ+7cM7gIsTWM1tKw8fvfehfYLAGHsi8cUE4Gg89qvFhXDxhiZSdRVvn/JqV6jTWfxyBa+NJ9Q7GHYee+0EiUgz8THDX7tiNcJRCmB06nidlX1JZNCvsp+7p13h7CCeR49uw4gypSzrfCFGc8b/vexJsIj/31HqkTAEBKzeE6jGStzOP9Vz3R7AefXMdsjVNexuWLavlpXO60hAcVX+nuebiNaQSQ1yQ7ZVMQt+1G8J6aWp6nlFrTcQ+yP/xfs1/r61/Wn8dlvZSEXRoTQep2FJH8VXj1o5dnIjMB1f7/avVD7CgcFAk=";
			
			_ex = new MyAR(keyAndroid, keyIOS, true);
			_ex.addEventListener(MyAREvent.STATUS, onArStatus);
			_ex.addEventListener(MyAREvent.COMMUNICATION, onCommunication);
			_ex.addEventListener(MyAREvent.COMPASS_ACCURACY_CHANGED, onCompassAccuracyChanged);
			
			C.log("isSupported = " + _ex.isSupported);
			
			// -------------------------
			
			var btn1:MySprite = createBtn("startAR");
			btn1.addEventListener(MouseEvent.CLICK, startAR);
			_list.add(btn1);
			
			function startAR(e:MouseEvent):void
			{
				C.log("trying to startAR: " + _ex.startAR("samples/1_Client$Recognition_1_Image$On$Target/index.html", false, true, CameraPosition.DEFAULT, true));
			}
			
			// -------------------------
		}
		
		private function onArStatus(e:MyAREvent):void
		{
			C.log("onArStatus = " + e.param);
		}
		
		private function onCompassAccuracyChanged(e:MyAREvent):void
		{
			C.log("Compass Accuracy = " + e.param);
		}
		
		private function onCommunication(e:MyAREvent):void
		{
			C.log("msg from JS = " + e.param);
			
			// send a msg to JS
			_ex.callJavascript("javascript:msgFromFlash('param 1 from Flash!')");
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