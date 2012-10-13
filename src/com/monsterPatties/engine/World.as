package com.monsterPatties.engine 
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.monsterPatties.controllers.FGLTracker;
	import com.monsterPatties.controllers.GameDataController;
	import com.monsterPatties.controllers.PlaytomicController;
	import com.monsterPatties.engine.flashPunk.MyWorld;
	import com.monsterPatties.events.CaveSmashEvent;
	import com.monsterPatties.ui.TimerUI;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.eventSatellite.EventSatellite;
	import components.items.ItemConfig;
	import flash.display.Sprite;
	import flash.events.Event;
	import wck.WCK;
	/**
	 * ...
	 * @author ...
	 */
	public class World extends WCK
	{
		/*--------------------------------------------------------------------Constant----------------------------------------------------------------*/
		private static const	DELAY_LOAD_LEVEL:int = 0.5;
		/*--------------------------------------------------------------------Properties---------------------------------------------------------------*/
		private var _gdc:GameDataController;
		private var _es:EventSatellite;
		private var _caveSmashEvent:CaveSmashEvent;
		
		private var _displayManager:DisplayManager;	
		
		//persistent data
		private var _level:*;		
		private var _timerUI:TimerUI;
		
		//trackers analytics ( optional )
		private var _fglTracker:FGLTracker;
		private var _playtomic:PlaytomicController;
		private var _cover:Sprite;
		/*--------------------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function World() 
		{
			initControllers();
			addGameEventListeners();
			addEventListener( Event.ADDED_TO_STAGE, init );			
		}
		
		private function init(e:Event):void 
		{
			addPlaytomicTracker();			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, clearWorld );
			
			addGameEventListeners();
			addFGLTracker();			
			addLevel();			
		}
		
		private function clearWorld(e:Event):void 
		{			
			removeEventListener(Event.REMOVED_FROM_STAGE, clearWorld);			
			removeGameEventListeners();
			removeGameGUI();
			//removeLevel();			
		}
		
		private function reloadLevel():void 
		{
			TweenLite.killDelayedCallsTo( reloadLevel );
			var level:int = _gdc.getLevel();			
			
			if ( level == 3 ){				
				loadBossLevel();				
			}else {
				loadLevel();
			}
			_gdc.setLive( 3 );
			_caveSmashEvent = new CaveSmashEvent( CaveSmashEvent.RESET_LIFE  );
			_es.dispatchESEvent( _caveSmashEvent );
		}
		/*--------------------------------------------------------------------Methods---------------------------------------------------------------*/		
		private function addGameEventListeners():void 
		{
			_es = EventSatellite.getInstance();
			_es.addEventListener( CaveSmashEvent.PICK_UP_ITEM, onPickUpItem );
			_es.addEventListener( CaveSmashEvent.LEVEL_COMPLETE, onLevelComplete );
			_es.addEventListener( CaveSmashEvent.LOAD_LEVEL, onLoadLevel );
			_es.addEventListener( CaveSmashEvent.LOAD_BOSS_LEVEL, onLoadBossLevel );
			_es.addEventListener( CaveSmashEvent.LEVEL_FAILED, onLevelFailed );
			_es.addEventListener( CaveSmashEvent.RELOAD_LEVEL, onReloadLevel );
		}							
		
		private function removeGameEventListeners():void 
		{			
			_es.removeEventListener( CaveSmashEvent.PICK_UP_ITEM, onPickUpItem );
			_es.removeEventListener( CaveSmashEvent.LEVEL_COMPLETE, onLevelComplete );
			_es.removeEventListener( CaveSmashEvent.LOAD_LEVEL, onLoadLevel );
			_es.removeEventListener( CaveSmashEvent.LOAD_BOSS_LEVEL, onLoadBossLevel );
			_es.removeEventListener( CaveSmashEvent.LEVEL_FAILED, onLevelFailed );
			_es.removeEventListener( CaveSmashEvent.RELOAD_LEVEL, onReloadLevel );
		}
		
		private function initControllers():void 
		{			
			_gdc = GameDataController.getInstance();			
			_displayManager = DisplayManager.getInstance();
		}
		
		private function addLevel():void 
		{			
			//reset persistent data			
			_gdc.retry();
			
			//designated level here or room maybe 1a,1b,1c,2a,2b,2c ....
			var level:int = _gdc.getLevel();
			_gdc.setCurrLevel( level );
			trace( "[World]: current level " + level );
			
			if( level == 0 ){
				//_level = new level1();
				_level = new Boss1LevelMC();
			}else if ( level == 1 ){
				_level = new level2();				
			}else if ( level == 2 ){
				_level = new level3();				
			}else {
				_gdc.setLevel( 0 );
				_level = new level1();
			}
			trace( "[World]: world " + _level );
			addChild( _level );
			
			if( this != null ){
				_caveSmashEvent = new CaveSmashEvent( CaveSmashEvent.LEVEL_STARTED );
				_es.dispatchESEvent( _caveSmashEvent );
			}
			addCover();
		}
		
		private function removeLevel():void 
		{
			if ( _level != null ) {
				if ( this.contains( _level ) ) {
					this.removeChild( _level );
					_level = null;
				}
			}
		}
		
		private function addCover():void 
		{
			_cover = new Sprite();
			_cover.graphics.lineStyle( 1, 0x000000 );
			_cover.graphics.beginFill( 0x000000 );
			_cover.graphics.drawRect( 0, 0, 640, 480 );
			addChild( _cover );			
			
			TweenLite.to( _cover, 1.5, { alpha:0, onComplete:removeCover } );
		}
		
		private function removeCover():void 
		{
			if ( _cover != null ) {
				TweenLite.killTweensOf( _cover );
				if ( this.contains( _cover ) ) {
					this.removeChild( _cover );
					_cover = null;
				}
			}
		}
		
		public function stopWorld():void 
		{
			_level.stopSimulation();
		}
		
		public function startWorld():void 
		{
			_level.startSimulation();
		}
		
		private function addGameGUI():void 
		{
			//life gui
			//time gui
			//other GUI....
		}
		
		private function removeGameGUI():void 
		{
			
		}
		
		private function addFGLTracker():void
		{
			_fglTracker = FGLTracker.getInstance();			
		}
		
		private function addPlaytomicTracker():void 
		{
			_playtomic = PlaytomicController.getInstance();
			_playtomic.started( _gdc.getLevel() );
		}
		
		//private function removeLevel():void 
		//{
			//if ( _level != null ) {
				//if ( this.contains( _level ) ) {
					//this.removeChild( _level );
					//_level = null;
				//}
			//}
		//}		
		
		private function loadLevel():void 
		{		
			TweenLite.killDelayedCallsTo( loadLevel  );
			addLevel();
		}
		
		private function loadBossLevel():void 
		{
			TweenLite.killDelayedCallsTo( loadBossLevel );
			_gdc.retry();
			
			var level:int = _gdc.getLevel();
			_gdc.setCurrLevel( level );
			trace( "[World]: current level " + level );
			
			if( level == 3 ){
				_level = new Boss1LevelMC();
			}else {
				_level = new Boss1LevelMC();
			}
			
			addChild( _level );
			
			_caveSmashEvent = new CaveSmashEvent( CaveSmashEvent.LEVEL_STARTED );
			_es.dispatchESEvent( _caveSmashEvent );
			
			_caveSmashEvent = new CaveSmashEvent( CaveSmashEvent.BOSS_LEVEL_STARTED  );
			_es.dispatchESEvent( _caveSmashEvent );
			addCover();
		}		
		
		/*--------------------------------------------------------------------EventHandler----------------------------------------------------------------*/	
		private function onPickUpItem(e:CaveSmashEvent):void 
		{
			trace( "[ World ]:onPickUpItem what item: " + e.obj.itemType );
			
			var itemType:String = e.obj.itemType;
			
			switch ( itemType ) 
			{
				case ItemConfig.KEY:
					_gdc.setIsKeyCollected( true );
				break;
				
				case ItemConfig.GOLD:
					_gdc.updateGold( 1 );
				break;
				
				case ItemConfig.SILVER:
					_gdc.updateSilver( 1 );
				break;
				
				case ItemConfig.BRONZE:
					_gdc.updateBronze( 1 );
				break;
				
				case ItemConfig.CRYSTAL:
					_gdc.updateCrystal( 1 );
				break;				
				
				case ItemConfig.HEART:
					_gdc.updateLive( 1 );
				break;
				
				default:
			}
			
			trace( "[ World ]: check all collected items " 
					+ " lives/heart: " + _gdc.getLive()
					+ " gold: " + _gdc.getGold() 
					+  " silver: " + _gdc.getSilver() 
					+ " bronze: " + _gdc.getBronze() 
					+ " crstal: " + _gdc.getCrystal()
					+ " isKeyCollected: " + _gdc.getIsKeyCollected()
				);
		}		
		
		private function onLevelComplete(e:CaveSmashEvent):void 
		{
			
		}	
		
		private function onLevelFailed(e:CaveSmashEvent):void 
		{				
			trace( "[ World ]:onLevelFailed!!!! " );
		}
		
		private function onLoadLevel(e:CaveSmashEvent):void 
		{			
			trace( "[ World ]:onLoadLevel!!! " );			
			_gdc.updateLevel( 1 );
			removeLevel();
			TweenLite.delayedCall( DELAY_LOAD_LEVEL, loadLevel );			
		}
		
		private function onLoadBossLevel(e:CaveSmashEvent):void 
		{			
			trace( "[ World ]:onLoadBossLevel!!! " );			
			_gdc.updateLevel( 1 );
			removeLevel();
			TweenLite.delayedCall( DELAY_LOAD_LEVEL, loadBossLevel );
		}
		
		private function onReloadLevel(e:CaveSmashEvent):void 
		{		
			removeLevel();
			TweenLite.delayedCall( DELAY_LOAD_LEVEL, reloadLevel );			
		}
	}
}