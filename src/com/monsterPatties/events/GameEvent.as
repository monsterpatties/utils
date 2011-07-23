package com.monsterPatties.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class GameEvent extends Event 
	{
		
		/*-------------------------------------------------------------------------Constant-------------------------------------------------------------*/
		public static const EXIT_GAME:String = "EXIT_GAME";
		public static const LEVEL_SELECT:String = "LEVEL_SELECT";
		public static const LEVEL_COMPLETE:String = "LEVEL_COMPLETE";
		public static const START_LEVEL:String = "START_LEVEL";		
		public static const LEVEL_FAILED:String = "LEVEL_FAILED";
		public static const RESET_LEVEL:String = "RESET_LEVEL";	
		/*-------------------------------------------------------------------------Properties-------------------------------------------------------------*/
		
		private var _obj:Object = new Object();
		/*-------------------------------------------------------------------------Constructor-------------------------------------------------------------*/
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*-------------------------------------------------------------------------Methods-------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new GameEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
		
		/*-------------------------------------------------------------------------Setters-----------------------------------------------------------------*/
		
		
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		
		/*-------------------------------------------------------------------------Getters-----------------------------------------------------------------*/
		
		public function get obj():Object { return _obj; }		
		
		/*-------------------------------------------------------------------------EventHandlers-----------------------------------------------------------*/
		
	}
	
}