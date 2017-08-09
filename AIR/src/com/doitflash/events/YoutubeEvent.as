package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * VideoEvent class shows all the events being dispatched by the video player.
	 * @author Ali Tavakoli - 6/14/2010 10:33 PM
	 */
	public class YoutubeEvent extends Event
	{
		/**
		 * Dispatches when player is initialized.
		 */
		public static const INIT:String = "myInit";
		
		/**
		 * Dispatches when player is ready.
		 */
		public static const READY:String = "myReady";
		
		/**
		 * Dispatches when player gives an error.
		 */
		public static const ERROR:String = "myError";
		
		/**
		 * Dispatches when player state changes.
		 */
		public static const STATE_CHANGE:String = "myStateChange";
		
		/**
		 * Dispatches when playback quality changes.
		 */
		public static const PLAYBACK_QUALITY_CHANGE:String = "myPlaybackQualityChange";
		
		/**
		 * Dispatches when play button is clicked.
		 */
		public static const PLAY_CLICK:String = "myPlayClick";
		
		/**
		 * Dispatches when pause button is clicked.
		 */
		public static const PAUSE_CLICK:String = "myPauseClick";
		
		/**
		 * Dispatches when stop button is clicked.
		 */
		public static const STOP_CLICK:String = "myStopClick";
		
		/**
		 * Dispatches when video button is clicked.
		 */
		public static const VIDEO_CLICK:String = "myVideoClick";
		
		
		private var _object:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function YoutubeEvent(type:String, object:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			_object = object;
			super(type, bubbles, cancelable);
		}
		
		/**
		 * @private
		 */
		public function get object():*
		{
			return _object;
		}
	}
}