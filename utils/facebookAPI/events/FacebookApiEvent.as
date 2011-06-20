package com.monsterPatties.utils.facebookAPI.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class FacebookApiEvent extends Event 
	{
		
		public static const EXTRACT_FRIENDS_ID_COMPLETE:String = "EXTRACT_FRIENDS_ID_COMPLETE";
		public static const EXTRACT_FRIENDS_DATA_COMPLETE:String = "EXTRACT_FRIENDS_DATA_COMPLETE";
		public static const EXTRACT_FRIENDS_IMAGE_COMPLETE:String = "EXTRACT_FRIENDS_IMAGE_COMPLETE";
		public static const LOGIN_COMPLETE:String = "LOGIN_COMPLETE";
		public static const USER_DATA_COMPLETE:String = "USER_DATA_COMPLETE";
		
		
		public function FacebookApiEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new FacebookApiEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FacebookApiEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}