package com.monsterPatties.views
{
	import com.monsterPatties.events.GameEvent;
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.Window;
	import com.monsterPatties.utils.eventSatellite.EventSatellite;
	
	/**
	 * ...
	 * @author jc
	 */
	public class LostFocusScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/
		private var _mc:LostFocuScreenMC;		
		private var _dm:DisplayManager;		
		
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function LostFocusScreen(windowName:String, winWidth:Number = 0, winHeight:Number = 0, hideWindowName:Boolean = false)
		{
			super(windowName, winWidth, winHeight);
		}
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void
		{
			_mc = new LostFocuScreenMC();
			addChild(_mc);			
		}
		
		private function removeDisplay():void
		{
			if (_mc != null)
			{
				if (this.contains(_mc))	{
					this.removeChild(_mc);
					_mc = null;
				}
			}
		}
		
		override public function initWindow():void
		{
			super.initWindow();
			initControllers();
			setDisplay();
			trace(windowName + " init!!");
		}
		
		override public function clearWindow():void
		{
			super.clearWindow();
			removeDisplay();
			trace(windowName + " destroyed!!");
		}
		
		private function initControllers():void
		{
			_dm = DisplayManager.getInstance();
		}
		
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/	
	}

}