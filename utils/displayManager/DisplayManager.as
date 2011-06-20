﻿package com.monsterPatties.utils.displayManager
{
	import com.monsterPatties.utils.displayManager.event.DisplayManagerEvent;
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
		
		private var _popUpWindows:Array;
		private var _popUpWindowHolder:Sprite;
		private var _currentPopUpWindow:Window;
		
		private var _displayManagerEvent:DisplayManagerEvent;
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
			addEventListener( Event.REMOVED_FROM_STAGE , collectGarbage );
			removeEventListener( Event.ADDED_TO_STAGE , init );						
			
			addDisplayManagerHolder();			
			preparePopUpWindowHolder();
			trace( "init displayManager" );			
		}
		
		public function destroy():void {
			removePopUpWindowHolder();			
			removeDisplayManagerHolder();			
		}	
		
		/*--------------------------------------------------------------Methods---------------------------------------------------------*/
		private function addDisplayManagerHolder():void {
			_screens = new Array();
			_displayManagerHolder = new Sprite();
			addChild( _displayManagerHolder );
		}
		
		private function removeDisplayManagerHolder():void {			
			if ( this.contains( _displayManagerHolder ) ) {
				this.removeChild( _displayManagerHolder );
				_displayManagerHolder = null;
			}
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
					dispatchEvent( _displayManagerEvent );
					//trace( whichScreen +  " has been loaded.. ", "childCount", this.numChildren );
				}
			}
		}
		
		
		public function loadPopUpWindow( whichPopUpWindow:String ):void {
			
			removeCurrentPopUpWindow();
			
			if ( !searchPopUpWindow( whichPopUpWindow, false, true ) ) {
				//trace( whichPopUpWindow + " Does not exist..." );
			}else{			
				if( _currentPopUpWindow != null && _popUpWindowHolder != null ){
					_popUpWindowHolder.addChild( _currentPopUpWindow );					
					//trace(whichPopUpWindow +  " has been loaded.. ", "childCount", _popUpWindowHolder.numChildren );
				}
			}
		}
		
		
		private function removeCurrentPopUpWindow():void {			
			if ( _currentPopUpWindow != null ) {
				if ( _popUpWindowHolder.contains( _currentPopUpWindow ) ) {					
					_popUpWindowHolder.removeChild( _currentPopUpWindow );					
					//trace( _currentPopUpWindow.windowName +  " has been remove.");
					_currentPopUpWindow = null;					
					//trace( "current Screen: " + _currentPopUpWindow );
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
		
		public function addPopWindow( popUpWindow:Window ):void 
		{			
			if ( !searchPopUpWindow( popUpWindow.windowName ) ) {				
				popUpWindow.addEventListener( DisplayManagerEvent.REMOVE_POP_UP_WINDOW, onRemovePopUpWindow );
				_popUpWindows.push( popUpWindow );				
				//trace( "added PopUpWindow", popUpWindow.windowName );
			}else {
				//trace( "That PopUpWindow is Already Exists!" );
			}
			//trace( "popUpWindow count: ",_popUpWindows.length );
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
		
		public function removePopUpWindow( whichPopUpWindow:String ):void 
		{
			//trace( "# of screen before remove", _popUpWindows.length );
			if ( searchPopUpWindow( whichPopUpWindow, true ) ) {
				//trace( whichPopUpWindow + " has been removed!!" );
			}else {
				//trace( whichPopUpWindow + " does not exists!!" );
			}
			//trace( "# PopUpWindows of  after remove", _popUpWindows.length );
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
		
		private function preparePopUpWindowHolder():void 
		{
			_popUpWindows = new Array();
			_popUpWindowHolder = new Sprite();
			addChild( _popUpWindowHolder );
		}
		
		private function removePopUpWindowHolder():void 
		{
			_popUpWindows.splice( 0 );
			_popUpWindows = null;
			if ( _popUpWindowHolder != null ) {
				if ( this.contains( _popUpWindowHolder ) ) {
					this.removeChild( _popUpWindowHolder );
					_popUpWindowHolder = null;
				}
			}
		}
		
		private function searchPopUpWindow( screenName:String , remove:Boolean = false, load:Boolean =false ):Boolean 
		{
			var found:Boolean = false;
			for (var i:int = 0; i < _popUpWindows.length; i++)
			{
				if ( _popUpWindows[ i ].windowName ==  screenName ){
					found = true;
					if ( remove ) {
						_popUpWindows[ i ].destroy();
						_popUpWindows.splice( i, 1 );
					}else if ( load ){
						_currentPopUpWindow = _popUpWindows[ i ];
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
		private function onRemovePopUpWindow(e:DisplayManagerEvent):void 
		{
			removePopUpWindow( e.windowName );
		}
		
		private function collectGarbage ( e:Event ):void 
		{
			destroy();
			removeEventListener( Event.REMOVED_FROM_STAGE, collectGarbage );			
			//trace( "Display Manager Garbage Collected!.." );
		}		
	}

}

class SingletonEnforcer { }