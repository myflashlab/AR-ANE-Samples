package com.doitflash.events
{
	import flash.events.Event;
	
	public class FileSaverEvent extends Event
	{
		public static const RESPOND:String = "onRespondAvailable";
		
		private var _param1:*;
		private var _param2:*;
		
		public function FileSaverEvent(type:String, data1:*=null, data2:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			_param1 = data1;
			_param2 = data2;
			super(type, bubbles, cancelable);
		}
		
		public function get paramURLVars():*
		{
			return _param1;
		}
		
		public function get paramOBJVars():*
		{
			return _param2;
		}
	}
}