package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * Wordpress Parser Events
	 * @author Hadi Tavakoli - 5/14/2012 8:58 AM
	 */
	public class WpEvent extends Event
	{
		public static const NETWORK_STATUS:String = "onNetworkStatus";
		
		public static const UPDATE_AVAILABLE:String = "onUpdateAvailable";
		public static const RECENT_POSTS:String = "onRecentPosts";
		public static const POST_CONTENT:String = "onPostContent";
		
		public static const SEARCH_RESULT:String = "onSearchResult";
		
		public static const SUBMIT_COMMENT:String = "onSubmitComment";
		
		
		public static const CACHE_GET_POST:String = "onCacheGetPost";
		
		private var _param:*;
		
		public function WpEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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