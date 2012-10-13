package com.monsterPatties.controllers 
{
	import com.monsterPatties.config.GameConfig;
	import com.monsterPatties.data.GameData;
	import com.monsterPatties.utils.kongregateApi.Kong;
	
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
		private var _kong:Kong;		
		/*-------------------------------------------------------------------Constructor-------------------------------------------*/
		
		public function GameDataController( enforcer:SingletonEnforcer  ) 
		{			
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
			setScore( 0 );
			setMoney( 0 );
            setLive( 3 );
			setHiScore( 0 );
			setTotalMoney( 0 );			
			setIsKeyCollected( false );
			setGold( 0 );
			setSilver( 0 );
			setBronze( 0 );
			setCrystal( 0 );
			
			setTotalGold( 0 );
			setTotalSilver( 0 );
			setTotalBronze( 0 );
			setTotalCrystal( 0 );
			
			//load upgrade here if there's save upgrade in shared object
			
			_gameData.level = 0;
			_gameData.currLevel = 0;			
			trace( "[GameDataController]: init....");
		}
		
		public function retry():void 
		{            
			
			//setScore( 0 );
			setMoney( 0 );
            //setLive( 3 );
			setPausedGame( false );
			setIsKeyCollected( false );
			
			setGold( 0 );
			setSilver( 0 );
			setBronze( 0 );
			setCrystal( 0 );		
		}		
		
		/*-------------------------------------------------------------------Methods----------------------------------------------*/				
		
		/*-------------------------------------------------------------------Setters----------------------------------------------*/
		public function setScore( val:int ):void {
			_gameData.score = val;
		}
		
		public function updateScore( val:int ):void {			
			_gameData.score += val;
		}
        
        public function setHiScore( val:int ):void {
			_gameData.hiScore = val;
		}
        
        public function updateHiScore( val:int ):void {			
			_gameData.hiScore += val;
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
		
		public function setLevel( val:int ):void 
		{
			_gameData.level = val;
		}
		
		public function updateLevel( val:int ):void 
		{		
			_gameData.level += val;			
		}		
		
		public function setCurrLevel( val:int ):void 
		{			
            _gameData.currLevel = val;
		}
		
		public function updateCurrLevel( val:int ):void 
		{			
			_gameData.currLevel += val;			
		}		
		
		public function updateMoney(val:int ):void 
		{
			_gameData.money += val;
		}
		
		public function setMoney(val:int ):void 
		{
			_gameData.money = val;
		}		
		
		public function setTotalMoney( val:int ):void 
		{
			_gameData.totalMoney = val;
		}
		
		public function updateTotalMoney( val:int ):void 
		{
			_gameData.totalMoney += val;
		}
		
		public function setTotalScore( val:int ):void 
		{
			_gameData.totalScore = val;
		}
		
		public function updateTotalScore( val:int ):void 
		{
			_gameData.totalScore += val;
		}	
		
		//new cave smash data		
		public function setIsKeyCollected( val:Boolean ):void {
			_gameData.isKeyCollected = val;
		}	
		
		public function setGold(val:int ):void 
		{
			_gameData.gold = val;
		}
		
		public function setTotalGold(val:int ):void 
		{
			_gameData.totalGold = val;
		}
		
		public function updateGold(val:int ):void 
		{
			_gameData.gold += val;
		}	
		
		public function setSilver(val:int ):void 
		{
			_gameData.silver = val;
		}
		
		public function setTotalSilver(val:int ):void 
		{
			_gameData.totalSilver = val;
		}
		
		public function updateSilver(val:int ):void 
		{
			_gameData.silver += val;
		}	
		
		public function setBronze(val:int ):void 
		{
			_gameData.bronze = val;
		}
		
		public function setTotalBronze(val:int ):void 
		{
			_gameData.totalBronze = val;
		}
		
		public function updateBronze(val:int ):void 
		{
			_gameData.bronze += val;
		}	
		
		public function setCrystal(val:int ):void 
		{
			_gameData.crystal = val;
		}
		
		public function setTotalCrystal(val:int ):void 
		{
			_gameData.totalCrystal = val;
		}
		
		public function updateCrystal(val:int ):void 
		{
			_gameData.crystal += val;
		}		
		
		public function setDir( val:int ):void 
		{
			_gameData.direction = val;
		}
		/*-------------------------------------------------------------------Getters----------------------------------------------*/
		public function getScore():int 
		{
			return _gameData.score;
		}
        
        public function getHiScore():int 
		{
			return _gameData.hiScore;
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
			if ( _gameData.live >= 3 ) {
				_gameData.live = 3;
			}
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
		
		public function getLevel(  ):int 
		{
			return _gameData.level;
		}		
		
		public function getCurrLevel(  ):int 
		{
			return _gameData.currLevel;
		}		
		public function getMoney():int 
		{
			return _gameData.money;
		}	
		
		public function getTotalMoney( ):int 
		{
			return _gameData.totalMoney;
		}
		
		public function getTotalScore( ):int 
		{
			return _gameData.totalScore;
		}
		
		//new cave smash data
		
		public function getIsKeyCollected(  ):Boolean{
			return _gameData.isKeyCollected;
		}
		
		
		public function getGold(  ):int 
		{
			return _gameData.gold;
		}
		
		public function getSilver(  ):int 
		{
			return _gameData.silver;
		}
		
		public function getBronze(  ):int 
		{
			return _gameData.bronze;
		}
		
		public function getCrystal(  ):int 
		{
			return _gameData.crystal;
		}
		
		public function getTotalGold():int
		{
			return _gameData.totalGold;
		}
		
		public function getTotalSilver():int
		{
			return _gameData.totalSilver;
		}
		
		public function getTotalBronze():int
		{
			return _gameData.totalBronze;
		}
		
		public function getTotalCrystal():int
		{
			return _gameData.totalCrystal;
		}
		
		public function getDir(  ):int 
		{
			return _gameData.direction;
		}
		/*-------------------------------------------------------------------EventHandlers----------------------------------------*/	
	}
}

class SingletonEnforcer {}

