package com.monsterPatties.utils.displayManager.event
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class DisplayManagerEvent extends Event
	{
		/*--------------------------------------Constant-----------------------------------------*/
		
		public static const LOAD_SCREEN:String = "LOAD_SCREEN";
		public static const REMOVE_SCREEN:String = "REMOVE_SCREEN";	
		public static const LOAD_POP_UP_WINDOW:String = "LOAD_POP_UP_WINDOW";
		public static const REMOVE_POP_UP_WINDOW:String = "REMOVE_POP_UP_WINDOW";	
		public static const BUTTON_CLICK:String = "BUTTON_CLICK";			
		/*--------------------------------------Properties---------------------------------------*/
		private var _windowName:String;
		
		/*--------------------------------------Constructor--------------------------------------*/	
		
		public function DisplayManagerEvent( type:String , bubbles:Boolean = false, cancelable:Boolean = true ) 
		{
			super( type, bubbles, cancelable );
		}	
		
		/*--------------------------------------Methods------------------------------------------*/
		
		
		/*--------------------------------------Getters------------------------------------------*/
		public function get windowName():String 
		{
			return _windowName;
		}		
		/*--------------------------------------Setters------------------------------------------*/		
		public function set windowName(value:String):void 
		{
			_windowName = value;
		}
		/*--------------------------------------EventHandler-------------------------------------*/
		
	}

}