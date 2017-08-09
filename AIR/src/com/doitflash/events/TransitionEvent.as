package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 4/21/2010 11:39 AM
	 */
	public class TransitionEvent extends Event
	{
		
		public static const COMPLETE:String = "onTransitionCompleted";
		public static const UPDATE:String = "onTransitionUpdated";
		
		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function TransitionEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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