package com.monsterPatties.views 
{
    import com.monsterPatties.controllers.MochiController;
    import com.monsterPatties.controllers.GameDataController;
    import com.monsterPatties.events.GameEvent;
    import com.monsterPatties.utils.buttonManager.ButtonManager;
    import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
    import com.monsterPatties.utils.displayManager.*;
    import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
    import com.monsterPatties.utils.eventSatellite.EventSatellite;
    import com.monsterPatties.utils.soundManager.SoundManager;
	/**
	 * ...
	 * @author jc
	 */
	public class GameCompleteScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/				
		private var _mc:GameCompleteMC;		
		private var _bm:ButtonManager;
		private var _gc:MochiController;
		private var _dm:DisplayManager;
		
		private var _es:EventSatellite;
		private var _gameEvent:GameEvent;
		private var _soundManager:SoundManager;
        private var _gdc:GameDataController;
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function GameCompleteScreen( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
		{			
			super( windowName , winWidth, winHeight );
		}		
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void 
		{		
			initControllers();
			_mc = new GameCompleteMC();
			addChild( _mc );			
			
			_gc = MochiController.getInstance();
			_bm = new ButtonManager();			
			_bm.addBtnListener( _mc.okBtn );
            //_bm.addBtnListener( _mc.sponsorBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}		
		
		private function removeDisplay():void 
		{				
			if ( _mc != null ){
				_bm.removeBtnListener( _mc.okBtn );
				//_bm.removeBtnListener( _mc.sponsorBtn );
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
			_dm = DisplayManager.getInstance();
			_es = EventSatellite.getInstance();			
			_gdc = GameDataController.getInstance();
            
			//_soundManager =  SoundManager.getInstance();			
			//_soundManager.selectBgMusic( "bgm1" );
			//_soundManager.SetBgmVolume( .4 );
			//_soundManager.playBgMusic();
		}
		
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/		
		
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{				
				case "okBtn":
					_mc.okBtn.gotoAndStop( 1 );
				break;			
                
                //case "sponsorBtn":
					//_mc.sponsorBtn.gotoAndStop( 1 );
				//break;
				
				
				default:
				break;
			}
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{			
				case "okBtn":
					_mc.okBtn.gotoAndStop( 2 );
				break;
				
                //case "sponsorBtn":
					//_mc.sponsorBtn.gotoAndStop( 2 );
				//break;
				
				default:
				break;
			}
		}
		
		private function onClickBtn(e:ButtonEvent):void 
		{			
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{               
				case "okBtn":
					_mc.okBtn.gotoAndStop( 3 );
                    //_gdc.updateLevel( 1 );
                    //_gdc.retry();
					//_dm.removeSubScreen( DisplayManagerConfig.GAME_COMPLETE_SCREEN );
                    _dm.loadScreen( DisplayManagerConfig.TITLE_SCREEN );
                    //trace( "[GameComplete]: check level: " + _gdc.getLevel() );
                    
					//_dm.loadScreen( DisplayManagerConfig.TITLE_SCREEN );					
				break;				
                
                //case "sponsorBtn":
					//_mc.sponsorBtn.gotoAndStop( 3 );
                    //UrlNavigator.gotoUrl(GameConfig.SPONSOR_LINK);
				//break;
				
				default:
				break;
			}
		}
		
	}

}