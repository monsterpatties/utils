package com.monsterPatties.utils.eventSatellite 
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class EventSatellite extends EventDispatcher
	{
		/*-------------------------------------------------------------------------Constant--------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Properties--------------------------------------------------------------------*/
		private static var _instance:EventSatellite;
		private var _events:Dictionary;
		/*-------------------------------------------------------------------------Constant--------------------------------------------------------------------*/
		
		public function EventSatellite( enforcer:SingletonEnforcer ) 
		{			
			init();
		}
		
		public static function getInstance():EventSatellite {
			if ( EventSatellite._instance == null ) {
				EventSatellite._instance = new EventSatellite( new SingletonEnforcer() );				
			}		
			//trace( "es get instance" );
			return EventSatellite._instance;
		}
		
		/*-------------------------------------------------------------------------Method--------------------------------------------------------------------*/
		public function init():void 
		{
			_events = new Dictionary();			
		}
		
		
		private function addEvent( event:* ):void 
		{			
			var obj:Object = searchEvent( event );
			
			if( !obj.found ){
				var len:int = getEventsLength();			
				if( len > 0 ){
					_events[ len + 1 ] = event;
				}else {
					_events[ len ] = event;
				}				
				//trace( event + "has been successfully added........" );
			}else {
				//trace( event + "canot be added because its already added..........." );
			}
		}
		
		
		public function dispatchESEvent(  event:*, val:Object = null ):void 
		{
			addEvent( event );
			
			var obj:Object = searchEvent( event );
			
			if ( obj.found ) {
				//trace( "dispatched event...........................", obj.event ); 
				if( val != null ){
					obj.event.obj = val;
				}
				dispatchEvent(obj.event  );
			}
		}
		
		public function getEventsLength():int 
		{
			var len:int;
			for each ( var a:* in _events ){
				//trace( "see: ", a, len );
				len++;
			}
			
			return len;
		}
		
		
		public function searchEvent( event:* ):Object 
		{
			//var found:Boolean;
			var obj:Object = new Object();
			
			for each ( var a:* in _events ) {
				//trace( "searching", a );
				if ( a == event ) {
					//trace( "event found", a );
					obj.found = true;
					obj.event = a;
					break;
				}
			}
			
			return obj;
		}
		
		/*-------------------------------------------------------------------------Setters--------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Getters--------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------EventHandlers--------------------------------------------------------------*/
		
	}
}

class SingletonEnforcer{}