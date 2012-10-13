package com.monsterPatties.components.levelEditor 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class LevelEditorEvent extends Event 
	{
		/*-----------------------------------------------------------------------Constant--------------------------------------------------------------------*/		
		public static const MAP_STOP_MOVE:String = "MAP_STOP_MOVE";
		public static const GENERATE_MAP:String = "GENERATE_MAP";
		public static const CREATE_NEW_MAP:String = "CREATE_NEW_MAP";
		public static const LOAD_MAP:String = "LOAD_MAP";
		public static const SCROLL_MAP:String = "SCROLL_MAP";
		public static const MAP_SCALE_DOWN:String = "MAP_SCALE_DOWN";
		public static const MAP_SCALE_UP:String = "MAP_SCALE_UP";
		public static const ADD_ROW:String = "ADD_ROW";
		public static const ADD_COL:String = "ADD_COL";
		public static const SUB_ROW:String = "SUB_ROW";
		public static const SUB_COL:String = "SUB_COL";
		/*-----------------------------------------------------------------------Properties--------------------------------------------------------------------*/
		
		private var _obj:Object = new Object();
		
		/*-----------------------------------------------------------------------Constructor--------------------------------------------------------------------*/
		public function LevelEditorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*-----------------------------------------------------------------------Methods--------------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new LevelEditorEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LevelEditorEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}		
		
		/*-----------------------------------------------------------------------Setters--------------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*-----------------------------------------------------------------------Getters--------------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*-----------------------------------------------------------------------EventHandlers--------------------------------------------------------------------*/
		
	}
	
}