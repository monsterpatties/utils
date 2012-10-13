package com.monsterPatties.views 
{	
	import com.monsterPatties.controllers.GameDataController;
	import com.monsterPatties.engine.World;
	import com.monsterPatties.events.GameEvent;
	import com.monsterPatties.ui.BossLifeGUI;
	import com.monsterPatties.ui.LifeHudGUI;
	import com.monsterPatties.ui.MessageGUI;
	import com.monsterPatties.ui.ScoreHudGUI;
	import com.monsterPatties.ui.SoundGUI;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.event.WindowEvent;
	import com.monsterPatties.utils.displayManager.Window;
	import com.monsterPatties.utils.eventSatellite.EventSatellite;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author jc
	 */
	public class GameScreen extends Window
	{		
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/				
		private var _world:World;
		private var _lifeHUDGUI:LifeHudGUI;
		private var _bossLifeGUI:BossLifeGUI;
		private var _messageGUI:MessageGUI;
		private var _scoreGUI:ScoreHudGUI;		
		private var _bgmSfxGUI:SoundGUI;
		
		private var _es:EventSatellite;
		private var _gdc:GameDataController;
		private var _dm:DisplayManager;
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function GameScreen( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
		{			
			super( windowName , winWidth, winHeight );
		}		
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void 
		{	
			_gdc = GameDataController.getInstance();
			_es = EventSatellite.getInstance();
			_dm = DisplayManager.getInstance();
			
			_es.addEventListener( GameEvent.GAME_PAUSED, onGamePaused );
			_es.addEventListener( GameEvent.GAME_UNPAUSED, onGameUnPaused );
			_es.addEventListener( GameEvent.SHOW_GAME_SETTING, onShowGameSetting );
			_es.addEventListener( GameEvent.SHOW_PAUSED_SCREEN, onShowPausedScreen );
			
			addWorld();
			addLifeHudGUI();
			addScoreHudGUI();
			addBossLifeHudGUI();
			addMessageGUI();
			addBgmSfxUI();
			
			this.addEventListener( WindowEvent.MOUSE_LEAVE_WINDOW, onMouseLeaveWindow );
			this.addEventListener( WindowEvent.ON_CLICK_WINDOW, onClickWindow );
		}											
		
		private function removeDisplay():void 
		{				
			this.removeEventListener( WindowEvent.MOUSE_LEAVE_WINDOW, onMouseLeaveWindow );
			this.removeEventListener( WindowEvent.ON_CLICK_WINDOW, onClickWindow );
			
			_es.removeEventListener( GameEvent.GAME_PAUSED, onGamePaused );
			_es.removeEventListener( GameEvent.GAME_UNPAUSED, onGameUnPaused );
			_es.removeEventListener( GameEvent.SHOW_GAME_SETTING, onShowGameSetting );
			_es.removeEventListener( GameEvent.SHOW_PAUSED_SCREEN, onShowPausedScreen );
			
			removeWorld();
			removeBgmSfxUI();
			removeGUI( this, _lifeHUDGUI );
			removeGUI( this, _scoreGUI );
			removeGUI( this, _bossLifeGUI );
			removeGUI( this, _messageGUI );
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
			
		}        
        
		private function addWorld():void 
		{
			_world = new World();
			addChild( _world );
		}
		
		private function removeWorld():void 
		{
			if ( _world != null ) {
				if ( this.contains( _world ) ) {
					this.removeChild( _world );
					_world = null;
				}
			}
		}
		
		private function addLifeHudGUI():void 
		{
			_lifeHUDGUI = new LifeHudGUI( 15,8.5 );
			addChild( _lifeHUDGUI );
		}
		
		private function addScoreHudGUI():void 
		{
			_scoreGUI = new ScoreHudGUI( 194.75 ,9.55);
			addChild( _scoreGUI );
		}
		
		private function addBossLifeHudGUI():void 
		{
			_bossLifeGUI = new BossLifeGUI( 140,410 );
			addChild( _bossLifeGUI );
		}
		
		private function addMessageGUI():void 
		{
			_messageGUI = new MessageGUI(  );
			addChild( _messageGUI );
		}
		
		private function removeGUI( parent:Sprite, child:Sprite  ):void 
		{
			if ( child != null ) {
				if ( parent.contains( child ) ) {
					parent.removeChild( child )
					child = null;
				}
			}
		}		
		
		private function addBgmSfxUI():void 
		{
			_bgmSfxGUI = SoundGUI.getIntance();
			_bgmSfxGUI.setXYPos( 496, 8 );
			addChild( _bgmSfxGUI );
			_bgmSfxGUI.playBgMusic( 0 );
			
		}
		
		private function removeBgmSfxUI():void 
		{
			if ( _bgmSfxGUI != null ) {
				if ( this.contains( _bgmSfxGUI ) ) {
					this.removeChild( _bgmSfxGUI )
					_bgmSfxGUI = null;
				}
			}
		}
		
		private function gamePaused():void 
		{
			this.root.stage.frameRate = 0;
			_gdc.setPausedGame( true );			
		}
		
		private function gameUnPaused():void 
		{
			this.root.stage.frameRate = 30;
			_gdc.setPausedGame( false );			
		}
		
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/		
		
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/		
		private function onMouseLeaveWindow(e:WindowEvent):void 
		{
			trace( "[ GameScreen]: mouseleave window..........." );			
			if ( !_gdc.getPausedGame() ){
				isWindowLostFocus = true;
				_dm.loadSubScreen( DisplayManagerConfig.LOST_FOCUS_SCREEN );
				gamePaused();				
			}
		}
		
		
		private function onClickWindow(e:WindowEvent):void 
		{
			trace( "[ GameScreen]: mouse return window..........." );
			if ( isWindowLostFocus ) {
				isWindowLostFocus = false;
				_dm.removeSubScreen( DisplayManagerConfig.LOST_FOCUS_SCREEN );
				gameUnPaused();
			}
		}
		
		private function onGameUnPaused(e:GameEvent):void 
		{
			gameUnPaused();
		}
		
		private function onGamePaused(e:GameEvent):void 
		{			
			gamePaused();			
		}
		
		private function onShowGameSetting(e:GameEvent):void 
		{
			_dm.loadSubScreen( DisplayManagerConfig.SETTING_SCREEN );			
		}
		
		private function onShowPausedScreen(e:GameEvent):void 
		{
			_dm.loadSubScreen( DisplayManagerConfig.PAUSED_SCREEN );			
		}
	}

}