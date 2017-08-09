package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * 
	 * @author Hadi Tavakoli - 1/21/2013 4:33 PM
	 */
	public class AppsApiEvent extends Event
	{
		public static const CONNECTION_SUCCESS:String = "onConnectionSuccess";
		public static const CONNECTION_FAILURE:String = "onConnectionFailure";
		
		private var _param:*;
		
		public function AppsApiEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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