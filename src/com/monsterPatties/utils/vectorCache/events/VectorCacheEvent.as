package com.monsterPatties.utils.vectorCache.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class VectorCacheEvent extends Event 
	{
		/*--------------------------------------------------------------------Constant---------------------------------------------------------------------*/
		public static const CACHE_COMPLETE:String = "CACHE_COMPLETE";
		public static const VC_PLAY_COMPLETE:String = "VC_PLAY_COMPLETE";
		/*--------------------------------------------------------------------Properties---------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------Constructor--------------------------------------------------------------------*/
		
		
		public function VectorCacheEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		
		/*--------------------------------------------------------------------Methods---------------------------------------------------------------------*/
		
		
		public override function clone():Event 
		{ 
			return new VectorCacheEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("VectorCacheEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/*--------------------------------------------------------------------Setters---------------------------------------------------------------------*/
		/*--------------------------------------------------------------------Getters---------------------------------------------------------------------*/
		/*--------------------------------------------------------------------EventHandlers---------------------------------------------------------------------*/
		
	}
	
}