package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * Wordpress Parser Events
	 * @author Hadi Tavakoli - 5/14/2012 8:58 AM
	 */
	public class NetworkEvent extends Event
	{
		public static const NETWORK_STATUS:String = "onNetworkStatus";
		
		private var _param:*;
		
		public function NetworkEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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