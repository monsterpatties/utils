package com.monsterPatties.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class GameEvent extends Event 
	{
		
		/*-----------------------------------------------------------------Constant---------------------------------------------------------------*/
		public static const GAME_OVER:String = "GAME_OVER";
		public static const GAME_EXIT:String = "GAME_EXIT";
		public static const GAME_PAUSED:String = "GAME_PAUSED";
		public static const GAME_UNPAUSED:String = "GAME_UNPAUSED";
		/*-----------------------------------------------------------------Properties---------------------------------------------------------------*/
		private var _obj:Object = new Object();
		/*-----------------------------------------------------------------Constructor---------------------------------------------------------------*/
		
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new GameEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
		
		
		/*-----------------------------------------------------------------Methods---------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------Setters---------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*-----------------------------------------------------------------Getters---------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*-----------------------------------------------------------------EventHandlers----------------------------------------------------------*/
		
	}
	
}