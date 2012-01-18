package com.surnia.socialStar.utils.assetLoader.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class AssetLoaderEvent extends Event 
	{
		/*-------------------------------------------------------------------Constant---------------------------------------------------------------------*/
		public static const ASSET_LOAD_COMPLETE:String = "ASSET_LOAD_COMPLETE"
		public static const ASSET_PROGRESS:String="ASSET_PROGRESS"
		/*-------------------------------------------------------------------Properties---------------------------------------------------------------------*/
		private var _id:String;
		private var _obj:Object = new Object();
		/*-------------------------------------------------------------------Constructor---------------------------------------------------------------------*/
		
		
		public function AssetLoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*-------------------------------------------------------------------Methods---------------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new AssetLoaderEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AssetLoaderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
		
		/*-------------------------------------------------------------------Setters---------------------------------------------------------------------*/
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function set obj(value:Object):void 
		{
			_obj = value;
		}
		/*-------------------------------------------------------------------Getters---------------------------------------------------------------------*/		
		public function get id():String { return _id; }		
		
		public function get obj():Object { return _obj; }
		
		
		
		/*-------------------------------------------------------------------EventHandlers---------------------------------------------------------------------*/
		
	}
	
}