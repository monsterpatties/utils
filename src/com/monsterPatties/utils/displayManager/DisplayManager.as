package com.monsterPatties.utils.displayManager
{	
	import com.monsterPatties.utils.displayManager.event.DisplayManagerEvent;	
	import com.monsterPatties.utils.eventSatellite.EventSatellite;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;	
	/**
	 * ...
	 * @author MonsterPatties
	 */
	public class DisplayManager extends Sprite
	{
		/*---------------------------------------------------------------Constant-----------------------------------------------------------------*/
		private static var _instance:DisplayManager;
		
		/*---------------------------------------------------------------Properties---------------------------------------------------------------*/		
		private var _displayManagerHolder:Sprite;		
		private var _currentScreen:Window;
		private var _screens:Array;	
		
		private var _subScreenHolder:Sprite;
		private var _subScreen:Window;
		private var _subScreens:Array;
		
		private var _displayManagerEvent:DisplayManagerEvent;
		private var _es:EventSatellite; 
		/*-----------------------------------------------------------------Constructor----------------------------------------------------------*/
		
		public function DisplayManager ( enforcer:SingletonEnforcer ) {
			addEventListener( Event.ADDED_TO_STAGE , init );
		}		
		
		public static function getInstance():DisplayManager {
			if ( DisplayManager._instance == null ) {
				DisplayManager._instance = new DisplayManager( new SingletonEnforcer() );
			}			
			return DisplayManager._instance;			
		}		
		
		private function init( e:Event ):void 
		{	
			_es = EventSatellite.getInstance();
			addEventListener( Event.REMOVED_FROM_STAGE , collectGarbage );
			removeEventListener( Event.ADDED_TO_STAGE , init );						
			
			addDisplayManagerHolder();
			trace( "init displayManager" );			
		}
		
		public function destroy():void {			
			removeDisplayManagerHolder();			
		}	
		
		/*--------------------------------------------------------------Methods---------------------------------------------------------*/
		private function addDisplayManagerHolder():void {
			_screens = new Array();
			_displayManagerHolder = new Sprite();
			addChild( _displayManagerHolder );
			
			_subScreens = new Array();
			_subScreenHolder = new Sprite();
			addChild( _subScreenHolder );
		}
		
		private function removeDisplayManagerHolder():void {			
			if ( this.contains( _displayManagerHolder ) ) {
				this.removeChild( _displayManagerHolder );
				_displayManagerHolder = null;
			}
		}
		
		public function loadSubScreen( whichScreen:String ):void {			
			var obj:Object = searchSubScreen( whichScreen, false, true );
			if ( !obj.found ) {
				//trace( whichScreen + " Does not exist..." );
			}else{			
				if ( _subScreenHolder != null ) {					
					_subScreenHolder.addChild( obj.screen );
					obj.screen.initWindow();
					_displayManagerEvent = new DisplayManagerEvent( DisplayManagerEvent.LOAD_SCREEN );
					_displayManagerEvent.windowName = _currentScreen.windowName;
					_es.dispatchESEvent( _displayManagerEvent );					
				}
			}
		}
		
		public function removeSubScreen( whichScreen:String ):void 
		{
			searchSubScreen( whichScreen, true, false );
		}
		
		public function loadScreen( whichScreen:String ):void {
			
			if ( _currentScreen != null ) {
				_currentScreen.clearWindow();
			}
			
			if ( !searchScreen( whichScreen, false, true ) ) {
				//trace( whichScreen + " Does not exist..." );
			}else{			
				if ( _currentScreen != null && _displayManagerHolder != null ) {					
					_displayManagerHolder.addChild( _currentScreen );
					_currentScreen.initWindow();
					_displayManagerEvent = new DisplayManagerEvent( DisplayManagerEvent.LOAD_SCREEN );
					_displayManagerEvent.windowName = _currentScreen.windowName;
					_es.dispatchESEvent( _displayManagerEvent );
					//trace( whichScreen +  " has been loaded.. ", "childCount", this.numChildren );
				}
			}
		}
		
		public function addScreen( screen:Window ):void 
		{			
			if ( !searchScreen( screen.windowName ) ) {				
				_screens.push( screen );				
				//trace( "added screen", screen.windowName );
			}else {
				throw( "That Window is Already Exists!" );
			}
			//trace( "screen count: ",_screens.length );
		}	
		
		public function removeScreen( whichScreen:String ):void 
		{
			//trace( "# of screen before remove", _screens.length );
			if ( searchScreen( whichScreen, true ) ) {
				//trace( whichScreen + " has been removed!!" );
			}else {
				//trace( whichScreen + " does not exists!!" );
			}
			//trace( "# of screen after remove", _screens.length );
		}		
		
		private function searchSubScreen( screenName:String , remove:Boolean = false, load:Boolean =false ):Object 
		{
			var obj:Object = new Object();
			obj.found = false;
			obj.screen = null;
			
			for (var i:int = 0; i < _screens.length; i++)
			{
				if ( _screens[ i ].windowName ==  screenName ){
					obj.found = true;
					obj.screen = _screens[ i ];
					
					if ( remove ){
						if ( obj.screen != null ) {
							if ( _subScreenHolder.contains( obj.screen ) ) {
								obj.screen.clearWindow();								
								_subScreenHolder.removeChild( obj.screen );								
							}
						}						
					}else if ( load ){
						obj.screen = _screens[ i ];
					}
					break;
				}
			}
			return obj;
		}		
		
		
		private function searchScreen( screenName:String , remove:Boolean = false, load:Boolean =false ):Boolean 
		{
			var found:Boolean = false;
			for (var i:int = 0; i < _screens.length; i++)
			{
				if ( _screens[ i ].windowName ==  screenName ){
					found = true;
					if ( remove ) {						
						_screens[ i ] = null;
						_screens.splice( i, 1 );
					}else if ( load ){
						_currentScreen = _screens[ i ];
					}
					break;
				}
			}
			return found;			
		}		
		
		/*--------------------------------------------------------Getters--------------------------------------------------------------------*/		
		public function get currentScreen():Window { return _currentScreen; }
		/*-------------------------------------------------------Setters---------------------------------------------------------------------*/		
		public function set currentScreen(value:Window):void 
		{
			_currentScreen = value;
		}
		/*-------------------------------------------------------EventHandler----------------------------------------------------------------*/				
		
		private function collectGarbage ( e:Event ):void 
		{
			destroy();
			removeEventListener( Event.REMOVED_FROM_STAGE, collectGarbage );			
			//trace( "Display Manager Garbage Collected!.." );
		}		
	}

}

class SingletonEnforcer { }