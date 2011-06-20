
package com.monsterPatties.test.sampleWindows 
{		
	import com.monsterPatties.config.GameConfig;	
	import com.monsterPatties.events.GameEvent;	
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.Window;	
	import com.monsterPatties.utils.interfaces.IDestroyable;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author jc
	 */
	public class SampleScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/		
		private var _windowBg:WindowGraphic;		
		private var _dm:DisplayManager;
		private var _bm:ButtonManager;		
		
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function SampleScreen ( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
		{			
			super( windowName , winWidth, winHeight, hideWindowName );
		}		
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_windowBg = new WindowGraphic();
			addWindowBg(_windowBg );
			
			//_bm.addBtnListener( _windowBg.menuBtn );			_
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickButton );			
		}
		
		private function removeDisplay():void 
		{
			if ( _windowBg != null ) {
				//_bm.removeBtnListener( _windowBg.menuBtn );				
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickButton );
				_bm.clearButtons();
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
		}
		
		override public function clearWindow():void 
		{			
			super.clearWindow();			
			removeDisplay();
			trace( windowName + " destroyed!!" );
		}	
		
		private function prepareControllers():void 
		{			
			_dm = DisplayManager.getInstance();
			_bm = new ButtonManager();
		}	
		
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/		
		
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/
		
		private function onClickButton(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;			
			
			switch ( btnName ) 
			{
				case "menuBtn":
					_dm.loadScreen( DisplayManagerConfig.TITLE_SCREEN );
				break;				
				
				default:
					
				break;
			}
		}		
	}

}