package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * VideoEvent class shows all the events being dispatched by the video player.
	 * @author Ali Tavakoli - 6/14/2010 10:33 PM
	 */
	public class VideoEvent extends Event
	{
		/**
		 * Dispatches when the video meta data is ready.
		 */
		public static const META_DATA_READY:String = "myMetaDataReady";
		
		/**
		 * Dispatches when video display is updating.
		 */
		public static const UPDATE_DISPLAY:String = "myUpdateDisplay";
		
		/**
		 * Dispatches when the progress bar is ready.
		 */
		public static const PROG_BAR_READY:String = "myProgBarReady";
		
		/**
		 * Dispatches when the player buttons are ready.
		 */
		public static const BTNS_READY:String = "myBtnsReady";
		
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
		 * Dispatches when sound button is clicked.
		 */
		public static const SOUND_CLICK:String = "mySoundClick";
		
		/**
		 * Dispatches when full screen button is clicked.
		 */
		public static const SCREEN_CLICK:String = "myScreenClick";
		
		/**
		 * Dispatches when full info button is clicked.
		 */
		public static const INFO_CLICK:String = "myInfoClick";
		
		/**
		 * Dispatches when the video is finished.
		 */
		public static const VIDEO_FINISHED:String = "myVideoFinished";
		
////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////// Skin
////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Dispatches when one of the controller button skins is loaded.
		 */
		public static const CONTROLLER_SKIN_LOADED:String = "controllerSkinLoaded";
		
		/**
		 * Dispatches when sound on button is clicked.
		 */
		public static const SOUND_ON_CLICK:String = "soundOnClick";
		
		/**
		 * Dispatches when sound off button is clicked.
		 */
		public static const SOUND_OFF_CLICK:String = "soundOffClick";
		
		/**
		 * Dispatches when progress bar is clicked.
		 */
		public static const PROG_CLICK:String = "progClick";
		
		/**
		 * Dispatches when controller size changes.
		 */
		public static const RESIZE:String = "resize";
		
		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function VideoEvent(type:String, param:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			_param = param;
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