package com.monsterPatties.views 
{	
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.Window;
	/**
	 * ...
	 * @author jc
	 */
	public class TitleScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/				
		private var _mc:TitleScreenMC;
		private var _bm:ButtonManager;
		private var _dm:DisplayManager;
		
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function TitleScreen( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
		{			
			super( windowName , winWidth, winHeight );
		}		
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void 
		{	
			_mc = new TitleScreenMC();
			addChild( _mc );
			_mc.x = -182;
			_mc.y = -56;
			
			_bm = new ButtonManager();			
			_bm.addBtnListener( _mc.playBtn );
			_bm.addBtnListener( _mc.howBtn );
			_bm.addBtnListener( _mc.moreGamesBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}		
		
		private function removeDisplay():void 
		{				
			if ( _mc != null ) {
				
				_bm.removeBtnListener( _mc.playBtn );
				_bm.removeBtnListener( _mc.howBtn );
				_bm.removeBtnListener( _mc.moreGamesBtn );
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
			initControllers();
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
                
				case "howBtn":
					_mc.howBtn.gotoAndStop( 1 );
				break;
				case "moreGamesBtn":
					_mc.moreGamesBtn.gotoAndStop( 1 );
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
				
				case "howBtn":
					_mc.howBtn.gotoAndStop( 2 );
				break;
				case "moreGamesBtn":
					_mc.moreGamesBtn.gotoAndStop( 2 );
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
					_dm.loadScreen( DisplayManagerConfig.GAME_SCREEN );
				break;
                
				case "howBtn":
					_mc.howBtn.gotoAndStop( 3 );
				break;
				
				case "moreGamesBtn":
					_mc.moreGamesBtn.gotoAndStop( 3 );
				break;
				
				default:
				break;
			}
		}
		
	}

}