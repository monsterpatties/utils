package com.monsterPatties.ui 
{	
	import com.monsterPatties.controllers.GameDataController;
	import com.monsterPatties.utils.eventSatellite.EventSatellite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class TimerUI extends Sprite
	{
		
		/*-------------------------------------------------------------------Constant----------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------Properties--------------------------------------------------------------------*/
		private var _mc:TimerUIMC;
		private var _xpos:Number = 0;
		private var _ypos:Number = 0;
		
		private var _sec:int;
		private var _min:int;
		private var _hour:int;
		private var _delay:int;
		
		private var _timer:Timer;
		private var _gdc:GameDataController;
		private var _es:EventSatellite;
		private var _timerUIEvent:TimerUiEvent;
		private var _isCountDown:Boolean;
		/*-------------------------------------------------------------------Constructor-------------------------------------------------------------------*/
		
		public function TimerUI( xpos:Number, ypos:Number, delay:int, isCountDown:Boolean, hr:int = 0, min:int = 0, sec:int = 0  ) 
		{
			_delay = delay;
			_isCountDown = isCountDown;
			_hour = hr;
			_min = min;
			_sec = sec;
			
			_es = EventSatellite.getInstance();
			_gdc = GameDataController.getInstance();			
			_xpos = xpos;
			_ypos = ypos;			
			addEventListener( Event.ADDED_TO_STAGE, init );
		}	
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		
		private function getCountFormat( type:int ):String 
		{
			var h:String;
			if( _hour.toString().length == 1 ){
				h = "0" + _hour; 				
			}else {
				h = _hour.toString();
			}
			
			var m:String;
			if( _min.toString().length  ==  1 ){
				m = "0" + _min; 				
			}else {
				m = _min.toString();
			}
			
			var s:String;
			if( _sec.toString().length  == 1 ){
				s = "0" + _sec; 				
			}else {
				s = _sec.toString();
			}		
			
			
			if ( type == 0 ){
				return m + ":" + s;
			}else if( type == 1 ) {
				return s;
			}else{
				return h + ":" + m + ":" + s;
			}
			
		}
		
		/*-------------------------------------------------------------------Methods----------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new TimerUIMC();
			addChild( _mc );
			_mc.x = _xpos;
			_mc.y = _ypos;
			
			_timer = new Timer( _delay );
			_timer.addEventListener( TimerEvent.TIMER, onTick );			
			_timer.start();
		}			
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				_timer.stop();
				_timer.removeEventListener( TimerEvent.TIMER, onTick );
				_timer = null;
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		
		public function update():void 
		{
			if( !_isCountDown ){
				_sec++;
				_gdc.updateTotalSec( 1 );
				
				if ( _sec % 15 == 0 ) {
					//_timerUIEvent = new TimerUiEvent( TimerUiEvent.TEN_SEC_CHANGE );
					//_es.dispatchESEvent( _timerUIEvent );
				}
				
				
				if ( _sec >= 60 ) {
					_sec = 0;
					_min++;	
					
					_timerUIEvent = new TimerUiEvent( TimerUiEvent.MINUTE_CHANGE );
					_es.dispatchESEvent( _timerUIEvent );
				}
				
				if ( _min >= 60 ) {
					_hour++;
					_min = 0;
					
					_timerUIEvent = new TimerUiEvent( TimerUiEvent.HOUR_CHANGE );
					_es.dispatchESEvent( _timerUIEvent );
				}
				
				_gdc.updateSecond( _sec );
				_gdc.updateMinute( _min );
				_gdc.updateHour( _hour );				
			}else{				
				if ( _sec > 0 ) {
					_sec--;
				}else {
					if( _min > 0 ){
						_min--;
						_sec = 59;
					}
				}				
				
				_gdc.setSecond( _sec );
				_gdc.setMinute( _min );
				_gdc.setHour( _hour );
			}			
			
			var h:String;
			if( _hour.toString().length == 1 ){
				h = "0" + _hour; 				
			}else {
				h = _hour.toString();
			}
			
			var m:String;
			if( _min.toString().length  ==  1 ){
				m = "0" + _min; 				
			}else {
				m = _min.toString();
			}
			
			var s:String;
			if( _sec.toString().length  == 1 ){
				s = "0" + _sec; 				
			}else {
				s = _sec.toString();
			}
			
			_mc.txtTimer.text = getCountFormat( 0 );
			_gdc.setCurTime( _mc.txtTimer.text );
			
			if ( _hour <= 0 &&  _min <= 0 && _sec <= 0 ) {
				_timerUIEvent = new TimerUiEvent( TimerUiEvent.TIMES_UP );
				_es.dispatchESEvent( _timerUIEvent );
			}
		}
		
		public function stopTimer():void 
		{
			if( _timer != null ){
				_timer.stop();	
				_timer.removeEventListener( TimerEvent.TIMER, onTick );				
			}
		}
		
		public function startTimer():void 
		{
			if( _timer != null ){
				_timer.start();		
				_timer.addEventListener( TimerEvent.TIMER, onTick );
			}
		}
		
		public function addSec( val:int ):void 
		{				
			var newSec:int = _sec + val;
			if ( newSec >= 60  ) {
				newSec -= 60;
				_min++;
				_sec = newSec;
			}else {
				_sec += val;
			}	
			
			trace( "[TimerUI] sec: ", _sec, "min", _min  );
		}
		
		/*-------------------------------------------------------------------Setters----------------------------------------------------------------------*/
		public function set isCountDown(value:Boolean):void 
		{
			_isCountDown = value;
		}	
		
		public function set sec(value:int):void 
		{
			_sec = value;
		}
		
		public function set min(value:int):void 
		{
			_min = value;
		}
		
		public function set hour(value:int):void 
		{
			_hour = value;
		}
		
		public function set delay(value:int):void 
		{
			_delay = value;
		}
		/*-------------------------------------------------------------------Getters----------------------------------------------------------------------*/
		public function get isCountDown():Boolean 
		{
			return _isCountDown;
		}
		
		public function get sec():int 
		{
			return _sec;
		}		
		
		public function get min():int 
		{
			return _min;
		}	
		
		public function get hour():int 
		{
			return _hour;
		}	
		
		public function get delay():int 
		{
			return _delay;
		}
		
		
		
		/*-------------------------------------------------------------------EventHandlers----------------------------------------------------------------*/
		private function onTick(e:TimerEvent):void 
		{
			update();
		}	
	}
}