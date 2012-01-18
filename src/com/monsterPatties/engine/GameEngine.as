package com.monsterPatties.engine 
{	
	import com.monsterPatties.controllers.GameDataController;
	import com.monsterPatties.controllers.GameKeyInput;
	import com.monsterPatties.events.GameEvent;
	import com.monsterPatties.networking.Conn;	
	import com.monsterPatties.ui.LiveUI;
	import com.monsterPatties.ui.ScoreUI;
	import com.monsterPatties.ui.SoundUI;
	import com.monsterPatties.ui.TimerUI;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.event.DisplayManagerEvent;
	import com.monsterPatties.utils.eventSatellite.EventSatellite;
	import com.monsterPatties.utils.soundManager.SoundManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class GameEngine extends Sprite
	{
		/*----------------------------------------------------------------Constant---------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------Properties-------------------------------------------------------------------*/				
		private var _gameHolder:Sprite;
		private var _gameKeyInput:GameKeyInput;
		private var _es:EventSatellite;
		private var _dm:DisplayManager;		
		private var _gdc:GameDataController;
		
		//GUI
		private var _guiHolder:Sprite;
		private var _timerUI:TimerUI;
		private var _liveUI:LiveUI;
		private var _scoreUI:ScoreUI;
		private var _soundUI:SoundUI;
		private var _soundManager:SoundManager;
		
		//networking
		//private var _connection:Conn;
		//add your game engine here
		//private var _game:*;
		
		/*----------------------------------------------------------------Constructor------------------------------------------------------------------*/
		
		
		public function GameEngine() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );					
			
			addGameControllers();			
			initGame();
			addGameloop();		
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
			removeGameloop();
			removeGameControllers();
			clearGame();		
		}
		
		/*----------------------------------------------------------------Methods---------------------------------------------------------------------*/
		private function initGame():void 
		{
			addHolders();
			addLiveUI();
			addTimerUI();
			addSoundUI();
		}
		
		private function clearGame():void 
		{	
			removeTimerUI();
			removeLiveUI();
			removeSoundUI();
			removeHolders();			
		}
		
		private function addGameControllers():void 
		{
			_gdc = GameDataController.getInstance();
			
			_es = EventSatellite.getInstance();
			_es.addEventListener( GameEvent.GAME_OVER, onGameOver );
			_es.addEventListener( GameEvent.GAME_EXIT, onGameExit );
			_es.addEventListener( GameEvent.GAME_PAUSED, onGamePaused );
			_es.addEventListener( GameEvent.GAME_UNPAUSED, onGameUnPaused );
			_es.addEventListener( DisplayManagerEvent.LOAD_SCREEN, onLoadScreen );
			
			_dm = DisplayManager.getInstance();
			
			_gameKeyInput = GameKeyInput.getIntance();
			_gameKeyInput.initKeyboardListener( stage );
			_soundManager = SoundManager.getInstance();
		}
		
		private function removeGameControllers():void 
		{
			_gameKeyInput.clearKeyboardListener();			
			_es = EventSatellite.getInstance();
			_es.removeEventListener( GameEvent.GAME_OVER, onGameOver );
			_es.removeEventListener( GameEvent.GAME_EXIT, onGameExit );
			_es.removeEventListener( GameEvent.GAME_PAUSED, onGamePaused );
			_es.removeEventListener( GameEvent.GAME_UNPAUSED, onGameUnPaused );
			_es.removeEventListener( DisplayManagerEvent.LOAD_SCREEN, onLoadScreen );		
		}
		
		private function addGameloop():void 
		{
			addEventListener( Event.ENTER_FRAME, onGameloop );
		}		
		
		private function removeGameloop():void 
		{
			removeEventListener( Event.ENTER_FRAME, onGameloop );
		}
		
		
		private function addHolders():void 
		{
			_gameHolder = new Sprite();
			addChild( _gameHolder );
			
			_guiHolder = new Sprite();
			addChild( _guiHolder );	
		}
		
		private function removeHolders():void 
		{
			if ( _gameHolder != null ) {
				if ( this.contains( _gameHolder ) ) {
					this.removeChild( _gameHolder );
					_gameHolder = null;
				}
			}
			
			if ( _guiHolder != null ) {
				if ( this.contains( _guiHolder ) ) {
					this.removeChild( _guiHolder );
					_guiHolder = null;
				}
			}
		}		
		
		private function addScoreUI():void 
		{
			_scoreUI = new ScoreUI( 0, 0 );
			_guiHolder.addChild( _scoreUI );			
		}
		
		private function removeScoreUI():void 
		{
			if ( _scoreUI != null ) {
				if ( _guiHolder.contains( _scoreUI ) ) {
					_guiHolder.removeChild( _scoreUI );
					_scoreUI = null;
				}
			}
		}
		
		private function addTimerUI():void 
		{
			_timerUI = new TimerUI( 465,430, 1000, false, 0, 3, 0 );
			_guiHolder.addChild( _timerUI );
		}
		
		private function removeTimerUI():void 
		{
			if ( _timerUI != null ) {
				if ( _guiHolder.contains( _timerUI ) ) {
					_guiHolder.removeChild( _timerUI );
					_timerUI = null;
				}
			}
		}		
		
		private function addLiveUI():void 
		{
			_liveUI = new LiveUI( 20, 440 );
			_guiHolder.addChild( _liveUI );			
		}
		
		private function removeLiveUI():void 
		{
			if ( _liveUI != null ) {
				if ( _guiHolder.contains( _liveUI ) ) {
					_guiHolder.removeChild( _liveUI );
					_liveUI = null;
				}
			}
		}
		
		private function addSoundUI():void 
		{
			_soundUI = new SoundUI( 545, 10 );
			_guiHolder.addChild( _soundUI );			
		}
		
		private function removeSoundUI():void 
		{
			if ( _soundUI != null ) {
				if ( _guiHolder.contains( _soundUI ) ) {
					_guiHolder.removeChild( _soundUI );
					_soundUI = null;
				}
			}
		}	
		
		/*----------------------------------------------------------------Setters---------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------Getters---------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------EventHandlers---------------------------------------------------------------*/
		private function onGameloop(e:Event):void 
		{
			if ( stage != null ) {
				if ( !_gdc.getPausedGame() ) {
					//trace( "[Game Engine]: loop..." );					
					if ( stage != null ) {
						stage.focus = this;
					}
				}			
			}			
		}
		
		private function onGameOver(e:GameEvent):void 
		{			
			_dm.loadScreen( DisplayManagerConfig.GAME_OVER_SCREEN );
		}
		
		private function onGameExit(e:GameEvent):void 
		{
			if ( stage != null ) {
				stage.frameRate = 30;
			}
			
			_dm.removeSubScreen( DisplayManagerConfig.PAUSED_SCREEN );			
			_dm.loadScreen( DisplayManagerConfig.TITLE_SCREEN );
		}
		
		private function onGamePaused(e:GameEvent):void 
		{			
			if( _timerUI != null ){
				_dm.loadSubScreen( DisplayManagerConfig.PAUSED_SCREEN );				
				_timerUI.stopTimer();
				_soundManager.muteBgm();
			}
		}
		
		private function onGameUnPaused(e:GameEvent):void 
		{			
			if( _timerUI != null ){
				_dm.removeSubScreen( DisplayManagerConfig.PAUSED_SCREEN );				
				_timerUI.startTimer();
				_soundManager.unMuteBgm();
			}
		}
		
		private function onLoadScreen(e:DisplayManagerEvent):void 
		{
			if ( stage != null && e.windowName =="PAUSED_SCREEN" ) {
				if ( _gdc.getPausedGame() ) {
					stage.frameRate = 0;
				}else {
					stage.frameRate = 30;
				}
			}
		}
		
	}

}