package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * Twitter application events
	 * @author Hadi Tavakoli - 5/29/2010 11:35 AM
	 */
	public class TwitterEvent extends Event
	{
		public static const READY:String = "onClassReady";
		
		/**
		 * @private
		 */
		public static const UPDATE:String = "updateData";
		public static const ERROR:String = "errorFromTwitter";
		
		private var _param:*;
		
		public function TwitterEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			_param = data;
			super(type, bubbles, cancelable);
		}
		
		/**
		 * @private
		 */
		public function get param():*
		{
			return _param;
		}
	}
	
}