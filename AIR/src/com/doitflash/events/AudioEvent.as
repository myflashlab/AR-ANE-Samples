package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * VideoEvent class shows all the events being dispatched by the video player.
	 * @author Ali Tavakoli - 6/14/2010 10:33 PM
	 */
	public class AudioEvent extends Event
	{
		/**
		 * Dispatches when the sound thumbnail is completed.
		 */
		public static const TH_COMPLETED:String = "myThCompleted";
		
		/**
		 * Dispatches when the sound ID3 is ready.
		 */
		public static const ID3_READY:String = "myID3Ready";
		
		/**
		 * Dispatches when the sound loading is on progress.
		 */
		public static const SOUND_PROGRESS:String = "mySoundProgress";
		
		/**
		 * Dispatches when the sound loading is completed.
		 */
		public static const SOUND_COMPLETED:String = "mySoundCompleted";
		
		/**
		 * Dispatches when the sound is finished.
		 */
		public static const SOUND_FINISHED:String = "mySoundFinished";
		
		/**
		 * Dispatches if there's an IOError
		 */
		public static const SOUND_IO_ERROR:String = "mySoundIOError";
		
		/**
		 * Dispatches when the player buttons are ready.
		 */
		public static const BTNS_READY:String = "myBtnsReady";
		
		/**
		 * Dispatches when progress bar button is clicked.
		 */
		public static const PROG_CLICK:String = "myProgClick";
		
		/**
		 * Dispatches when one of the playlist items is clicked.
		 */
		public static const LIST_CLICK:String = "myListClick";
		
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
		 * Dispatches when full info button is clicked.
		 */
		public static const INFO_CLICK:String = "myInfoClick";
		
		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function AudioEvent(type:String, param:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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