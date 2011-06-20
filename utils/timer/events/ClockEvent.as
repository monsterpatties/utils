package com.monsterPatties.utils.timer.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ClockEvent extends Event 
	{
		/*--------------------------------------------------------------------Constant-------------------------------------------*/
		public static const TIMES_UP:String = "TIMES_UP";
		/*--------------------------------------------------------------------Properties-------------------------------------------*/
		private var _obj:Object = new Object();
		/*--------------------------------------------------------------------Constructor-------------------------------------------*/
		public function ClockEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*--------------------------------------------------------------------Methods-------------------------------------------*/
		public override function clone():Event 
		{ 
			return new ClockEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ClockEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}	
		
		/*--------------------------------------------------------------------Setters-------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*--------------------------------------------------------------------Getters-------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*--------------------------------------------------------------------EventHandlers--------------------------------------*/
	}
	
}