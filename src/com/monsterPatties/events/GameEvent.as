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
		public static const GAME_OUT_FOCUS:String = "GAME_OUT_FOCUS";
		public static const GAME_GOT_FOCUS:String = "GAME_GOT_FOCUS";
		public static const GAME_UNPAUSED:String = "GAME_UNPAUSED";
		
		public static const GAME_DEACTIVATE_CONTROLS:String = "GAME_DEACTIVATE_CONTROLS";
		public static const GAME_ACTIVATE_CONTROLS:String = "GAME_ACTIVATE_CONTROLS";
		
		public static const SHOW_PAUSED_SCREEN:String = "SHOW_PAUSED_SCREEN";		
		public static const SHOW_GAME_SETTING:String = "SHOW_GAME_SETTING";
		
		//public static const LEVEL_START:String = "LEVEL_START";
		//public static const LEVEL_COMPLETE:String = "LEVEL_COMPLETE";
		//public static const LEVEL_FAILED:String = "LEVEL_FAILED";
		//public static const RESTART_LEVEL:String = "RESTART_LEVEL";
		//public static const GAME_COMPLETE:String = "GAME_COMPLETE";		
		//public static const LOAD_LEVEL:String = "LOAD_LEVEL";
		//public static const REMOVE_MESSAGE_SCREEN:String = "REMOVE_MESSAGE_SCREEN";		
        //public static const COLLECT_ITEM:String = "COLLECT_ITEM";
        //public static const GOAL_COMPLETE:String = "GOAL_COMPLETE";	
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