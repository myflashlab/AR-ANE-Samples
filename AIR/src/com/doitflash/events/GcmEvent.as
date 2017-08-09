package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * 
	 * @author Hadi Tavakoli - 11/17/2012 1:57 PM
	 */
	public class GcmEvent extends Event
	{
		public static const ERROR:String = "onGcmError";
		public static const MESSAGE:String = "onMessage";
		public static const REGISTERED:String = "onRegistered";
		public static const UNREGISTERED:String = "onUnregistered";
		public static const RECOVERABL_EERROR:String = "onRecoverableError";
		public static const REGISTRATION_ERROR:String = "onRegistrationError";
		
		public static const RESOURCE_ERROR:String = "onResourceError";
		
		private var _param:*;
		
		public function GcmEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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