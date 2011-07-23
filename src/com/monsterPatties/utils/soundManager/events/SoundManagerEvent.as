package com.monsterPatties.utils.soundManager.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class SoundManagerEvent extends Event 
	{
		/*---------------------------------------------------------------------------Constant-----------------------------------------------------------------*/
		public static const TOGGLE_BGM:String = "TOGGLE_BGM";
		public static const TOGGLE_SFX:String = "TOGGLE_SFX";
		/*---------------------------------------------------------------------------Properties-----------------------------------------------------------------*/
		private var _obj:Object = new Object();
		
		/*---------------------------------------------------------------------------Constructor-----------------------------------------------------------------*/
		
		public function SoundManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*---------------------------------------------------------------------------Methods-----------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new SoundManagerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SoundManagerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/*---------------------------------------------------------------------------Setters-----------------------------------------------------------------*/
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		
		/*---------------------------------------------------------------------------Getters-----------------------------------------------------------------*/
		public function get obj():Object { return _obj; }		
		
	}
	
}