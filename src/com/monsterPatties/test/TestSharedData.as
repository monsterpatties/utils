package com.monsterPatties.test 
{
	import com.monsterPatties.utils.sharedObjects.SharedData;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author jc
	 */
	public class TestSharedData extends Sprite
	{
		
		public function TestSharedData() 
		{			
			addEventListener( Event.ADDED_TO_STAGE, init );			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//add shared object data
			var sd:SharedData = SharedData.getInstance();
			sd.addSharedData( "score", 99 );
			sd.addSharedData( "level", 47 );
			sd.addSharedData( "name", "juanC", "Claridad" );
			
			//trace shared object data			
			var sharedData2:* = sd.searchSharedData( "score" );
			trace( sharedData2 );
			
			//clear shared object data
			sd.removeSharedData( "score" );
			var sharedData3:* = sd.searchSharedData( "score" );
			trace( sharedData3 );
			
			var sharedData4:* = sd.searchSharedData( "level" );
			trace( sharedData4 );
			
			var sharedData5:* = sd.searchSharedData( "name" , 1 );
			trace( sharedData5  );
		}
		
	}

}