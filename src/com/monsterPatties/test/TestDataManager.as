package com.monsterPatties.test 
{
	import com.monsterPatties.utils.dataManager.DataManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author jc
	 */
	public class TestDataManager extends Sprite
	{
		
		public function TestDataManager() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var dataManager:DataManager = new DataManager();
			
			//
			var url:String = "http://127.0.0.1/poker/testRequest.php";
			var url2:String = "http://127.0.0.1/poker/tester.php";
			var url3:String = "http://127.0.0.1/poker/textme.txt";		
			var url4:String = "http://127.0.0.1/poker/testValuePair.php";
			var url5:String = "http://tada.zeratool.net/index.php/dialog/json";
			var url6:String = "http://tada.zeratool.net/index.php/dialog/post";
			var url7:String = "http://127.0.0.1/poker/testNavi.php";
			var url8:String = "http://tada.zeratool.net/index.php/dialog/choose_payment";
			
			//req for jason ecnoded data
			//dataManager.sendRequest( url );
			
			//passed variables and recieve that variables
			//dataManager.sendRequestVariables( url4, false );
			dataManager.sendNavigateToUrl( url8, false, false );
		}
		
	}

}