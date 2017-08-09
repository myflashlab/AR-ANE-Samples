package com.doitflash.events
{
	import flash.events.Event;
	
	public class TextFieldEvent extends Event
	{
		public static const MOUSE_SCROLLER:String = "mouseScrollerType";
		public static const REGULAR_SCROLLER:String = "regularScrollerType";
		
		private var _param:*;
		
		public function TextFieldEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			_param = data;
			super(type, bubbles, cancelable);
		}
		
		public function get param():*
		{
			return _param;
		}
	}
}