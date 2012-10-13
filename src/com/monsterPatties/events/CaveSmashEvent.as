package com.monsterPatties.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author jc
	 */
	public class CaveSmashEvent extends Event 
	{
		/*------------------------------------------------------------------------Constant--------------------------------------------------------------*/
		public static const PICK_UP_ITEM:String = "PICK_UP_ITEM";
		public static const DESTROY_BLOCK:String = "DESTROY_BLOCK";	
		public static const LEVEL_STARTED:String = "LEVEL_STARTED";		
		public static const BOSS_LEVEL_STARTED:String = "BOSS_LEVEL_STARTED";		
		public static const LEVEL_COMPLETE:String = "LEVEL_COMPLETE";
		public static const LEVEL_FAILED:String = "LEVEL_FAILED";
		public static const SWITCH_ACTIVATED:String = "SWITCH_ACTIVATED";
		
		public static const PLAYER_RECIEVED_DAMAGED:String = "PLAYER_RECIEVED_DAMAGED";
		public static const BOSS_RECIEVED_DAMAGED:String = "BOSS_RECIEVED_DAMAGED";
		public static const BOSS_DIED:String = "BOSS_DIED";
		public static const MONSTER_DIED:String = "MONSTER_DIED";
		public static const LOAD_LEVEL:String = "LOAD_LEVEL";
		public static const LOAD_BOSS_LEVEL:String = "LOAD_BOSS_LEVEL";
		public static const RELOAD_LEVEL:String = "RELOAD_LEVEL";
		public static const RESET_LIFE:String = "RESET_LIFE";
		
		public static const ON_START_CAMERA_SLIDE:String = "ON_START_CAMERA_SLIDE";
		public static const ON_STOP_CAMERA_SLIDE:String = "ON_STOP_CAMERA_SLIDE";
		/*------------------------------------------------------------------------Properties--------------------------------------------------------------*/		
		private var _obj:Object = new Object();
		/*------------------------------------------------------------------------Constructor--------------------------------------------------------------*/
		
		public function CaveSmashEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		
		/*------------------------------------------------------------------------Methods--------------------------------------------------------------*/
		
		public override function clone():Event 
		{ 
			return new CustomEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CustomEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}		
		
		/*------------------------------------------------------------------------Setters--------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*------------------------------------------------------------------------Getters--------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}	
		
		/*------------------------------------------------------------------------EventHandlers---------------------------------------------------------*/
		
	}
	
}