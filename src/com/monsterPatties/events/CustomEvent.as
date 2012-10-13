package com.monsterPatties.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author jc
	 */
	public class CustomEvent extends Event 
	{
		/*------------------------------------------------------------------------Constant--------------------------------------------------------------*/
		public static const STUN:String = "STUN";
		/*------------------------------------------------------------------------Properties--------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------Constructor--------------------------------------------------------------*/		
		
		private var _obj:Object = new Object();
		
		public function CustomEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
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
		
		/*------------------------------------------------------------------------Getters--------------------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		
		/*------------------------------------------------------------------------EventHandlers---------------------------------------------------------*/
		
	}
	
}