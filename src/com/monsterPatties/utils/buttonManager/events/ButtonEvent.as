package com.monsterPatties.utils.buttonManager.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ButtonEvent extends Event 
	{
		/*---------------------------------------------------------------Constant------------------------------------------------*/
		
		/*---------------------------------------------------------------Properties------------------------------------------------*/
		private var _obj:Object = new Object();
		/*---------------------------------------------------------------Constructor------------------------------------------------*/
		
		public static const CLICK_BUTTON:String = "CLICK_BUTTON";
		public static const ROLL_OVER_BUTTON:String = "ROLL_OVER_BUTTON";
		public static const ROLL_OUT_BUTTON:String = "ROLL_OUT_BUTTON";
		
		public function ButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*---------------------------------------------------------------Methods------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new ButtonEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ButtonEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/*---------------------------------------------------------------Setters------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*---------------------------------------------------------------Getters------------------------------------------------*/
		public function get obj():Object 
		{
			return _obj;
		}
		/*---------------------------------------------------------------EventHandlers------------------------------------------------*/
	}
	
}