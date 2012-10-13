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
	public class LifeHudGUI extends Sprite
	{
		/*----------------------------------------------------------------------Constant--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Properties------------------------------------------------------------*/
		private var _lifeHudGUI:HudLifeMC;
		private var _xpos:Number = 0;
		private var _ypos:Number = 0;
		private var _es:EventSatellite;
		private var _gdc:GameDataController;
		/*----------------------------------------------------------------------Constructor-----------------------------------------------------------*/
		
		
		public function LifeHudGUI( xpos:Number = 0, ypos:Number = 0 ) 
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
			_lifeHudGUI = new HudLifeMC();
			addChild( _lifeHudGUI );
			_lifeHudGUI.x = _xpos;
			_lifeHudGUI.y = _ypos;
		}
		
		private function removeDisplay():void 
		{
			if ( _lifeHudGUI != null ) {
				if ( this.contains( _lifeHudGUI ) ) {
					this.removeChild( _lifeHudGUI )
					_lifeHudGUI = null;
				}
			}
		}
		
		private function initEventListeners():void 
		{
			_es =  EventSatellite.getInstance();
			_es.addEventListener( CaveSmashEvent.PLAYER_RECIEVED_DAMAGED, onPlayerRecievedDamage );			
			_es.addEventListener( CaveSmashEvent.RESET_LIFE, onResetLife );			
			_es.addEventListener( CaveSmashEvent.PICK_UP_ITEM, onPickUpItem );
		}					
		
		private function removeEventListeners():void 
		{
			_es.removeEventListener( CaveSmashEvent.PLAYER_RECIEVED_DAMAGED, onPlayerRecievedDamage );
			_es.removeEventListener( CaveSmashEvent.PICK_UP_ITEM, onPickUpItem );			
			_es.removeEventListener( CaveSmashEvent.RESET_LIFE, onResetLife );			
		}
		
		private function initControllers():void 
		{
			_gdc = GameDataController.getInstance();			
		}
		
		private function removeControllers():void 
		{
			//reset date here ????
		}
		
		private function updateLifeHud():void 
		{
			if ( _lifeHudGUI != null ) {
				var life:int = _gdc.getLive();
				switch ( life ) 
				{
					case 3:
						_lifeHudGUI.gotoAndStop( 1 );
					break;
					
					case 2:
						_lifeHudGUI.gotoAndStop( 2 );
					break;
					
					case 1:
						_lifeHudGUI.gotoAndStop( 3 );
					break;
					
					case 0:
						_lifeHudGUI.gotoAndStop( 4 );
					break;
					
					default:
				}
			}
		}
		/*----------------------------------------------------------------------Setters--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Getters--------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------EventHandlers--------------------------------------------------------*/
		private function onPlayerRecievedDamage(e:CaveSmashEvent):void 
		{
			updateLifeHud();
		}		
		
		private function onPickUpItem(e:CaveSmashEvent):void 
		{
			var itemType:String = e.obj.itemType;
			if ( itemType == ItemConfig.HEART ){
				updateLifeHud();
			}
		}
		
		private function onResetLife(e:CaveSmashEvent):void 
		{
			updateLifeHud();
		}
	}

}