package com.monsterPatties.utils.gameTimer 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class GameTimer extends EventDispatcher
	{
		/*------------------------------------------------------------------Constant-----------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------Properties---------------------------------------------------------------------*/
		private var _timer:Timer;
		private var _tick:int;
		private var _gameTimerEvent:GameTimerEvent;
		private var _isTime:Boolean;
		private var _stage:Stage;
		/*------------------------------------------------------------------Constructor--------------------------------------------------------------------*/
		
		
		public function GameTimer( stage:Stage, isTime:Boolean = true ) 
		{
			_isTime = isTime;
			_stage = stage;
			
			if( _isTime ){				
				addTimer();
			}else {
				addEnterFrame();
			}
		}
		
		/*------------------------------------------------------------------Methods-----------------------------------------------------------------------*/
		
		private function addEnterFrame():void 
		{
			_stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		public function removeEnterFrame():void 
		{
			if( !_isTime ){
				removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			}
		}
		
		public function stopEnterFrame():void 
		{
			_stage.frameRate = 0;			
		}
		
		private function addTimer():void 
		{
			_timer = new Timer( 30 );
			_timer.addEventListener( TimerEvent.TIMER, onTick  );			
		}	
		
		public function removeTimer():void 
		{
			if( _isTime ){
				_timer.stop();			
				_timer.removeEventListener( TimerEvent.TIMER, onTick  );
				_timer = null;
			}
		}
		
		public function startTimer():void 
		{
			if( _isTime ){
				_timer.start();
			}
		}
		
		public function stopTimer():void 
		{
			if( _isTime ){
				_timer.stop();
			}
		}
		/*------------------------------------------------------------------Setters-----------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------Getters-----------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------EventHandlers-----------------------------------------------------------------*/
		private function onTick(e:TimerEvent):void 
		{
			//trace( "gameTimer tick timer mode", _tick );			
			_tick++;
			_gameTimerEvent = new GameTimerEvent( GameTimerEvent.GAME_LOOP );			
			dispatchEvent( _gameTimerEvent );
		}
		
		private function onEnterFrame(e:Event):void 
		{
			//trace( "gameTimer tick enterframe mode", _tick );
			_tick++;
			_gameTimerEvent = new GameTimerEvent( GameTimerEvent.GAME_LOOP );			
			dispatchEvent( _gameTimerEvent );
		}
	}

}