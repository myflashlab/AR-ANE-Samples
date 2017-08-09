package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * This class indicates the events of a file while its loading
	 * @author Ali Tavakoli - 8/4/2011 4:45 PM
	 */
	public class FileLoaderEvent extends Event
	{
	// btn const
		/**
		 * Dispatches when the file loading is in progress.
		 */
		public static const PROGRESS:String = "progress";
		public static const ERROR:String = "error";
		public static const COMPLETE:String = "complete";
		public static const ENDED:String = "ended";
		
		
		private var _item:*;
		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	item
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function FileLoaderEvent($type:String, $item:*=null, $param:*=null, $bubbles:Boolean=false, $cancelable:Boolean=false):void
		{
			_item = $item;
			_param = $param;
			super($type, $bubbles, $cancelable);
		}
		
		/**
		 * indicates the target item.
		 */
		public function get item():*
		{
			return _item;
		}
		
		public function get param():*
		{
			return _param;
		}
	}
}