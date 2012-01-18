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
	public class UpgradeScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/				
		private var _dm:DisplayManager;
		private var _bm:ButtonManager;
		private var _mc:UpgradeScreenDefaultMC;
		private var _gc:GameController;
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function UpgradeScreen ( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
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
			_mc = new UpgradeScreenDefaultMC();
			addChild( _mc );
			
			_mc.txtWindowName.text = "Upgrade Screen";
			
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc.backBtn );			
			_bm.addBtnListener( _mc.myLogoBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}	
		
		private function removeDisplay():void 
		{				
			if ( _mc != null ) {				
				_bm.removeBtnListener( _mc.backBtn );				
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
				case "backBtn":
					_mc.backBtn.gotoAndStop( 1 );
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
				case "backBtn":
					_mc.backBtn.gotoAndStop( 2 );
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
				case "backBtn":
					_dm.loadScreen( DisplayManagerConfig.LEVEL_SELECTION_SCREEN );					
				break;				
				
				case "myLogoBtn":
					_mc.myLogoBtn.gotoAndStop( 3 );
					trace( "myLogoBtn" );					
					_gc.gotoMySiteUsingLogo( _mc.myLogoBtn );
				break;
				
				
				default:
				break;
			}
		}
	}

}