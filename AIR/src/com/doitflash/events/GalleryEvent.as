package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * Gallery Events.
	 * @author Hadi Tavakoli - 6/19/2010 7:35 PM
	 */
	public class GalleryEvent extends Event
	{
		public static const READY:String = "onClassReady";
		public static const DEEP_LINKING:String = "onDeepLinking";
		
		
		
		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function GalleryEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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