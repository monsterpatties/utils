package com.monsterPatties.controllers 
{
	import com.monsterPatties.data.AccountData;
	import com.monsterPatties.data.ApplicationData;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class GameDataController 
	{
		
		/*--------------------------------------------------------------------------Constant-------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------Properties-----------------------------------------------------------------*/
		private static var _instance:GameDataController;
		private var _applicationData:ApplicationData;
		private var _accountData:AccountData;
		/*--------------------------------------------------------------------------Constructor----------------------------------------------------------------*/
		
		
		public function GameDataController( enforcer:SingletonEnforcer ) 
		{
			
		}
		
		public static function getInstance():GameDataController 
		{
			if ( GameDataController._instance == null ) {
				GameDataController._instance = new GameDataController( new SingletonEnforcer() );
			}
			
			return GameDataController._instance;
		}
		
		/*--------------------------------------------------------------------------Methods-------------------------------------------------------------------*/
		private function init():void 
		{
			_applicationData = ApplicationData.getIntance();
			_accountData = AccountData.getIntance();
		}
		/*--------------------------------------------------------------------------Setters-------------------------------------------------------------------*/
		public function setCurrenLevel( val:int ):void 
		{
			_applicationData.gameData.currentLevel = val;
		}
		
		public function nextCurrenLevel( val:int ):void 
		{
			if( ( _applicationData.gameData.currentLevel + 1 ) < _applicationData.gameData.MAXLEVEL ){
				_applicationData.gameData.currentLevel++;
			}
		}
		
		public function prevCurrenLevel( val:int ):void 
		{
			if( ( _applicationData.gameData.currentLevel - 1 ) > 0 ){
				_applicationData.gameData.currentLevel--;
			}
		}
		
		public function setLevel( val:int ):void 
		{
			_applicationData.gameData.level = val;
		}
		
		public function setScore( val:int ):void 
		{
			_applicationData.gameData.score = val;
		}
		
		public function addScore( val:int ):void 
		{
			_applicationData.gameData.score += val;
		}
		
		public function setLevelHighScores( index:int , val:int ):void 
		{
			_applicationData.gameData.levelHighScores[ index ] = val;
		}
		
		/*--------------------------------------------------------------------------Getters-------------------------------------------------------------------*/
		public function getCurrenLevel(  ):int 
		{
			return _applicationData.gameData.currentLevel;
		}
		
		public function getLevel(  ):int 
		{
			return _applicationData.gameData.level;
		}
		
		public function getScore(  ):int 
		{
			return _applicationData.gameData.score;
		}
		
		public function getLevelHighScores( index:int ):int 
		{
			return _applicationData.gameData.levelHighScores[ index ];
		}
		
		public function getTotalLevelHighScores(  ):int 
		{
			var total:int;
			for each ( var a:* in _applicationData.gameData.levelHighScores ) 
			{
				total += a;
			}
			
			return total;
		}
		/*--------------------------------------------------------------------------EventHandlers-------------------------------------------------------------*/
		
	}
}

class SingletonEnforcer{}