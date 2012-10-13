package com.monsterPatties.views
{
	import com.greensock.TweenLite;
	import com.monsterPatties.events.CaveSmashEvent;
	import com.monsterPatties.events.GameEvent;
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.Window;
	import com.monsterPatties.utils.eventSatellite.EventSatellite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author jc
	 */
	public class PausedScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/
		private var _mc:PausedWindowMC;
		private var _bm:ButtonManager;
		private var _dm:DisplayManager;
		private var _gameEvent:GameEvent;
		private var _es:EventSatellite;
		private var _caveSmashevent:CaveSmashEvent;
		
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function PausedScreen(windowName:String, winWidth:Number = 0, winHeight:Number = 0, hideWindowName:Boolean = false)
		{
			super(windowName, winWidth, winHeight);
		}
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void
		{
			_es = EventSatellite.getInstance();
			_mc = new PausedWindowMC();
			addChild(_mc);
			
			_bm = new ButtonManager();
			_bm.addBtnListener(_mc.resumeBtn);
			_bm.addBtnListener(_mc.shopBtn);
			_bm.addBtnListener(_mc.retryBtn);
			_bm.addEventListener(ButtonEvent.CLICK_BUTTON, onClickBtn);			
			
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
				_bm.removeBtnListener(_mc.shopBtn);
				_bm.removeBtnListener(_mc.retryBtn);
				_bm.removeEventListener(ButtonEvent.CLICK_BUTTON, onClickBtn);				
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
		
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/
			
		private function onClickBtn(e:ButtonEvent):void
		{
			var btnName:String = e.obj.name;
			
			switch (btnName)
			{
				case "resumeBtn":
					_gameEvent = new GameEvent(GameEvent.GAME_UNPAUSED);
					_es.dispatchESEvent(_gameEvent);
					_dm.removeSubScreen(DisplayManagerConfig.PAUSED_SCREEN);
					break;
				
				case "shopBtn": 					
					break;
				
				case "retryBtn":
					_dm.removeSubScreen(DisplayManagerConfig.PAUSED_SCREEN);
					
					_gameEvent = new GameEvent(GameEvent.GAME_UNPAUSED);
					_es.dispatchESEvent(_gameEvent);
					
					_caveSmashevent = new CaveSmashEvent( CaveSmashEvent.RELOAD_LEVEL );
					_es.dispatchESEvent( _caveSmashevent );
					break;
				
				default: 
					break;
			}
		}		
	}
}