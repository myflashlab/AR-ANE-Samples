package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * 
	 * @author Hadi Tavakoli - 3/21/2010 3:52 PM
	 */
	public class MenuEvent extends Event
	{
		/**
		 * @private
		 */
		public static const LINK:String = "onLinkClicked";
		
		public static const MENU_READY:String = "onMenuReady";
		public static const RESIZE:String = "onMenuResized";
		public static const OPEN:String = "openMenu";
		public static const CLOSE:String = "closeMenu";
		public static const SELECTED:String = "onItemSelected";
		
		private var _param:*;
		private var _link:String;
		private var _title:String;
		private var _content:String;
		
		/**
		 * 
		 */
		public function MenuEvent(type:String, $link:String=null, data:*=null, $title:String=null, $content:String=null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			_param = data;
			_link = $link;
			_title = $title;
			_content = $content;
			super(type, bubbles, cancelable);
		}
		
		/**
		 * @private
		 */
		public function get param():*
		{
			return _param;
		}
		
		/**
		 * @private
		 */
		public function get link():*
		{
			return _link;
		}
		
		/**
		 * @private
		 */
		public function get title():*
		{
			return _title;
		}
		
		/**
		 * @private
		 */
		public function get content():*
		{
			return _content;
		}
	}
}