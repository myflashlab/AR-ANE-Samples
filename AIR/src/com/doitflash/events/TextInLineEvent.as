package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 9/15/2010 8:01 PM
	 */
	public class TextInLineEvent extends Event
	{
		public static const MODULE_LOADED:String = "onModuleLoaded";
		public static const SIZE_CHANGED:String = "onTextSizeChanged";
		
		//public static const AVATAR_SCRIPT_TEXT_MODULE:String = "onTextModuleAvatarScript";
		public static const AVATAR_PLAY:String = "onAvatarPlay";
		public static const AVATAR_STOP:String = "onAvatarStop";
		public static const AVATAR_PAUSE:String = "onAvatarPause";
		
		public static const VIDEO_PLAY:String = "onVideoPlay";
		public static const VIDEO_PAUSE:String = "onVideoPause";
		public static const VIDEO_STOP:String = "onVideoStop";
		public static const VIDEO_SOUND_ON:String = "onVideoSoundOn";
		public static const VIDEO_SOUND_OFF:String = "onVideoSoundOff";
		public static const VIDEO_SCREEN:String = "onVideoScreen";
		public static const VIDEO_PROG:String = "onVideoProg";
		public static const VIDEO_FINISHED:String = "onVideoFinished";
		
		public static const BUTTON_CLICK:String = "onButtonClick";
		
		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function TextInLineEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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