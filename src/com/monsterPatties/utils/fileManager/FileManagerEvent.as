package com.monsterPatties.utils.fileManager 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class FileManagerEvent extends Event 
	{
		/*-------------------------------------------------------------------Constant---------------------------------------------------------------------*/
		public static const FILE_SAVE:String = "FILE_SAVE";
		public static const FILE_LOADED:String = "FILE_LOADED";
		/*-------------------------------------------------------------------Properties-------------------------------------------------------------------*/
		private var _obj:Object = new Object();
		/*-------------------------------------------------------------------Constructor-------------------------------------------------------------------*/
		
		
		public function FileManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*-------------------------------------------------------------------Methods---------------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new FileManagerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FileManagerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}				
		/*-------------------------------------------------------------------Setters---------------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		
		/*-------------------------------------------------------------------Getters---------------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*-------------------------------------------------------------------EventHandlers--------------------------------------------------------------*/
	}
	
}