package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 5/29/2010 11:35 AM
	 */
	public class XmlEditorEvent extends Event
	{
		public static const OPEN_NODE_CHILDREN:String = "onOpenNodeChildren";
		public static const CLOSE_NODE_CHILDREN:String = "onCloseNodeChildren";
		public static const OPEN_NODE_DETAILS:String = "onOpenNodeDetails";
		public static const CLOSE_NODE_DETAILS:String = "onCloseNodeDetails";
		public static const CLOSE_WINDOW:String = "onCloseWindow";
		public static const NODE_DRAG_START:String = "onNodeDragStart";
		public static const NODE_DRAG_END:String = "onNodeDragEnd";
		public static const NODE_SWITCH:String = "onNodeSwitch";
		public static const NODE_RAW_EDIT:String = "onNodeRawEdit";
		public static const NODE_ATT_EDIT:String = "onNodeAttributesEdit";
		public static const NODE_VALUE_EDIT:String = "onNodeValueEdit";
		public static const REFRESH_TREE:String = "onRefreshTree";
		public static const HIGHLIGHT_NODE:String = "onHighlightNode";
		
		public static const LEVEL_SCROLLING:String = "onLevelScrolling";
		public static const LEVEL_SCROLL_STARTED:String = "onLevelScrollingStarted";
		public static const LEVEL_SCROLL_END:String = "onLevelScrollingEnded";
		
		public static const BUTTON_CLICK:String = "onButtonClicked";
		public static const VIEW_MODE_CHANGED:String = "onViewModeChanged";
		
		public static const OPEN:String = "onOpen";
		
		private var _param:*;
		
		public function XmlEditorEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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