package com.monsterPatties.ui 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class TimerUiEvent extends Event 
	{
		/*--------------------------------------------------------------------------Constant-------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------Properties-----------------------------------------------------------*/
		public static const SECOND_CHANGE:String = "SECOND_CHANGE";
		public static const MINUTE_CHANGE:String = "MINUTE_CHANGE";
		public static const HOUR_CHANGE:String = "HOUR_CHANGE";
		public static const TEN_SEC_CHANGE:String = "TEN_SEC_CHANGE";
		public static const TIMES_UP:String = "TIMES_UP";
		/*--------------------------------------------------------------------------Constructor-------------------------------------------------------------*/
		
		public function TimerUiEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*--------------------------------------------------------------------------Methods-------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new TimerUiEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TimerUiEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/*--------------------------------------------------------------------------Setters-------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------Getters-------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------EventHandlers-------------------------------------------------------*/
		
	}
	
}