package com.monsterPatties.views 
{
	import com.monsterPatties.controllers.GameController;
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.displayManager.*;
	/**
	 * ...
	 * @author jc
	 */
	public class PausedScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/				
		private var _mc:PausedMC;		
		private var _bm:ButtonManager;
		private var _gc:GameController;
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function PausedScreen( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
		{			
			super( windowName , winWidth, winHeight );
		}		
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void 
		{		
			_mc = new PausedMC();
			addChild( _mc );
			
			_mc.txtinfo.text = 	"press ( P ) to continue" + 
								"\n press( ESCAPE ) to title menu." + 
								"\n press ( W ) to Walkthrough";
			
			_gc = GameController.getInstance();
			_bm = new ButtonManager();			
			_bm.addBtnListener( _mc.logoBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}		
		
		private function removeDisplay():void 
		{				
			if ( _mc != null ){					
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
					_gc.gotoMySiteUsingLogo( _mc.logoBtn );
				break;
				
				default:
				break;
			}
		}
		
	}

}