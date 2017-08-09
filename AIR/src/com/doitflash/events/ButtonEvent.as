package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * ButtonEvent class shows all the events being dispatched with the Btn.
	 * @author Ali Tavakoli - 2/9/2010 11:23 AM
	 */
	public class ButtonEvent extends Event
	{
	// btn const
		/**
		 * Dispatches when the mouse is up.
		 */
		public static const MOUSE_UP:String = "myMouseUp";
		/**
		 * Dispatches when the button is clicked and release outside.
		 */
		public static const RELEASE_OUTSIDE:String = "myReleaseOutside";
		/**
		 * Dispatches when the button is pressed.
		 */
		public static const MOUSE_DOWN:String = "myMouseDown";
		/**
		 * Dispatches when the button is clicked.
		 */
		public static const CLICK:String = "myClick";
		/**
		 * Dispatches when the button is double clicked.
		 */
		public static const DOUBLE_CLICK:String = "myDoubleClick";
		/**
		 * Dispatches when the button is roll overed.
		 */
		public static const ROLL_OVER:String = "myRollOver";
		/**
		 * Dispatches when the button is roll outed.
		 */
		public static const ROLL_OUT:String = "myRollOut";
		/**
		 * Dispatches when the button is active.
		 */
		public static const ACTIVE:String = "myActive";
		/**
		 * Dispatches when the button is inactive.
		 */
		public static const INACTIVE:String = "myInactive";
		
		/**
		 * Dispatches when the class is removed from stage.
		 */
		public static const REMOVED_FROM_STAGE:String = "myRemovedFromStage";
		/**
		 * Dispatches when the class is added to stage.
		 */
		public static const ADDED_TO_STAGE:String = "myAddedToStage";
		
		public static const ITEM_OPEN:String = "onItemOpen";
		
		/**
		 * @private
		 */
		public static const SKIN_LOADED:String = "mySkinLoaded";
		
	// thumbnail const
		/**
		 * @private
		 */
		public static const SIZE_CHANGED:String = "mySizeChanged";
		
	// list const
		/**
		 * Dispatches when the thumbnail added as an item.
		 */
		public static const ADDED_ITEM:String = "myAddedItem";
		/**
		 * Dispatches when the thumbnail removed as an item.
		 */
		public static const REMOVED_ITEM:String = "myRemovedItem";
		
	// nav const
		/**
		 * Dispatches when the item is roll overed.
		 */
		public static const ITEM_OVER:String = "myItemOver";
		/**
		 * Dispatches when the item is roll outed.
		 */
		public static const ITEM_OUT:String = "myItemOut";
		/**
		 * Dispatches when the item is clicked.
		 */
		public static const ITEM_CLICK:String = "myItemClick";
		
		private var _item:*;
		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	item
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function ButtonEvent($type:String, $item:*=null, $param:*=null, $bubbles:Boolean=false, $cancelable:Boolean=false):void
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