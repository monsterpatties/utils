package com.monsterPatties.engine 
{
	import com.monsterPatties.networking.Conn;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class MultiPlayer extends Sprite
	{
		/*----------------------------------------------------------------Constant--------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------Properties------------------------------------------------------------------*/
		private var _connection:Conn;
		/*----------------------------------------------------------------Constructor-----------------------------------------------------------------*/
		
		
		public function MultiPlayer() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_connection = new Conn( stage );
			_connection.connect(  );
		}
		
		/*----------------------------------------------------------------Methods--------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------Setters--------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------Getters--------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------EventHandlers--------------------------------------------------------------*/
		
	}

}