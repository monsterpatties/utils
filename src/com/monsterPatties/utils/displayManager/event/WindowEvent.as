package com.monsterPatties.utils.displayManager.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author jc
	 */
	public class WindowEvent extends Event 
	{
		public static const MOUSE_LEAVE_WINDOW:String = "MOUSE_LEAVE_WINDOW";
		public static const ON_CLICK_WINDOW:String = "ON_CLICK_WINDOW";
		
		public function WindowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new WindowEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("WindowEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}