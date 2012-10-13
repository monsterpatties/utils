package com.monsterPatties.data 
{
	/**
	 * ...
	 * @author ...
	 */
	public class GameData 
	{		
		//data that will never change
		public static const maxLevel:int = 7;		
		
		//data that is always reset every new level
		public var isKeyCollected:Boolean;
		public var previousLevel:int = 0;
		public var currLevel:int = 0;		
		public var prevTime:String;
		public var curTime:String;				
		
		//data that is changing during gameplay
		public var totalSec:int;
		public var second:int;
		public var minute:int;
		public var hour:int;
		public var speed:int;
		public var live:int = 0;
		public var score:int = 0;
		public var money:int = 0;
		public var isPaused:Boolean;
		
		//data that changed rarely or every load of new game
		public var level:int = 0;
		public var totalScore:int = 0;
        public var hiScore:int = 0;
		public var totalMoney:int = 0;
		
		//new cave Smash specific data
		public var gold:int;
		public var silver:int;
		public var bronze:int;
		public var crystal:int;
		
		public var totalGold:int;
		public var totalSilver:int;
		public var totalBronze:int;
		public var totalCrystal:int;
		
		public var direction:int;		
		
		public function GameData() 
		{
			
		}
		
	}

}