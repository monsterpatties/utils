package com.monsterPatties.data 
{
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class GameData 
	{
		
		/*----------------------------------------------------------------------------------Constant-----------------------------------------------------*/
		
		/*----------------------------------------------------------------------------------Properties-----------------------------------------------------*/
		//the level has been loaded
		private var _currentLevel:int;
		
		//the actual progress of level
		private var _level:int;
		
		//score of each level
		private var _levelHighScores:Array = [ 0, 0, 0, 0, 0 ];
		
		public const MAXLEVEL:int = 10;
		
		//the score in current level
		private var _score:int;
		
		/*----------------------------------------------------------------------------------Constructor-----------------------------------------------------*/
		
		public function GameData() 
		{
			
		}		
		
		/*----------------------------------------------------------------------------------Methods-----------------------------------------------------*/
		
		/*----------------------------------------------------------------------------------Setters-----------------------------------------------------*/
		public function set currentLevel(value:int):void 
		{
			_currentLevel = value;
		}
		public function set level(value:int):void 
		{
			_level = value;
		}
		public function set levelHighScores(value:Array):void 
		{
			_levelHighScores = value;
		}
		public function set score(value:int):void 
		{
			_score = value;
		}		
		
		/*----------------------------------------------------------------------------------Getters-----------------------------------------------------*/
		public function get currentLevel():int { return _currentLevel; }		
		
		public function get level():int { return _level; }	
		
		public function get levelHighScores():Array { return _levelHighScores; }		
		
		public function get score():int { return _score; }	
		
		/*----------------------------------------------------------------------------------EventHandlers-----------------------------------------------*/
		
	}

}