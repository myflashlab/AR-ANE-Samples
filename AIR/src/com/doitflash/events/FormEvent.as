package com.doitflash.events
{
	import flash.events.Event;
	
	public class FormEvent extends Event
	{
		/**
		 * @private
		 */
		public static const SHOW_ATTACHMENTS:String = "showAttachments";
		
		/**
		 * @private
		 */
		public static const TOO_LARGE:String = "fileSizeIsTooLarge";
		
		/**
		 * @private
		 */
		public static const TOO_MANY:String = "thereAreTooManyFiles";
		
		/**
		 * @private
		 */
		public static const SUBMIT:String = "submitButton";
		
		/**
		 * @private
		 */
		public static const RESET:String = "resetButton";
		
		/**
		 * @private
		 */
		public static const SET_INDEX:String = "setItemIndex";
		
		public static const SERVER_RESPOND:String = "serverRespond";
		
		public static const RADIO_CLICK:String = "onRadioClick";
		public static const UPDATE_SKIN:String = "onUpdateSkin";
		
		private var _param:*;
		
		public function FormEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			_param = data;
			super(type, bubbles, cancelable);
		}
		
		
		public function get param():*
		{
			return _param;
		}
	}
}