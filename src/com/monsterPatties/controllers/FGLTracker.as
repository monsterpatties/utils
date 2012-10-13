package com.monsterPatties.controllers 
{	
	import com.greensock.easing.Strong;
	import com.monsterPatties.config.GameConfig;	
	import FGL.GameTracker.GameTracker;
	import FGL.GameTracker.GameTrackerErrorEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author ...
	 */
	public class FGLTracker extends EventDispatcher
	{
		/*---------------------------------------------------------------Constant-----------------------------------------------------------*/
		
		/*---------------------------------------------------------------Properties-----------------------------------------------------------*/
		private static var _instance:FGLTracker;
		
		//FGL tracker
		private var _tracker:GameTracker;
		/*---------------------------------------------------------------Constructor-----------------------------------------------------------*/
		public function FGLTracker( enforcer:SingletonEnforcer ) 
		{
			init();
		}
		
		
		public static function getInstance():FGLTracker
		{
			if ( FGLTracker._instance == null ) {
				FGLTracker._instance = new FGLTracker( new SingletonEnforcer() );
			}
			
			return FGLTracker._instance;
		}
		
		private function init():void 
		{			
			if ( GameConfig.isFGL ) {
				_tracker = new GameTracker();
				_tracker.addEventListener( GameTracker.GAMETRACKER_CODING_ERROR, onGameTrackerCodingError );
				_tracker.addEventListener( GameTracker.GAMETRACKER_SERVER_ERROR, onGameTrackerServerError );
				trace("[FGLTracker] init...");
			}else {
				trace("[FGLTracker] is off FGL tracker will not going to work! please check game config...");
			}			
		}		
		
		/*---------------------------------------------------------------Methods-----------------------------------------------------------*/
		public function startGame( score:int, state:String ):void 
		{
			if( GameConfig.isFGL ){
				_tracker.beginGame( score, state);
				trace("[FGLTracker] begin game!...");
			}else {
				trace("[FGLTracker] is off FGL tracker will not going to work!...");
			}
		}
		
		public function endGame( score:int, state:String ):void 
		{
			if( GameConfig.isFGL ){
				_tracker.endGame( score, state);
				trace("[FGLTracker] end game!...");
			}else{
				trace("[FGLTracker] is off FGL tracker will not going to work!...");
			}
		}
		
		public function startLevel( currLevel:int,currScore:int, state:String ):void 
		{
			if( GameConfig.isFGL ){
				_tracker.beginLevel( currLevel, currScore, state );
				trace("[FGLTracker] begin level!...");
			}else {
				trace("[FGLTracker] is off FGL tracker will not going to work!...");
			}
		}
		
		public function endLevel( currScore:int, state:String ):void 
		{			
			if( GameConfig.isFGL ){
				_tracker.endLevel(  currScore, state );
				trace("[FGLTracker] end level!...");
			}else {
				trace("[FGLTracker] is off FGL tracker will not going to work!...");
			}
		}
		
		public function sendAlert( currScore:int, state:String, msg:String ):void 
		{			
			if( GameConfig.isFGL ){
				_tracker.alert( currScore, state, msg );
				trace("[FGLTracker] custom alert is called state: ", state,  "msg: ", msg  );
			}else {
				trace("[FGLTracker] is off FGL tracker will not going to work!...");
			}
		}
		
		
		/*---------------------------------------------------------------EventHandlers-----------------------------------------------------------*/
		private function onGameTrackerServerError(e:GameTrackerErrorEvent):void 
		{
			trace( "[FGL]: Tracker Error server error!!!",  e._msg );
		}
		
		private function onGameTrackerCodingError(e:GameTrackerErrorEvent):void 
		{
			trace( "[FGL]: Tracker Error coding error!!!",  e._msg );
		}		
	}
}

class SingletonEnforcer{}