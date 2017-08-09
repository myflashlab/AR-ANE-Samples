package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * Pager Events.
	 * @author Hadi Tavakoli - 7/1/2010 3:05 PM
	 */
	public class PagerEvent extends Event
	{
		public static const PAGING:String = "onPaging";
		
		
		
		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function PagerEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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