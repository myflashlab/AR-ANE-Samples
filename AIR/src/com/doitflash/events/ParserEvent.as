package com.doitflash.events
{
	import flash.events.Event;
	
	public class ParserEvent extends Event
	{
		public static const HEAD_LOADED:String = "onHeadTagLoaded";
		public static const BODY_LOADED:String = "onBodyTagLoaded";
		public static const TITLE_LOADED:String = "onTitleLoaded";
		
		private var _param:*;
		
		public function ParserEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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