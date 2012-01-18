package com.monsterPatties.utils.timer 
{
	import com.monsterPatties.utils.deepCopy.DeepCopy;
	import com.monsterPatties.utils.timer.events.ClockEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class Clock extends Sprite
	{
		/*-----------------------------------------------------------------Constant-------------------------------------------------------*/
		
		/*-----------------------------------------------------------------Properties-------------------------------------------------------*/
		private var _timerData:TimerData;
		private var _timer:Timer;
		private var _txtClock:TextField;
		private var _tick:int;
		
		private var _timeH:int;
		private var _timeM:int;		
		private var _timeS:int;
		
		private var _CTimeH:int;
		private var _CTimeM:int;		
		private var _CTimeS:int;
		
		private var _clockEvent:ClockEvent;
		private var _countDown:Boolean;
		
		private var _mc:TimerMC;
		
		private var _isClockStarted:Boolean;
		/*-----------------------------------------------------------------Constructor-------------------------------------------------------*/
		
		public function Clock( countDown:Boolean ) 
		{
			_countDown = countDown;
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			initTimerData();
			setDisplay();	
			addTimer();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
			removeTimer();
		}
		
		/*-----------------------------------------------------------------Methods-------------------------------------------------------*/
		private function setDisplay():void 
		{
			//_txtClock = new TextField();
//
			//_txtClock.autoSize = 'left';
			//_txtClock.background = true;
			//_txtClock.backgroundColor = 0xFFFFFF;
			//_txtClock.border = true;
			//_txtClock.borderColor = 0x000000;
			//_txtClock.width = 100;
			//addChild( _txtClock );
			//_txtClock.text = _tick.toString();	
			
			_mc = new TimerMC();
			addChild( _mc );			
		}
		
		private function removeDisplay():void 
		{
			if ( _txtClock != null ) {
				if (this.contains( _txtClock ) ) {
					this.removeChild( _txtClock );
					_txtClock = null;
				}
			}
			
			if ( _mc != null ) {
				if (this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}		
		
		private function addTimer():void 
		{
			_timer = new Timer( 1000 );
			_timer.addEventListener( TimerEvent.TIMER, onUpdateTimer );			
			//_timer.start();
		}
		
		
		private function removeTimer():void 
		{			
			if ( _timer != null ) {
				_timer.stop();
				_timer.removeEventListener( TimerEvent.TIMER, onUpdateTimer );
				_timer = null;
			}
		}
		
		private function initTimerData():void 
		{			
			_timerData = new TimerData();
			
			_timerData.hour = 0;
			_timerData.min = 0;
			_timerData.sec = 0;			
			
			_timeH = 0;
			_timeM = 0;
			_timeS = 0;
		}		
		
		public function setTimesUP( h:int, m:int, s:int ):void 
		{
			_timeH = h;
			_timeM = m;
			_timeS = s;
		}
		
		public function setCountDownTime( h:int, m:int, s:int ):void 
		{
			_timerData.hour = h;
			_timerData.min = m;
			_timerData.sec = s;
			
			updateClockLabel();
		}
		
		
		public function stopClock():void 
		{
			_timer.stop();
		}
		
		public function startClock():void 
		{
			if ( _timer != null && !_isClockStarted ) {
				if ( !_isClockStarted ) {
					_isClockStarted = true;
				}
				_timer.start();
			}
		}		
		
		public function getTimerData():*
		{		
			var timerData:* = DeepCopy.clone( _timerData );
			return timerData;
		}
		
		public function minusSec( val:int ):void 
		{				
			if( _timerData.sec > val  ){
				_timerData.sec -= val;
			}
			else{				
				var total:int = ( _timerData.sec - val )  * -1;
				var newSec:int = 60 - total;
				trace( "tot", total );
				if( _timerData.min > 0 ){
					_timerData.min--;
					_timerData.sec = newSec;					
				}else {
					_timerData.sec = 0;
					_timerData.min = 0;		
					timesUpEvent();
				}
			}
			updateClockLabel();
		}
		
		public function addSec( val:int ):void 
		{			
			if( val >= 60 ){
				_timerData.min++;
			}else {				
				var total:int = _timerData.sec + val;				
				if (total > 60 ) {
					var newSec:int = total % 60;
					_timerData.min++;
					_timerData.sec = newSec;
				}else{				
					_timerData.sec += val;
				}
			}			
			updateClockLabel();
		}		
		
		private function timesUpEvent():void 
		{
			updateClockLabel();
			_clockEvent = new ClockEvent( ClockEvent.TIMES_UP );				
			dispatchEvent( _clockEvent );
		}
		
		private function updateClockLabel ():void 
		{
			var sec:String;
			var min:String;
			var hour:String;			
			
			if ( _timerData.sec.toString().length == 1 ) {		
				sec = "0" + _timerData.sec.toString();
			}else {
				sec = _timerData.sec.toString();
			}
			
			if ( _timerData.min.toString().length == 1 ) {		
				min = "0" + _timerData.min.toString();
			}else {
				min = _timerData.min.toString();
			}
			
			if ( _timerData.hour.toString().length == 1 ) {		
				hour = "0" + _timerData.hour.toString();
			}else {
				hour = _timerData.hour.toString();
			}			
			
			if( _mc != null ){
				_mc.txtTime.text = min + ":" + sec;
			}
		}
		/*-----------------------------------------------------------------Setters-------------------------------------------------------*/
		public function set isClockStarted(value:Boolean):void 
		{
			_isClockStarted = value;
		}
		/*-----------------------------------------------------------------Getters-------------------------------------------------------*/
		public function get isClockStarted():Boolean { return _isClockStarted; }
		/*-----------------------------------------------------------------EventHandlers-------------------------------------------------*/
		private function onUpdateTimer(e:TimerEvent):void 
		{				
			//trace( "tick...", _timerData.sec );			
			
			if ( _countDown){			
				if ( _timerData.sec <= 0 ){
					_timerData.sec = 60;
					_timerData.min--;
				}
				
				_timerData.sec--;				
			}else {							
				if ( _timerData.sec >= 60 ){
					_timerData.sec = 0;
					_timerData.min++;
				}
				_timerData.sec++;				
			}								
			
			if ( _timerData.hour == _timeH && _timerData.min == _timeM && _timerData.sec == _timeS && !_countDown ) {
				timesUpEvent();
			}else if ( _timerData.hour == 0 && _timerData.min == 0 && _timerData.sec == 0 && _countDown ) {
				timesUpEvent();
			}			
			
			updateClockLabel();
		}	
	}

}