package com.doitflash.starling.utils.scroller
{
	import flash.events.EventDispatcher
	import flash.events.Event;
	import flash.geom.Point;
	
	import flash.utils.getTimer;
	//import flash.events.TimerEvent;
	//import flash.utils.Timer;
	
	import com.greensock.plugins.*;
	import com.greensock.*; 
	import com.greensock.events.*;
	import com.greensock.easing.*;
	//import com.greensock.easing.EaseLookup;
	
	import com.doitflash.consts.Orientation;
	import com.doitflash.events.ScrollEvent;
	import com.doitflash.consts.Easing;
	
	
	/**
	 * Scroller is an abstract class to scroll your contents by touching the screen and moving your finger around, specially useful in 3D environment and Starling projects.
	 * 
	 * <b>Copyright 2012-2013, MyAppSnippet. All rights reserved.</b>
	 * For seeing the scroll preview and sample files visit <a href="http://myappsnippet.com/">http://www.myappsnippet.com/</a>
	 * 
	 * @see com.doitflash.events.ScrollEvent
	 * @see com.doitflash.consts.Orientation
	 * @see com.doitflash.consts.Easing
	 * 
	 * @author Ali Tavakoli - 7/30/2012 11:02 AM
	 * modified - 10/25/2012 10:49 AM
	 * @version 1.0
	 * 
	 * @example The following example shows you how to create a simple Scroller and make it work on your Starling project.
	 * 
	 * <listing version="3.0">
	 * import com.doitflash.consts.Orientation;
	 * import com.doitflash.consts.Easing;
	 * import com.doitflash.events.ScrollEvent;
	 * import com.doitflash.starling.utils.scroller.Scroller;
	 * 
	 * import starling.events.TouchEvent;
	 * import starling.events.TouchPhase;
	 * import starling.events.Touch;
	 * import starling.extensions.ClippedSprite;
	 * import flash.geom.Point;
	 * 
	 * 
	 * var _content:ClippedSprite = new ClippedSprite(); // the content you want to scroll
	 * _content.clipRect = new Rectangle(0, 0, 500, 500); // set the space that you want your content to be visible at, set its mask actually
	 * _content.addEventListener(TouchEvent.TOUCH, onTouch);
	 * this.addChild(_content);
	 * 
	 * var _scroll:Scroller = new Scroller();
	 * //_scroll.addEventListener(ScrollEvent.TOUCH_TWEEN_UPDATE, onTouchTweenUpdate); // will be triggered when you have released the content but the scroll animation is still running
	 * //_scroll.addEventListener(ScrollEvent.TOUCH_TWEEN_COMPLETE, onTouchTweenComplete); // will be triggered when you have released the content and the scroll animation is also complete
	 * 
	 * //_scroll.addEventListener(ScrollEvent.MOUSE_DOWN, onTouchDown); // listens when ever you touch the screen
	 * //_scroll.addEventListener(ScrollEvent.MOUSE_MOVE, onTouchMove); // listens when ever you move the content
	 * //_scroll.addEventListener(ScrollEvent.MOUSE_UP, onTouchUp); // listens when ever you release the content
	 * 
	 * 
	 * _scroll.boundWidth = 500; // set boundWidth according to the mask width
	 * _scroll.boundHeight = 500; // set boundHeight according to the mask height
	 * _scroll.content = _content; // you MUST set scroller content before doing anything else
	 * 
	 * //_scroll.yPerc = 50; // set scroll y position manually
	 * //_scroll.xPerc = 50; // set scroll x position manually
	 * _scroll.orientation = Orientation.VERTICAL; // accepted values: Orientation.AUTO, Orientation.VERTICAL, Orientation.HORIZONTAL
	 * _scroll.easeType = Easing.Expo_easeOut;
	 * _scroll.duration = .5;
	 * _scroll.holdArea = 10;
	 * _scroll.dpiScaleMultiplier = 2; // if your using the scroller in a mobile app project then provide the device DPI to the scroller for a more exact scrolling
	 * _scroll.isStickTouch = false;
	 * 
	 * 
	 * // you call this function for example, to start scrolling
	 * private function onTouch(e:TouchEvent):void
	 * {
	 * 		var touch:Touch = e.getTouch(stage);
	 * 		var pos:Point = touch.getLocation(stage);
	 * 		
	 * 		if (touch.phase == TouchPhase.BEGAN)
	 * 		{
	 * 			_scroll.startScroll(pos); // on touch begin
	 * 		}
	 * 		else if (touch.phase == TouchPhase.MOVED)
	 * 		{
	 * 			_scroll.startScroll(pos); // on touch move
	 * 			//trace(_scroll.isHoldAreaDone); // to see that we have got out of the hold area or not
	 * 		}
	 * 		else if (touch.phase == TouchPhase.ENDED)
	 * 		{
	 * 			_scroll.fling(); // on touch ended
	 * 		}
	 * }
	 * 
	 * //_scroll.computeYPerc(true); // if the size of your content has been changed, you can call this function to calculate the new percentage for you
	 * //_scroll.computeXPerc(true); // if the size of your content has been changed, you can call this function to calculate the new percentage for you
	 * 
	 * 
	 * 
	 * 
	 * // DUPLICATING A SCROLLER: how to export your scroller settings for an other scroller
	 * //_scroll2.content = _content2; // you just need to set the second scroller content and import other settings from the first one
	 * //_scroll2.importProp = _scroll.exportProp; // now import the first scroller properties to the second scroller
	 * 
	 * </listing>
	 */
	public class Scroller extends EventDispatcher
	{
// ----------------------------------------------------------------------------------------------------------------------- vars
		
		TweenPlugin.activate([ThrowPropsPlugin]);
		
		/**
		 * @private
		 * set the object to save the setters value inside it self
		 */
		protected var _propSaver:Object = new Object();
		
		// input vars
		private var _content:*;
		private var _boundWidth:Number = 100;
		private var _boundHeight:Number = 100;
		
		private var _orientation:String = Orientation.AUTO;
		private var _easeType:String = Easing.Expo_easeOut;
		private var _duration:Number = .5;
		
		protected var _holdArea:Number = 10;
		protected var _isStickTouch:Boolean = false;
		
		private var _yPerc:Number = 0;
		private var _xPerc:Number = 0;
		
		private var _dpiScaleMultiplier:Number = 1;
		
		
		// needed vars
		private var _time1:uint, _time2:uint;
		private var _y1:Number, _y2:Number, _yOverlap:Number, _yOffset:Number;
		private var _x1:Number, _x2:Number, _xOverlap:Number, _xOffset:Number;
		
		protected var _easeTypeFunc:* = EaseLookup.find(_easeType);
		
		private var _touchPoint:Point;
		private var _holdAreaPoint:Point;
		protected var _isHoldAreaDone:Boolean = false; // if true, shows that we have got out of the hold area
		
		private var _isScrollBegin:Boolean = true;
		
		private var _xVelocity:Number = 0;
		private var _yVelocity:Number = 0;
		
		
		// consts
		//private static const SCROLL_MODE:String = "scrollMode";
		//private static const FLING_MODE:String = "flingMode";
		//private const DEFAULT_DURATION:Number = 250;
		
		//private var _mode:String = Scroller.SCROLL_MODE;
		//private var ViscousFluidScale:Number = 8.0;
		//private var ViscousFluidNormalize:Number = 1.0;
		//private var _isFinished:Boolean = true;
		//private var _durationReciprocal:Number;
		//private var _startTime:Number;
		
		// computeScrollOffset, viscousFluid, abortAnimation, extendDuration, timePassed, setFinalX, setFinalY
		// getDuration,    getCurrX, getCurrY,    getCurrVelocity,    getStartX, getStartY, getFinalX, getFinalY
		
// ----------------------------------------------------------------------------------------------------------------------- constructor func
		
		public function Scroller():void
		{
			
		}
		
// ----------------------------------------------------------------------------------------------------------------------- funcs
		
		
		
// ----------------------------------------------------------------------------------------------------------------------- Methods
		
		public function startScroll($point:Point):void
		{
			_touchPoint = $point;
			
			// if you're going to use the Scroller in a mobile app project... each mobile device has its own DPI which means that they understand pixels in different sizes...
			// which in real world if you try to scroll, because you're moving your fingers slightly but the device pixels are smaller or bigger in size, then the scrolling won't happen exactly accroding to your fingers movements... so we need to take DPI into an account
			// so user need to tell us the DPI amount '_dpiScaleMultiplier'. then we use it here when we get the pixels touch points from the user and change the pixels sizes abstractly in our calculations
			_touchPoint.x = (_touchPoint.x == 0) ? _touchPoint.x : _touchPoint.x / _dpiScaleMultiplier;
			_touchPoint.y = (_touchPoint.y == 0) ? _touchPoint.y : _touchPoint.y / _dpiScaleMultiplier;
			
			
			if (_isScrollBegin) // _isScrollBegin is true when user scrolls for the first time and each time he calls fling()
			{
				TweenLite.killTweensOf(_content);
				_holdAreaPoint = _touchPoint;
				_isHoldAreaDone = false; // so that on TouchPhase.MOVED check the _holdArea
				
				// it doesn't matter what's the _orientation mode, we don't do anything especial here, we just set the variables
				initScrollV();
				initScrollH();
				
				function initScrollV():void
				{
					_y1 = _y2 = _content.y;
					_yOffset = _touchPoint.y - _content.y;
					_yOverlap = Math.max(0, _content.height - _boundHeight);
					_time1 = _time2 = getTimer();
				}
				
				function initScrollH():void
				{
					_x1 = _x2 = _content.x;
					_xOffset = _touchPoint.x - _content.x;
					_xOverlap = Math.max(0, _content.width - _boundWidth);
					_time1 = _time2 = getTimer();
				}
				
				_isScrollBegin = false; // set it to false, so the next time that user calls this function on TouchPhase.MOVED, function will do the rest
				this.dispatchEvent(new ScrollEvent(ScrollEvent.MOUSE_DOWN));
				return;
			}
			
			// the above has happened for the first time on TouchPhase.BEGAN, so on TouchPhase.MOVED _isScrollBegin is false and won't do the above if statment and do the following
			var diff:Number;
			
			if (_orientation == Orientation.VERTICAL) 
			{
				if (!_isHoldAreaDone)
				{
					diff = _holdAreaPoint.y - _touchPoint.y;
					diff = Math.sqrt(Math.pow(diff, 2)); // set to always get positive number
					if (diff < _holdArea) return; // if user is moving around and still didn't move so much to get out of the _holdArea boundaries, don't do the scroll animation
				}
				
				scrollVSetting();
			}
			else if (_orientation == Orientation.HORIZONTAL) 
			{
				if (!_isHoldAreaDone)
				{
					diff = _holdAreaPoint.x - _touchPoint.x;
					diff = Math.sqrt(Math.pow(diff, 2)); // set to always get positive number
					if (diff < _holdArea) return; // if user is moving around and still didn't move so much to get out of the _holdArea boundaries, don't do the scroll animation
				}
				
				scrollHSetting();
			}
			else // if it was AUTO
			{
				if (!_isHoldAreaDone)
				{
					// set diff 2 time according to x and y, so that if user moves in any direction, the diff amount will be added 
					diff = _holdAreaPoint.y - _touchPoint.y;
					diff += _holdAreaPoint.x - _touchPoint.x;
					diff = Math.sqrt(Math.pow(diff, 2)); // set to always get positive number
					if (diff < _holdArea) return; // if user is moving around and still didn't move so much to get out of the _holdArea boundaries, don't do the scroll animation
				}
				
				scrollVSetting();
				scrollHSetting();
			}
			
			function scrollVSetting():void
			{
				//if maskContent's position exceeds the bounds, make it drag only half as far with each mouse movement (like iPhone/iPad behavior)
				var y:Number = _touchPoint.y - _yOffset;
				if (y > 0) 
				{
					if (_isStickTouch) _content.y = 0;
					else _content.y = ((y + 0) * 0.5);
				}
				else if (y < 0 - _yOverlap) 
				{
					if (_isStickTouch) _content.y = (- _yOverlap);
					else _content.y = ((y + 0 - _yOverlap) * 0.5);
				}
				else 
				{
					_content.y = y;
				}
				
				//if the frame rate is too high, we won't be able to track the velocity as well, so only update the values 20 times per second
				var t:uint = getTimer();
				
				if (t - _time2 > 50)
				{
					_y2 = _y1;
					_time2 = _time1;
					_y1 = _content.y;
					_time1 = t;
				}
				
				computeYPerc(); // to analyze _yPerc
			}
			
			function scrollHSetting():void
			{
				//if maskContent's position exceeds the bounds, make it drag only half as far with each mouse movement (like iPhone/iPad behavior)
				var x:Number = _touchPoint.x - _xOffset;
				if (x > 0) 
				{
					if (_isStickTouch) _content.x = 0;
					else _content.x = ((x + 0) * 0.5);
				}
				else if (x < 0 - _xOverlap) 
				{
					if (_isStickTouch) _content.x = (- _xOverlap);
					else _content.x = ((x + 0 - _xOverlap) * 0.5);
				}
				else 
				{
					_content.x = x;
				}
				
				//if the frame rate is too high, we won't be able to track the velocity as well, so only update the values 20 times per second
				var t:uint = getTimer();
				if (t - _time2 > 50)
				{
					_x2 = _x1;
					_time2 = _time1;
					_x1 = _content.x;
					_time1 = t;
				}
				
				computeXPerc(); // to analyze _xPerc
			}
			
			_isHoldAreaDone = true; // so that it won't check _holdArea next time that we move if we got back to its boundaries, because we don't like it to stop our scroll animation unless we release our touch and touch to move again
			this.dispatchEvent(new ScrollEvent(ScrollEvent.MOUSE_MOVE));
		}
		
		public function fling():void
		{
			// user usually calls this function on TouchPhase.ENDED, so we dispatch MOUSE_UP here
			this.dispatchEvent(new ScrollEvent(ScrollEvent.MOUSE_UP));
			
			
			var time:Number = (getTimer() - _time2) / 1000;
			if (time <= 0.020) time = 0.020;
			_yVelocity = (_content.y - _y2) / time;
			_xVelocity = (_content.x - _x2) / time;
			
			// set animation tolerance amount accroding to _isStickTouch is true or false
			var tolerance:Object = { minDuration:(_isStickTouch) ? 0: .3, 
									 overShoot:(_isStickTouch) ? 0: 1 };
			
			ThrowPropsPlugin.to(_content, {throwProps:{
								y:{velocity:_yVelocity, max:0, min:0 - _yOverlap, resistance:300},
								x:{velocity:_xVelocity, max:0, min:0 - _xOverlap, resistance:300}
								}, onUpdate:onTweenUpdate, onComplete:onTweenComplete, ease:_easeTypeFunc
								}, 10, tolerance.minDuration, tolerance.overShoot);
			
			_isScrollBegin = true; // so that on the next scroll, scroller sets the touch begin settings in startScroll()
		}
		private function onTweenUpdate($computePerc:Boolean = true):void
		{
			if ($computePerc)
			{
				computeYPerc();
				computeXPerc();
			}
			
			this.dispatchEvent(new ScrollEvent(ScrollEvent.TOUCH_TWEEN_UPDATE));
		}
		private function onTweenComplete($computePerc:Boolean = true):void
		{
			if ($computePerc)
			{
				computeYPerc();
				computeXPerc();
			}
			
			this.dispatchEvent(new ScrollEvent(ScrollEvent.TOUCH_TWEEN_COMPLETE));
		}
		
		
		
		
		public function computeYPerc($manualPerc:Boolean = false):void
		{
			if (!_content) return;
			if (_orientation == Orientation.HORIZONTAL) return; // if _orientation is not vertical or auto, just return
			if (_content.height <= _boundHeight) return; // if content is smaller than the boundaries, there's no reason to set any percent
			
			
			if ($manualPerc) // change CONTENT position according to percent
			{
				var yLoc:Number = (_yPerc * (_content.height - _boundHeight)) / 100; // Periodic Table-> _yPerc / 100 = ? / _content.height
				TweenMax.to(_content, _duration, { bezier:[ { y:_content.y }, { y: - yLoc } ], onUpdate:onTweenUpdate, onUpdateParams:[false], onComplete:onTweenComplete, onCompleteParams:[false], ease:_easeTypeFunc } );
				$manualPerc = false;
			}
			else  // change PERCENT according to content position
			{
				var diff:Number = _content.height - _boundHeight; // the different amount between the 2 heights
				
				var currY: Number = Math.sqrt(Math.pow(_content.y, 2)); // set to always get positive number
				if (_content.y > 0) currY = 0; // if touch scroll was scratching at start point, set currY to 0 obviously
				else if ( (- _content.y) > diff) currY = diff; // if it was scratching at end point, set currY to diff obviously
				
				_yPerc = currY * 100 / diff; // Periodic Table-> diff / 100 = currY / ?
			}
		}
		
		public function computeXPerc($manualPerc:Boolean = false):void
		{
			if (!_content) return;
			if (_orientation == Orientation.VERTICAL) return; // if _orientation is not horizontal or auto, just return
			if (_content.width <= _boundWidth) return; // if content is smaller than the boundaries, there's no reason to set any percent
			
			if ($manualPerc)
			{
				var xLoc:Number = (_xPerc * (_content.width - _boundWidth)) / 100; // Periodic Table-> _xPerc / 100 = ? / _content.width
				TweenMax.to(_content, _duration, { bezier:[ { x:_content.x }, { x: - xLoc } ], ease:_easeTypeFunc } );
				$manualPerc = false;
			}
			else
			{
				var diff:Number = _content.width - _boundWidth; // the different amount between the 2 widths
				
				var currX: Number = Math.sqrt(Math.pow(_content.x, 2)); // set to always get positive number
				if (_content.x > 0) currX = 0; // if touch scroll was scratching at start point, set currX to 0 obviously
				else if ( (- _content.x) > diff) currX = diff; // if it was scratching at end point, set currX to diff obviously
				
				_xPerc = currX * 100 / diff; // Periodic Table-> diff / 100 = currX / ?
			}
		}
		
// ----------------------------------------------------------------------------------------------------------------------- Properties
		
		/**
		 * indicates the scroller width.
		 * @default 100
		 */
		public function get boundWidth():Number
		{
			return _boundWidth;
		}
		/**
		 * @private
		 */
		public function set boundWidth(a:Number):void
		{
			if(a != _boundWidth)
			{
				_boundWidth = a;
				_propSaver.boundWidth = _boundWidth; // pass the new value to the value of the object property
				
				computeXPerc(true);
			}
		}
		
		/**
		 * indicates the scroller height.
		 * @default 100
		 */
		public function get boundHeight():Number
		{
			return _boundHeight;
		}
		/**
		 * @private
		 */
		public function set boundHeight(a:Number):void
		{
			if(a != _boundHeight)
			{
				_boundHeight = a;
				_propSaver.boundHeight = _boundHeight; // pass the new value to the value of the object property
				
				computeYPerc(true);
			}
		}
		
		/**
		 * indicates the type of orientation.
		 * @default Orientation.AUTO
		 * @see Orientation
		 */
		public function get orientation():String
		{
			return _orientation;
		}
		/**
		 * @private
		 */
		public function set orientation(a:String):void
		{
			if(a != _orientation)
			{
				_orientation = a;
				_propSaver.orientation = _orientation; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the type of scrollbar ease.
		 * @default Easing.Expo_easeOut
		 * @see Easing
		 */
		public function get easeType():String
		{
			return _easeType;
		}
		/**
		 * @private
		 */
		public function set easeType(a:String):void
		{
			if(a != _easeType)
			{
				_easeType = a;
				_easeTypeFunc = EaseLookup.find(_easeType);
				_propSaver.easeType = _easeType; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the content scrolling ease animation delay.
		 * @default .5
		 */
		public function get duration():Number
		{
			return _duration;
		}
		/**
		 * @private
		 */
		public function set duration(a:Number):void
		{
			if(a != _duration)
			{
				_duration = a;
				_propSaver.duration = _duration; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * if <code>true</code>, touch scroll is sticked if content position is at the start or end point of the mask,
		 * if <code>false</code>, touch scroll bounces when gets to the start or end point of the mask.
		 * @default false
		 */
		public function get isStickTouch():Boolean
		{
			return _isStickTouch;
		}
		/**
		 * @private
		 */
		public function set isStickTouch(a:Boolean):void
		{
			if(a != _isStickTouch)
			{
				_isStickTouch = a;
				_propSaver.isStickTouch = _isStickTouch; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * indicates the hold area boundaries.
		 * @default 10
		 */
		public function get holdArea():Number
		{
			return _holdArea;
		}
		/**
		 * @private
		 */
		public function set holdArea(a:Number):void
		{
			if(a != _holdArea)
			{
				_holdArea = a;
				_propSaver.holdArea = _holdArea; // pass the new value to the value of the object property
			}
		}
		
		/**
		 * if <code>true</code>, shows that we have scrolled enough and got out of the <code>holdArea</code>,
		 * if <code>false</code>, shows that we are still inside the <code>holdArea</code>.
		 */
		public function get isHoldAreaDone():Boolean
		{
			return _isHoldAreaDone;
		}
		
		public function set content(a:*):void
		{
			_content = a;
			
			
		}
		
		/**
		 * indicates the location of scrollbar vertically, values are from 0 to 100.
		 * @default 0
		 */
		public function get yPerc():Number
		{
			return _yPerc;
		}
		/**
		 * @private
		 */
		public function set yPerc(a:Number):void
		{
			if(a != _yPerc)
			{
				_yPerc = a;
				_propSaver.yPerc = _yPerc; // pass the new value to the value of the object property
				
				computeYPerc(true);
			}
		}
		
		/**
		 * indicates the location of scrollbar horizontally, values are from 0 to 100.
		 * @default 0
		 */
		public function get xPerc():Number
		{
			return _xPerc;
		}
		/**
		 * @private
		 */
		public function set xPerc(a:Number):void
		{
			if(a != _xPerc)
			{
				_xPerc = a;
				_propSaver.xPerc = _xPerc; // pass the new value to the value of the object property
				
				computeXPerc(true);
			}
		}
		
		/**
		 * indicates the velocity of scroller when it's moving horizontally 
		 * (gives you the velocity ONLY when you have flung, not working in other situations).
		 * @default 0
		 */
		public function get xVelocity():Number
		{
			return _xVelocity;
		}
		
		/**
		 * indicates the velocity of scroller when it's moving vertically
		 * (gives you the velocity ONLY when you have flung, not working in other situations).
		 * @default 0
		 */
		public function get yVelocity():Number
		{
			return _yVelocity;
		}
		
		/**
		 * indicates the device DPI, so that we use it in our scrolling calculations to scroll correctly according to the user fingers in different devices no matter the device has a high or low DPI.
		 * @default 1
		 */
		public function get dpiScaleMultiplier():Number
		{
			return _dpiScaleMultiplier;
		}
		/**
		 * @private
		 */
		public function set dpiScaleMultiplier(a:Number):void
		{
			_dpiScaleMultiplier = a;
		}
		
		
		
		
		/**
		 * export the class and send the Object that holds all of the setters values.
		 */
		public function get exportProp():Object
		{
			return _propSaver;
		}
		/**
		 * import the class and get the Object that holds all of the setters values.
		 */
		public function set importProp(a:Object):void
		{
			for (var prop:* in a)
			{
				this[prop] = a[prop];
			}
		}
		
		
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}