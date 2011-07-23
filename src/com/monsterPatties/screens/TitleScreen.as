package com.monsterPatties.screens 
{		
	import com.monsterPatties.controllers.GameDataController;	
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.Window;		
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author jc
	 */
	public class TitleScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/		
		private var _windowBg:WindowGraphic;
		private var _gameDataController:GameDataController;
		private var _dm:DisplayManager;
		private var _bm:ButtonManager;		
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function TitleScreen ( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
		{			
			super( windowName , winWidth, winHeight );
		}		
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_windowBg = new WindowGraphic();
			addChild( _windowBg );
			_windowBg.txtWindowName.text = windowName;
		}
		
		private function removeDisplay():void 
		{			
			if ( _windowBg != null ) {				
				if ( this.contains( _windowBg ) ) {
					this.removeChild( _windowBg );
					_windowBg = null;
				}
			}
		}
		
		override public function initWindow():void 
		{
			super.initWindow();			
			prepareControllers();
			setDisplay(  );				
			trace( windowName + " init!!" );
		}
		
		override public function clearWindow():void 
		{			
			super.clearWindow();			
			removeDisplay();
			trace( windowName + " destroyed!!" );
		}	
		
		private function prepareControllers():void 
		{
			_gameDataController = GameDataController.getInstance();
			_dm = DisplayManager.getInstance();
			_bm = new ButtonManager();
		}
		
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/		
		
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/				
	}

}