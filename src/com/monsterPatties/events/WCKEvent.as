package com.monsterPatties.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author jc
	 */
	public class WCKEvent extends Event 
	{		
		
		public static const	DONE_BLOCK_ANIMATION:String = "DONE_BLOCK_ANIMATION";
		public static const	DONE_ITEM_ANIMATION:String = "DONE_ITEM_ANIMATION";
		
		public function WCKEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new WCKEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("WCKEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}