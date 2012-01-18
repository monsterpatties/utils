package com.monsterPatties.views 
{			
	import com.monsterPatties.controllers.GameController;	
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.Window;
	import flash.display.MovieClip;
	import mochi.as3.MochiServices;
	/**
	 * ...
	 * @author jc
	 */
	public class HowToPlayScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/				
		private var _dm:DisplayManager;
		private var _bm:ButtonManager;
		private var _mc:HowToDefaultScreenMC;
		private var _gc:GameController;
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function HowToPlayScreen ( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
		{			
			super( windowName , winWidth, winHeight );
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
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void 
		{				
			_mc = new HowToDefaultScreenMC();
			addChild( _mc );
			
			_mc.txtWindowName.text = "How to Play";
			_mc.txtInstruction.text = "some intrcutions here! below you can add some images or animations describing on how to play this game";
			
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc.playBtn );			
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}	
		
		private function removeDisplay():void 
		{				
			if ( _mc != null ) {				
				_bm.removeBtnListener( _mc.playBtn );				
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
				_bm.clearButtons();
				_bm = null;
				
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}		
		
		private function prepareControllers():void 
		{			
			_dm = DisplayManager.getInstance();			
			_gc = GameController.getInstance();
		}
		
		
		
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/		
		
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/				
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "playBtn":
					_mc.playBtn.gotoAndStop( 1 );
				break;				
				
				default:
				break;
			}
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "playBtn":
					_mc.playBtn.gotoAndStop( 2 );
				break;			
				
				default:
				break;
			}
		}
		
		private function onClickBtn(e:ButtonEvent):void 
		{			
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "playBtn":
					_mc.playBtn.gotoAndStop( 3 );
					trace( "PLAYTBN" );
					//_dm.loadScreen( DisplayManagerConfig.GAME_SCREEN );
					_dm.loadScreen( DisplayManagerConfig.LEVEL_SELECTION_SCREEN );
				break;			
				
				default:
				break;
			}
		}
	}

}