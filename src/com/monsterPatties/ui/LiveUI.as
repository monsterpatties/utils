package com.monsterPatties.ui 
{
	import com.monsterPatties.controllers.GameDataController;	
	import com.monsterPatties.utils.eventSatellite.EventSatellite;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class LiveUI extends Sprite
	{
		
		/*-------------------------------------------------------------Constant----------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------Properties--------------------------------------------------------------------*/
		private var _mc:LivesMC;
		private var _xPos:Number = 0;
		private var _yPos:Number = 0;
		private var _es:EventSatellite;
		private var _gameDataController:GameDataController;
		/*-------------------------------------------------------------Constructor----------------------------------------------------------------------*/
		
		public function LiveUI( xpos:Number , ypos:Number ) 
		{
			_es = EventSatellite.getInstance();			
			_gameDataController = GameDataController.getInstance();
			
			_xPos = xpos;
			_yPos = ypos;
			
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
		
		/*-------------------------------------------------------------Methods----------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new LivesMC();
			addChild( _mc );
			_mc.scaleX = 0.25;
			_mc.scaleY = 0.25;
			_mc.x = _xPos;
			_mc.y = _yPos;
			
			update( _gameDataController.getLive() );
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ){				
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		private function update( live:int ):void 
		{			
			//trace( "live", live );			
			if( _mc != null ){
				_mc.gotoAndStop( live + 1 );
			}
		}
		/*-------------------------------------------------------------Setters----------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------Getters----------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------EventHandlers----------------------------------------------------------------*/		
	}

}