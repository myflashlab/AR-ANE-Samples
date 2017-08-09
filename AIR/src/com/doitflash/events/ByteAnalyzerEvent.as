package com.doitflash.events
{
	import flash.events.Event;
	
	public class ByteAnalyzerEvent extends Event
	{
		public static const PARS_ERROR:String = "parsError";
		public static const PARS_COMPLETE:String = "parsComplete";
		
		private var _message:String;
		private var _property:Object;
		
		public function ByteAnalyzerEvent(type:String, $message:String=null, $property:Object=null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			_message = $message;
			_property = $property;
			super(type, bubbles, cancelable);
		}
		
		public function get message():String
		{
			return _message;
		}
		
		public function get property():Object
		{
			return _property;
		}
	}
}