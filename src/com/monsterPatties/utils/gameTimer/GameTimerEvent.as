package com.monsterPatties.utils.gameTimer 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class GameTimerEvent extends Event 
	{
		/*--------------------------------------------------------------------------Constant----------------------------------------------------------*/
		public static const GAME_LOOP:String = "GAME_LOOP";
		/*--------------------------------------------------------------------------Properties--------------------------------------------------------*/
		private var _obj:Object;
		/*--------------------------------------------------------------------------Constructor--------------------------------------------------------*/
		
		
		public function GameTimerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 	
		
		/*-------------------------------------------------------------------methods----------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new GameTimerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameTimerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
		
		
		/*-------------------------------------------------------------------Setters----------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*-------------------------------------------------------------------Getters----------------------------------------------------------*/
		public function get obj():Object { return _obj; }
		/*-------------------------------------------------------------------EventHandlers-----------------------------------------------------*/
		
	}
	
}