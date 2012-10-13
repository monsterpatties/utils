package com.monsterPatties.views
{
	import com.greensock.TweenLite;
	import com.monsterPatties.events.GameEvent;
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.Window;
	import com.monsterPatties.utils.eventSatellite.EventSatellite;
	import flash.display.StageQuality;
	
	/**
	 * ...
	 * @author jc
	 */
	public class SettingScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/
		private var _mc:SettingsWindowMC;
		private var _bm:ButtonManager;
		private var _dm:DisplayManager;
		private var _gameEvent:GameEvent;
		private var _es:EventSatellite;
		
		private var _isLow:Boolean = false;
		private var _isHigh:Boolean = true;
		private var _isMedium:Boolean = false;
		
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function SettingScreen(windowName:String, winWidth:Number = 0, winHeight:Number = 0, hideWindowName:Boolean = false)
		{
			super(windowName, winWidth, winHeight);
		}
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void
		{
			_es = EventSatellite.getInstance();
			_mc = new SettingsWindowMC();
			addChild(_mc);
			
			_bm = new ButtonManager();
			_bm.addBtnListener(_mc.resumeBtn);
			_bm.addBtnListener(_mc.highBtn);
			_bm.addBtnListener(_mc.mediumBtn);
			_bm.addBtnListener(_mc.lowBtn);
			_bm.addEventListener(ButtonEvent.CLICK_BUTTON, onClickBtn);
			_bm.addEventListener(ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn);
			_bm.addEventListener(ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn);
			
			checkVideoSettings();
			TweenLite.delayedCall( 0.1, callPaused );			
		}
		
		private function callPaused():void 
		{
			TweenLite.killDelayedCallsTo( callPaused );
			_gameEvent = new GameEvent( GameEvent.GAME_PAUSED );
			_es.dispatchESEvent( _gameEvent );			
		}
		
		private function removeDisplay():void
		{
			if (_mc != null)
			{
				
				_bm.removeBtnListener(_mc.resumeBtn);
				_bm.removeBtnListener(_mc.highBtn);
				_bm.removeBtnListener(_mc.mediumBtn);
				_bm.removeBtnListener(_mc.lowBtn);
				_bm.removeEventListener(ButtonEvent.CLICK_BUTTON, onClickBtn);
				_bm.removeEventListener(ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn);
				_bm.removeEventListener(ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn);
				_bm.clearButtons();
				_bm = null;
				
				if (this.contains(_mc))
				{
					this.removeChild(_mc);
					_mc = null;
				}
			}
		}
		
		override public function initWindow():void
		{
			super.initWindow();
			initControllers();
			setDisplay();
			trace(windowName + " init!!");
		}
		
		override public function clearWindow():void
		{
			super.clearWindow();
			removeDisplay();
			trace(windowName + " destroyed!!");
		}
		
		private function initControllers():void
		{
			_dm = DisplayManager.getInstance();
		}
		
		private function checkVideoSettings():void 
		{
			if ( _isHigh ) {
				_mc.highBtn.gotoAndStop(2);
				_mc.mediumBtn.gotoAndStop(1);
				_mc.lowBtn.gotoAndStop(1);
			}else if ( _isMedium ) {
				_mc.highBtn.gotoAndStop(1);
				_mc.mediumBtn.gotoAndStop(2);
				_mc.lowBtn.gotoAndStop(1);
			}else{ 
				_mc.highBtn.gotoAndStop(1);
				_mc.mediumBtn.gotoAndStop(1);
				_mc.lowBtn.gotoAndStop(2);
			}
		}
		
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/
		private function onRollOutBtn(e:ButtonEvent):void
		{
			var btnName:String = e.obj.name;
			
			switch (btnName)
			{
				case "resumeBtn": 
					_mc.resumeBtn.gotoAndStop(1);
					break;
				
				default: 
					break;
			}
		}
		
		private function onRollOverBtn(e:ButtonEvent):void
		{
			var btnName:String = e.obj.name;
			
			switch (btnName)
			{
				case "resumeBtn": 
					_mc.resumeBtn.gotoAndStop(2);
					break;
				
				default: 
					break;
			}
		}
		
		private function onClickBtn(e:ButtonEvent):void
		{
			var btnName:String = e.obj.name;
			
			switch (btnName)
			{
				case "resumeBtn": 
					_mc.resumeBtn.gotoAndStop(3);
					_dm.removeSubScreen(DisplayManagerConfig.SETTING_SCREEN);
					_gameEvent = new GameEvent(GameEvent.GAME_UNPAUSED);					
					_es.dispatchESEvent(_gameEvent);
					break;
				
				case "highBtn": 
					if ( !_isHigh ) {
						_isHigh = true;
						_isMedium = false;
						_isLow = false;
						stage.quality = StageQuality.HIGH;
					}else {
						_isHigh = false;						
					}
					checkVideoSettings();
					break;
				
				case "mediumBtn": 
					if (!_isMedium){						
						stage.quality = StageQuality.MEDIUM;
						_isMedium = true;
						_isHigh = false;
						_isLow = false;
					}else{						
						_isMedium = false;
					}
					checkVideoSettings();
					break;
				
				case "lowBtn": 
					if (!_isLow){						
						stage.quality = StageQuality.LOW;
						_isLow = true;
						_isMedium = false;
						_isHigh = false;						
					}else{						
						_isLow = false;
					}
					checkVideoSettings();
					break;
				
				default: 
					break;
			}
		}
	
	}

}