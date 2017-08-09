package com.doitflash.events
{
	import flash.events.Event;
	
	public class MediatorEvent extends Event
	{
		
		
		private var _classList:Object;
		private var _dispatchName:String;
		private var _bytesLoaded:Number;
		private var _bytesTotal:Number;
		private var _param:*;
		
		public function MediatorEvent(type:String, classList:Object, dispatchName:String, bytesLoaded:Number=0, bytesTotal:Number=0, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			_param = data;
			_classList = classList;
			_dispatchName = dispatchName;
			_bytesLoaded = bytesLoaded;
			_bytesTotal = bytesTotal;
			super(type, bubbles, cancelable);
		}
		
		public function get classList():Object
		{
			return _classList;
		}
		
		public function get dispatchName():Object
		{
			return _dispatchName;
		}
		
		public function get bytesLoaded():Number
		{
			return _bytesLoaded;
		}
		
		public function get bytesTotal():Number
		{
			return _bytesTotal;
		}
		
		public function get param():*
		{
			return _param;
		}
	}
}