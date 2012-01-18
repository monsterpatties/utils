package com.monsterPatties.controllers 
{
	import com.monsterPatties.config.GameConfig;
	import com.monsterPatties.data.GameData;
	import com.monsterPatties.utils.kongregateApi.Kong;
	import com.monsterPatties.utils.soundManager.SoundManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameDataController 
	{
		
		/*-------------------------------------------------------------------Constant----------------------------------------------*/
		
		/*-------------------------------------------------------------------Properties--------------------------------------------*/
		private static var _instance:GameDataController;
		private var _gameData:GameData;
		private var _soundManager:SoundManager;
		private var _kong:Kong;
		/*-------------------------------------------------------------------Constructor-------------------------------------------*/
		
		public function GameDataController( enforcer:SingletonEnforcer  ) 
		{
			init();
		}
		
		public static function getInstance(  ):GameDataController 
		{
			if ( GameDataController._instance == null ) {
				GameDataController._instance = new GameDataController( new SingletonEnforcer() );
			}
			
			return GameDataController._instance;
		}
		
		
		public function init():void 
		{
			if ( GameConfig.isLive ) {
				if ( GameConfig.isKongregate ) {
					_kong = Kong.getInstance();					
				}
			}
			
			_gameData = new GameData();
			_gameData.score = 0;
			trace( "[GameDataController]: init....");
		}
		/*-------------------------------------------------------------------Methods----------------------------------------------*/
		
		/*-------------------------------------------------------------------Setters----------------------------------------------*/
		public function setScore( val:int ):void {
			_gameData.score = val;
		}
		
		public function updateScore( val:int ):void {
			_gameData.score += val;
		}
		
		public function setKongTime( time:String ):void 
		{			
			_kong.submitTime( time );
		}
		
		public function setLive( val:int ):void 
		{
			_gameData.live = val; 
		}
		
		public function setPrevTime( val:String ):void 
		{
			_gameData.prevTime = val;
		}
		
		public function setCurTime( val:String ):void 
		{
			_gameData.curTime = val;			
			//trace( "[GDC]  Curtime", _gameData.curTime );
		}
		
		public function setPausedGame( val:Boolean ):void 
		{
			_gameData.isPaused = val;
		}
		
		public function setSecond( val:int ):void 
		{
			_gameData.second = val;
		}
		
		public function updateSecond( val:int ):void 
		{
			_gameData.second += val;
		}
		
		public function setMinute( val:int ):void 
		{
			_gameData.minute = val;
		}
		
		public function updateMinute( val:int ):void 
		{
			_gameData.minute += val;
		}		
		
		public function setHour( val:int ):void 
		{
			_gameData.hour = val;
		}
		
		public function updateHour( val:int ):void 
		{
			_gameData.hour += val;
		}
		
		
		public function setSpeed( val:int ):void 
		{
			_gameData.speed = val;
		}
		
		public function updateSpeed( val:int ):void 
		{
			_gameData.speed += val;
		}		
		
		public function updateTotalSec( val:int ):void 
		{
			_gameData.totalSec += 1;
		}
		
		public function setTotalSec( val:int ):void 
		{
			_gameData.totalSec = val;
		}
		/*-------------------------------------------------------------------Getters----------------------------------------------*/
		public function getScore():int 
		{
			return _gameData.score;
		}
		
		public function getHour(  ):int
		{
			return _gameData.hour;
		}
		
		public function getMinute(  ):int
		{
			return _gameData.minute;
		}
		
		public function getSecond(  ):int
		{
			return _gameData.second;
		}
		
		public function getLive( ):int 
		{
			return _gameData.live;
		}
		
		public function updateLive( val:int ):void 
		{
			_gameData.live += val; 
		}	
		
		public function getPrevNyanTime(  ):String 
		{
			return _gameData.prevTime;
		}	
		
		public function getCurNyanTime(  ):String 
		{
			return _gameData.curTime;
		}	
		
		public function getPausedGame(  ):Boolean 
		{
			return _gameData.isPaused;
		}
		
		public function getSpeed( ):int 
		{
			return _gameData.speed;
		}
		
		public function getTotalSec():int 
		{
			return _gameData.totalSec;
		}
		/*-------------------------------------------------------------------EventHandlers----------------------------------------*/	
	}
}

class SingletonEnforcer {}

