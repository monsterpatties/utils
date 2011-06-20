package com.monsterPatties.utils.keyboardManager.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class KeyboardManagerEvent extends Event 
	{		
		/*---------------------------------------------------------------Constant--------------------------------------------------------*/
		
		/*---------------------------------------------------------------Properties--------------------------------------------------------*/
		
		/*---------------------------------------------------------------Constructor--------------------------------------------------------*/
		
		public static const KEY_DOWN:String = "KEY_DOWN";
		public static const KEY_UP:String = "KEY_UP";
		
		private var _key:String;
		
		
		public function KeyboardManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new KeyboardManagerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("KeyboardManagerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
		
		
		/*---------------------------------------------------------------Methods--------------------------------------------------------*/
		
		/*---------------------------------------------------------------Getters--------------------------------------------------------*/
		public function get key():String { return _key; }
		/*---------------------------------------------------------------Setters--------------------------------------------------------*/
		public function set key(value:String):void 
		{
			_key = value;
		}
		/*---------------------------------------------------------------EventHandlers--------------------------------------------------------*/
		
	}
	
}