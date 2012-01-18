package com.monsterPatties.views 
{		
	import com.monsterPatties.controllers.GameController;
	import com.monsterPatties.engine.GameEngine;
	import com.monsterPatties.engine.MultiPlayer;
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.Window;
	/**
	 * ...
	 * @author jc
	 */
	public class GameScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/				
		private var _dm:DisplayManager;
		private var _mc:GameScreenDefaultMC;
		private var _gameEngine:GameEngine;	
		private var _bm:ButtonManager;
		private var _gc:GameController;
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function GameScreen ( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
		{			
			super( windowName , winWidth, winHeight );			
		}		
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_gc = GameController.getInstance();
			_mc = new GameScreenDefaultMC();
			addChild( _mc );
			
			_gameEngine = new GameEngine();			
			addChild( _gameEngine );
			
			_bm = new ButtonManager();			
			_bm.addBtnListener( _mc.logoBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}		
		
		private function removeDisplay():void 
		{	
			if ( _mc != null ) {
				
				_bm.removeBtnListener( _mc.logoBtn );
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
			
			if ( _gameEngine != null ) {
				if ( this.contains( _gameEngine ) ) {
					this.removeChild( _gameEngine );
					_gameEngine = null;
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
			_dm = DisplayManager.getInstance();			
			//_dm.loadScreen( DisplayManagerConfig.GAME_OVER_SCREEN );
		}
		
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/		
		
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/				
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "logoBtn":
					_mc.logoBtn.gotoAndStop( 1 );
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
				case "logoBtn":
					_mc.logoBtn.gotoAndStop( 2 );
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
				case "logoBtn":
					_mc.logoBtn.gotoAndStop( 3 );
					trace( "logoBtn" );					
					_gc.gotoMySiteUsingLogo( _mc.logoBtn );
				break;
				
				
				default:
				break;
			}
		}
		
	}

}