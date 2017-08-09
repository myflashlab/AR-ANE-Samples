package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * AlertEvent class shows all the events being dispatched within the Alert class.
	 * @author Hadi Tavakoli - 2/27/2010 6:43 PM
	 */
	public class AlertEvent extends Event
	{
		/**
		 * @private
		 */
		public static const FOOTER_LOADED:String = "alertFooterLoaded";
		
		/**
		 * Dispatches when the alert window is being resized.
		 */
		public static const RESIZE:String = "alertResizing";
		
		/**
		 * @private
		 * Dispatches when the alert window is being dragged.
		 */
		public static const DRAG:String = "alertDragging";
		
		/**
		 * Dispatches when the alert window is closed. (when the close button on the title bar is clicked)
		 */
		public static const CLOSE:String = "alertClose";
		
		/**
		 * Dispatches when the the "cancel" button is clicked.
		 */
		public static const CANCEL:String = "alertCancel";
		
		/**
		 * Dispatches when the the "approval" button is clicked.
		 */
		public static const APPROVE:String = "alertApprove";
		
		/**
		 * Dispatches when the the "reject" button is clicked.
		 */
		public static const REJECT:String = "alertReject";
		
		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function AlertEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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