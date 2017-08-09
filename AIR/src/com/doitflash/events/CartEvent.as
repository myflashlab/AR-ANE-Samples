package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 8/18/2010 8:03 PM
	 */
	public class CartEvent extends Event
	{
		
		public static const CORE_READY:String = "cartCoreReady";
		public static const CART_UPDATE:String = "cartUpdate";
		
		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function CartEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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