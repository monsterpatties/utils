package com.monsterPatties.utils.displayQualityManager 
{
	import flash.display.DisplayObject;
	import flash.display.StageQuality;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class DisplayQualityManager 
	{
		/*-----------------------------------------------------------------------------------Constant--------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------Properties------------------------------------------------------------*/
		private static var _instance:DisplayQualityManager;
		/*-----------------------------------------------------------------------------------Constructor--------------------------------------------------------------*/
		
		
		public function DisplayQualityManager( enforcer:SingletonEnforcer ) 
		{
			init();
		}
		
		public static function getInstance():DisplayQualityManager 
		{
			if ( DisplayQualityManager._instance == null ) {
				DisplayQualityManager._instance = new DisplayQualityManager( new SingletonEnforcer() );
			}
			
			return DisplayQualityManager._instance;
		}
		
		/*-----------------------------------------------------------------------------------Methods--------------------------------------------------------------*/
		public function changeQuality( stage:Object, type:int = 0 ):void 
		{
			if ( type == 0 ) {
				stage.quality = StageQuality.BEST;
			}else if ( type == 1 ) {
				stage.quality = StageQuality.HIGH;
			}else if ( type == 2 ) {
				stage.quality = StageQuality.MEDIUM;
			}else if ( type == 3 ) {
				stage.quality = StageQuality.LOW;
			}			
		}
		
		private function init():void 
		{
			trace( "init displayQualityManager........" );
		}
		/*-----------------------------------------------------------------------------------Setters--------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------Getters--------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------EventHandlers--------------------------------------------------------*/
		
	}
}

class SingletonEnforcer {}