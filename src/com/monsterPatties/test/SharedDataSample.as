package com.monsterPatties.test 
{
	import com.monsterPatties.utils.sharedObjects.SharedData;
	/**
	 * ...
	 * @author jc
	 */
	public class SharedDataSample 
	{
		private var _currentLevel:int;
		private var _score:int;
		private static const CURRENT_LEVEL:String = "CURRENT_LEVEL";
		private static const TOTAL_SCORE:String = "TOTAL_SCORE";
		
		public function SharedDataSample() 
		{
			
		}		
		
		//load data
		public function loadData():void 
		{
			_sd = SharedData.getInstance();
			_currentLevel = _sd.getSharedData( CURRENT_LEVEL );
			_score = _sd.getSharedData( TOTAL_SCORE );
		}
		
		public function saveData():void 
		{
			_sd.addSharedData( CURRENT_LEVEL, _currentLevel );
			_sd.addSharedData( TOTAL_SCORE, _score );			
		}
		
		public function deleteData():void 
		{
			_sd.removeSharedData( CURRENT_LEVEL );
			_sd.removeSharedData( TOTAL_SCORE );
			loadData();			
		}		
		
	}

}