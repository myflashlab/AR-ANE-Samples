package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * PopupEvent class shows all the events being dispatched with the Popup class.
	 * @author Hadi Tavakoli
	 */
	public class PopupEvent extends Event
	{
		/**
		 * Dispatches when the popup window is being resized.
		 */
		public static const RESIZE:String = "popupResizing";
		
		/**
		 * @private
		 * Dispatches when the popup window is being dragged.
		 */
		public static const DRAG:String = "popupDragging";
		
		/**
		 * Dispatches when the popup window is closed.
		 */
		public static const CLOSE:String = "popupClose";
		
		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function PopupEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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