package com.monsterPatties.views 
{			
	import com.monsterPatties.controllers.GameController;
	import com.monsterPatties.controllers.GameDataController;	
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.Window;
	/**
	 * ...
	 * @author jc
	 */
	public class GameOverScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/				
		private var _dm:DisplayManager;
		private var _bm:ButtonManager;
		private var _mc:GameOverDefaultMC;
		private var _gc:GameController;
		private var _gdc:GameDataController;
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function GameOverScreen ( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
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
			_mc = new GameOverDefaultMC();
			addChild( _mc );
			
			_mc.txtWindowName.text = "Game Over!!!";
			
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc.menuBtn );
			_bm.addBtnListener( _mc.tryAGain );
			_bm.addBtnListener( _mc.moreGamesBtn );
			_bm.addBtnListener( _mc.submitScoreBtn );
			_bm.addBtnListener( _mc.myLogoBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}	
		
		private function removeDisplay():void 
		{				
			if ( _mc != null ) {
				_bm.removeBtnListener( _mc.menuBtn );
				_bm.removeBtnListener( _mc.tryAGain );
				_bm.removeBtnListener( _mc.moreGamesBtn );	
				_bm.removeBtnListener( _mc.submitScoreBtn );
				_bm.removeBtnListener( _mc.myLogoBtn );
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
			_gdc = GameDataController.getInstance();
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
				case "tryAGain":
					_mc.tryAGain.gotoAndStop( 1 );
				break;
				
				case "moreGamesBtn":
					_mc.moreGamesBtn.gotoAndStop( 1 );
				break;
				
				case "menuBtn":
					_mc.menuBtn.gotoAndStop( 1 );
				break;
				
				case "submitScoreBtn":
					_mc.submitScoreBtn.gotoAndStop( 1 );
				break;
				
				case "myLogoBtn":
					_mc.myLogoBtn.gotoAndStop( 1 );
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
				case "tryAGain":
					_mc.tryAGain.gotoAndStop( 2 );
				break;
				
				case "moreGamesBtn":
					_mc.moreGamesBtn.gotoAndStop( 2 );
				break;
				
				case "menuBtn":
					_mc.menuBtn.gotoAndStop( 2 );
				break;
				
				case "submitScoreBtn":
					_mc.submitScoreBtn.gotoAndStop( 2 );
				break;
				
				case "myLogoBtn":
					_mc.myLogoBtn.gotoAndStop( 2 );
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
				case "tryAGain":
					_mc.tryAGain.gotoAndStop( 3 );
					_dm.loadScreen(DisplayManagerConfig.LEVEL_SELECTION_SCREEN);
				break;
				
				case "moreGamesBtn":
					_mc.moreGamesBtn.gotoAndStop( 3 );
					_gc.gotoMySiteUsingMoreGameBtn( _mc.moreGamesBtn );
				break;
				
				case "menuBtn":
					_mc.menuBtn.gotoAndStop( 3 );
					_dm.loadScreen(DisplayManagerConfig.TITLE_SCREEN);
				break;
				
				case "submitScoreBtn":
					_mc.submitScoreBtn.gotoAndStop( 3 );
				break;
				
				case "myLogoBtn":
					_mc.myLogoBtn.gotoAndStop( 3 );
					_gc.gotoMySiteUsingLogo( _mc.myLogoBtn );
				break;
				
				default:
				break;
			}
		}
	}

}