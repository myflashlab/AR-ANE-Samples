package
{
import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;
import com.doitflash.text.modules.MySprite;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

/**
 * ...
 * @author Hadi Tavakoli - 8/6/17 10:42 AM
 */
public class Item extends MySprite
{
	private var _sample:String;
	private var _txt:TextField;
	
	private var _overColor:uint = 0xcdebfa;
	private var _outColor:uint = 0xEEEEEE;
	
	public function Item()
	{
		this.addEventListener(Event.ADDED_TO_STAGE, onStageAdded);
		
		_bgColor = _outColor;
		_bgAlpha = 1;
		drawBg();
		
		this.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		this.addEventListener(MouseEvent.MOUSE_OUT, onOut);
	}
	
	private function onStageRemoved(e:Event):void
	{
		this.removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemoved);
	}
	
	private function onStageAdded(e:Event):void
	{
		this.removeEventListener(Event.ADDED_TO_STAGE, onStageAdded);
		this.addEventListener(Event.REMOVED_FROM_STAGE, onStageRemoved);
		
		_txt = new TextField();
		_txt.antiAliasType = AntiAliasType.ADVANCED;
		_txt.autoSize = TextFieldAutoSize.LEFT;
		_txt.selectable = false;
		_txt.defaultTextFormat = new TextFormat("Arimo", 12, 0x666666, null, null, null, null, null, TextFormatAlign.CENTER);
		_txt.scaleX = _txt.scaleY = DeviceInfo.dpiScaleMultiplier;
		
		var regExp:RegExp = /\"?[\dx]*_(\d?[A-Z]+)_\d_([A-Z-\d&\(\)]+)\"?,?/ig;
		var obj:Object = regExp.exec(_sample);
		
		_txt.htmlText = "<font color='#333333'><b>(" + obj[1] + ")</b></font> " + obj[2];
		_txt.x = 10;
		_txt.y = _height - _txt.height >> 1;
		
		addChild(_txt);
	}
	
	private function onOver(e:MouseEvent):void
	{
		_bgColor = _overColor;
		_bgAlpha = 1;
		drawBg();
	}
	
	private function onOut(e:MouseEvent):void
	{
		_bgColor = _outColor;
		_bgAlpha = 1;
		drawBg();
	}
		
	public function set sample(a:String):void
	{
		_sample = a;
	}
	
	public  function get sample():String
	{
		return _sample;
	}
}
}
