package com.monsterPatties.ui 
{
	import com.greensock.TweenLite;
	import com.monsterPatties.controllers.GameDataController;
	import com.monsterPatties.events.CaveSmashEvent;
	import com.monsterPatties.utils.eventSatellite.EventSatellite;
	import components.items.ItemConfig;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author jc
	 */
	public class MessageGUI extends Sprite
	{
		/*----------------------------------------------------------------------Constant--------------------------------------------------------------*/
		private static const LEVEL_FAIL_POSITION:Point = new Point(-17.75,187.3  );
		private static const LEVEL_COMPLETE_POSITION:Point = new Point( -9.5, 129.65 );
		/*----------------------------------------------------------------------Properties------------------------------------------------------------*/
		private var _levelFail:LevelFailMC;
		private var _levelComplete:LevelCompleteMC;		
		
		private var _es:EventSatellite;
		private var _gdc:GameDataController;
		private var _caveSmashEvent:CaveSmashEvent;
		/*----------------------------------------------------------------------Constructor-----------------------------------------------------------*/
		
		
		public function MessageGUI(  ) 
		{			
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			initControllers();
			initEventListeners();
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeEventListeners();
			removeDisplay();
		}
		
		/*----------------------------------------------------------------------Methods--------------------------------------------------------------*/
		private function setDisplay():void 
		{
			
		}
		
		private function removeDisplay():void 
		{
			
		}
		
		private function initEventListeners():void 
		{
			_es =  EventSatellite.getInstance();
			_es.addEventListener( CaveSmashEvent.LEVEL_FAILED, onLevelFail );
			_es.addEventListener( CaveSmashEvent.LEVEL_COMPLETE, onLevelComplete );
		}						
		
		private function removeEventListeners():void
		{			
			_es.removeEventListener( CaveSmashEvent.LEVEL_COMPLETE, onLevelComplete );
			_es.removeEventListener( CaveSmashEvent.LEVEL_FAILED, onLevelFail );
		}
		
		private function initControllers():void 
		{
			_gdc = GameDataController.getInstance();			
		}
		
		private function removeControllers():void 
		{
			//reset date here ????
		}
		
		private function showLevelFail():void 
		{
			if( _levelFail == null ){
				_levelFail = new LevelFailMC();
				addChild( _levelFail );
				_levelFail.x = LEVEL_FAIL_POSITION.x;
				_levelFail.y = LEVEL_FAIL_POSITION.y;
				_levelFail.addFrameScript( _levelFail.totalFrames - 2,  exitFailAnimation );
			}
		}
		
		private function exitFailAnimation(  ):void 
		{
			_levelFail.stop();
			TweenLite.to( _levelFail, 2, { alpha:0, onComplete:removeLevelFail } );
		}
		
		private function removeLevelFail():void 
		{
			if ( _levelFail != null ) {
				TweenLite.killTweensOf( _levelFail )
				if ( this.contains( _levelFail ) ) {
					this.removeChild( _levelFail )
					_levelFail = null;
					_caveSmashEvent = new CaveSmashEvent( CaveSmashEvent.RELOAD_LEVEL );
					_es.dispatchESEvent( _caveSmashEvent );
				}
			}
		}
		
		private function showLevelComplete():void 
		{
			if( _levelComplete == null ){
				_levelComplete = new LevelCompleteMC();
				addChild( _levelComplete );
				_levelComplete.x = LEVEL_COMPLETE_POSITION.x;
				_levelComplete.y = LEVEL_COMPLETE_POSITION.y;
				_levelComplete.addFrameScript( _levelComplete.totalFrames - 2,  exitCompleteAnimation );
			}
		}		
		
		private function removeLevelComplete():void 
		{
			if ( _levelComplete != null ) {
				TweenLite.killTweensOf( _levelComplete )
				if ( this.contains( _levelComplete ) ) {
					this.removeChild( _levelComplete )
					_levelComplete = null;
					checkWhatLevelToLoad();					
				}
			}
		}
		
		private function exitCompleteAnimation(  ):void 
		{			
			_levelComplete.stop();
			TweenLite.to( _levelComplete, 2, { alpha:0, onComplete:removeLevelComplete } );			
		}
		
		private function checkWhatLevelToLoad():void 
		{
			var level:int = _gdc.getLevel();
			
			if ( level == 2 ) {
				_caveSmashEvent = new CaveSmashEvent( CaveSmashEvent.LOAD_BOSS_LEVEL );
				_es.dispatchESEvent( _caveSmashEvent );
			}else {
				_caveSmashEvent = new CaveSmashEvent( CaveSmashEvent.LOAD_LEVEL );
				_es.dispatchESEvent( _caveSmashEvent );
			}
			
		}
		/*----------------------------------------------------------------------Setters--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Getters--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------EventHandlers--------------------------------------------------------*/
		private function onLevelFail(e:CaveSmashEvent):void 
		{
			showLevelFail();
		}
		
		private function onLevelComplete(e:CaveSmashEvent):void 
		{
			showLevelComplete();
		}
	}

}