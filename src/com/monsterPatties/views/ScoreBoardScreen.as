package com.monsterPatties.views 
{	
	import com.monsterPatties.utils.displayManager.Window;
	/**
	 * ...
	 * @author jc
	 */
	public class ScoreBoardScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/				
		
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function ScoreBoardScreen( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
		{			
			super( windowName , winWidth, winHeight );
		}		
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void 
		{	
			
		}		
		
		private function removeDisplay():void 
		{				
			
		}
		
		override public function initWindow():void 
		{
			super.initWindow();
			setDisplay(  );				
			trace( windowName + " init!!" );
		}
		
		override public function clearWindow():void 
		{			
			super.clearWindow();			
			removeDisplay();
			trace( windowName + " destroyed!!" );
		}
		
		private function initControllers():void 
		{
			
		}        
        
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/		
		
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/		
		
		
	}

}