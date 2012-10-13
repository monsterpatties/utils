package com.monsterPatties.components 
{
	import com.greensock.TweenLite;
	import com.monsterPatties.controllers.GameDataController;
	import com.monsterPatties.data.GameData;
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author jc
	 */
	public class LevelCompletePrompt extends Sprite
	{
		
		/*----------------------------------------------------------------Constant------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------Properties----------------------------------------------------------------*/
		private var _mc:LevelCompletePromptMC;
		private var _bm:ButtonManager;
		private var _xpos:Number;
		private var _ypos:Number;
		private var _gdc:GameDataController;
		private var _dm:DisplayManager;
		/*----------------------------------------------------------------Constructor------------------------------------------------------------------*/
		
		public function LevelCompletePrompt( xpos:Number, ypos:Number ) 
		{
			_xpos = xpos;
			_ypos = ypos;
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*----------------------------------------------------------------Methods------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new LevelCompletePromptMC();
			addChild( _mc );
			_mc.x = _xpos;
			_mc.y = _ypos;
			_mc.addFrameScript( _mc.totalFrames - 1, onEndAnimation );
			
			_dm = DisplayManager.getInstance();
			_gdc = GameDataController.getInstance();
			var itemCollected:int = _gdc.getItemCollected();            
			var goal:int = GameData.TARGET_START * (_gdc.getLevel() + 1);
			
			var level:int = _gdc.getLevel() + 1;			
			_mc.txtLevel.text = " Level " + level;
			_mc.txtTarget.text = itemCollected + " / " + goal;
			
			_bm = new ButtonManager();			
			_bm.addBtnListener( _mc.nextBtn );            
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {				 
                _bm.removeBtnListener( _mc.nextBtn );                
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
		
		private function onEndAnimation():void 
		{
			_mc.stop();
		}
		
		private function loadGameScreen():void 
		{
			_gdc.retry();
			_dm.loadScreen( DisplayManagerConfig.GAME_SCREEN );
		}
		/*----------------------------------------------------------------Setters------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------Getters------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------EventHandlers------------------------------------------------------------*/
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{				
				case "nextBtn":
					_mc.nextBtn.gotoAndStop( 1 );
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
				case "nextBtn":
					_mc.nextBtn.gotoAndStop( 2 );
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
				case "nextBtn":
					//TweenLite.to( this.root, 0.5, { alpha:0, onComplete:loadGameScreen } );
                    _mc.nextBtn.gotoAndStop( 3 );
                    loadGameScreen();										
				break;				
				
				default:
				break;
			}
		}
	}

}