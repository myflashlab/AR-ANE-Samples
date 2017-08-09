package com.doitflash.events
{
	import flash.events.Event;
	
	public class RemoteEvent extends Event
	{
		public static const FAULT:String = "onFault";
		public static const CONNECTING:String = "onConnecting";
		public static const RESULT:String = "onResult";
		public static const RENAME:String = "onRename";
		public static const DELETE:String = "onDelete";
		public static const COPY:String = "onCopy";
		public static const CUT:String = "onCut";
		public static const PASTE:String = "onPaste";
		public static const EDIT:String = "onEdit";
		public static const NEW_FOLDER:String = "onNewFolder";
		public static const UPLOAD_COMPUTER:String = "onUploadFromComputer";
		public static const UPLOAD_REQUEST:String = "onUploadRequest";
		public static const UPLOAD_CANCEL:String = "onUploadCancel";
		public static const WINDOW_RESIZE:String = "onWindowResize";
		public static const FILE_INFO:String = "onFileInfo";
		public static const LOADING:String = "onLoading";
		
		private var _param:*;
		
		public function RemoteEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false):void
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