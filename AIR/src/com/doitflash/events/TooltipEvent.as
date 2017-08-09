package com.doitflash.events
{
	import flash.events.Event;
	
	public class TooltipEvent extends Event
	{
		/**
		 * @private
		 */
		public static const CONTENT_LOADED:String = "contentLoaded";
		
		private var _param:*;
		
		public function TooltipEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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