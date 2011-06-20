package com.monsterPatties.utils.kongregateApi 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class KongregateApi extends Sprite
	{	
		/*----------------------------------------------------------------Constant-------------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------Properties-------------------------------------------------------------------------*/
		private static var _intance:KongregateApi;
		private var _kongregate:*;
		/*----------------------------------------------------------------Constructor-------------------------------------------------------------------------*/
		
		public function KongregateApi( enforcer:SingletonEnforcer ) 
		{
			
		}
		
		public static function getInstance():KongregateApi 
		{
			if ( KongregateApi._intance == null ) {
				KongregateApi._intance = new KongregateApi( new SingletonEnforcer() );
			}
			
			return KongregateApi._intance;
		}
		
		/*----------------------------------------------------------------Methods-------------------------------------------------------------------------*/
		public function loadApi( url:String = "http://www.kongregate.com/flash/API_AS3_Local.swf" ):void 
		{
			if( url != null ){
				// Allow the API access to this SWF
				Security.allowDomain(url);
				
				// Load the API			
				var request:URLRequest = new URLRequest(url);
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress );
				loader.addEventListener( IOErrorEvent.IO_ERROR, onErrorLoadingKongregateApi )
				loader.load(request);
				this.addChild(loader);
			}else {
				trace( "kongApi Error: api path is null...." );
			}
		}				
		
		/*----------------------------------------------------------------Setters-------------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------Getters-------------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------EventHandlers-------------------------------------------------------------------------*/
		private function loadProgress(e:ProgressEvent):void 
		{			
			trace(  (e.bytesLoaded / e.bytesTotal) * 100 , "%"  );			
		}
		
		private function loadComplete(e:Event):void 
		{
			trace( "kongreapi loaded successfully................................." );
			// Save Kongregate API reference
			_kongregate = e.target.content;
			addChild( _kongregate );
			trace( "kong vars", _kongregate );
		 
			//for each ( var a:* in _kongregate.services ) {
				//trace( "see", a );
			//}
			
			// Connect to the back-end
			if( _kongregate != null ){
				_kongregate.services.connect();
			}else {
				trace( "kong is null.........." );
			}
			
			//_kongregate.connect();
			
			//var username:String = _kongregate.services.getUsername();
			//trace( "userName: ", username );
		 
			// You can now access the API via:
			// kongregate.services
			// kongregate.user
			// kongregate.scores
			// kongregate.stats
			// etc...
		}
		
		private function onErrorLoadingKongregateApi(e:IOErrorEvent):void 
		{
			trace( "error loading kongregate api......." );
		}
	}

}

class SingletonEnforcer {}