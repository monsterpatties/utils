package com.monsterPatties.ui 
{
	import com.monsterPatties.controllers.GameDataController;
	import com.monsterPatties.events.CaveSmashEvent;
	import com.monsterPatties.utils.eventSatellite.EventSatellite;
	import components.items.ItemConfig;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author jc
	 */
	public class ScoreHudGUI extends Sprite
	{
		/*----------------------------------------------------------------------Constant--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Properties------------------------------------------------------------*/
		private var _scoreHud:HudScoreMC;
		private var _xpos:Number = 0;
		private var _ypos:Number = 0;
		private var _es:EventSatellite;
		private var _gdc:GameDataController;
		/*----------------------------------------------------------------------Constructor-----------------------------------------------------------*/
		
		
		public function ScoreHudGUI( xpos:Number = 0, ypos:Number = 0 ) 
		{
			_xpos = xpos;
			_ypos = ypos;
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
			_scoreHud = new HudScoreMC();
			addChild( _scoreHud );
			_scoreHud.x = _xpos;
			_scoreHud.y = _ypos;
			updateScore();
		}
		
		private function removeDisplay():void 
		{
			if ( _scoreHud != null ) {
				if ( this.contains( _scoreHud ) ) {
					this.removeChild( _scoreHud )
					_scoreHud = null;
				}
			}
		}
		
		private function initEventListeners():void 
		{
			_es =  EventSatellite.getInstance();			
			_es.addEventListener( CaveSmashEvent.BOSS_DIED, onBossDied );
			_es.addEventListener( CaveSmashEvent.MONSTER_DIED, onMonsterDied );
			_es.addEventListener( CaveSmashEvent.PICK_UP_ITEM, onPickUpItem );
			_es.addEventListener( CaveSmashEvent.DESTROY_BLOCK, onDestroyBlock );
		}		
		
		private function removeEventListeners():void
		{			
			_es.removeEventListener( CaveSmashEvent.BOSS_DIED, onBossDied );
			_es.removeEventListener( CaveSmashEvent.MONSTER_DIED, onMonsterDied );
			_es.removeEventListener( CaveSmashEvent.PICK_UP_ITEM, onPickUpItem );
			_es.removeEventListener( CaveSmashEvent.DESTROY_BLOCK, onDestroyBlock );
		}
		
		private function initControllers():void 
		{
			_gdc = GameDataController.getInstance();			
		}
		
		private function removeControllers():void 
		{
			//reset date here ????
		}
		
		private function updateScore( score:Number = 0 ):void 
		{
			if ( _scoreHud != null ) {		
				_gdc.updateScore( score );
				var totalScore:int = _gdc.getScore();
				trace( "[" + this + "]" + totalScore );
				_scoreHud.txtScore.text = totalScore + "";				
			}
		}
		/*----------------------------------------------------------------------Setters--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Getters--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------EventHandlers--------------------------------------------------------*/	
		
		private function onBossDied(e:CaveSmashEvent):void 
		{
			updateScore( e.obj.score );
		}
		
		private function onMonsterDied(e:CaveSmashEvent):void 
		{
			updateScore( e.obj.score );
		}
		
		private function onPickUpItem(e:CaveSmashEvent):void 
		{
			var itemType:String = e.obj.itemType;
			if ( itemType == ItemConfig.CRYSTAL ){
				updateScore( e.obj.score );				
			}else if ( itemType == ItemConfig.GOLD || itemType == ItemConfig.SILVER  || itemType == ItemConfig.BRONZE ) {
				updateScore( e.obj.score );	
			}else if ( itemType == ItemConfig.KEY ) {
				updateScore( e.obj.score );	
			}
		}
		
		private function onDestroyBlock(e:CaveSmashEvent):void
		{
			updateScore( e.obj.score );	
		}
	}

}