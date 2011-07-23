package com.monsterPatties.data 
{
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ApplicationData 
	{
		
		/*---------------------------------------------------------------------------------Constant--------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------------Properties--------------------------------------------------------------------*/
		private static var _instance:ApplicationData;
		private var _gameData:GameData;
		/*---------------------------------------------------------------------------------Constructor--------------------------------------------------------------------*/
		
		public function ApplicationData( enforcer:SingletonEnforcer ) 
		{
			initData();
			trace( "init Application data.........." );
		}
		
		public static function getIntance():ApplicationData 
		{
			if ( ApplicationData._instance == null ) {
				ApplicationData._instance = new ApplicationData( new SingletonEnforcer() );
			}
			
			return  ApplicationData._instance;
		}
		
		/*---------------------------------------------------------------------------------Methods--------------------------------------------------------------------*/
		private function initData():void 
		{
			_gameData = new GameData();	
		}	
		
		/*---------------------------------------------------------------------------------Setters--------------------------------------------------------------------*/
		public function set gameData(value:GameData):void 
		{
			_gameData = value;
		}
		
		/*---------------------------------------------------------------------------------Getters--------------------------------------------------------------------*/
		public function get gameData():GameData { return _gameData; }
		/*---------------------------------------------------------------------------------EventHandlers--------------------------------------------------------------------*/
	}

}

class SingletonEnforcer {}