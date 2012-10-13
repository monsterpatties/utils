package com.monsterPatties.components.levelEditor 
{
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class EditorTile extends Sprite
	{
		/*---------------------------------------------------------------------Constant----------------------------------------------------*/
		
		
		/*---------------------------------------------------------------------Properties-------------------------------------------------*/
		private var _mc:TileEMC;
		private var _bm:ButtonManager;
		private var _currentTile:int = 0;
		/*---------------------------------------------------------------------Constructor------------------------------------------------*/
		
		
		public function EditorTile() 
		{
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
		
		/*---------------------------------------------------------------------Methods---------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new TileEMC();
			addChild( _mc );			
			
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc.hitBox );			
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				_bm.removeBtnListener( _mc.hitBox );				
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
		
		public function setTile( type:int ):void 
		{
			_currentTile = type;
			if ( _currentTile >= _mc.totalFrames ) {
				_currentTile = 0;
				trace( "reset click current tile", _currentTile );
			}			
			
			if( _currentTile < _mc.totalFrames ){				
				_mc.gotoAndStop( _currentTile + 1 );
			}else {
				_mc.gotoAndStop( _currentTile );
			}
		}
		
		/*---------------------------------------------------------------------Setters---------------------------------------------------*/
		public function set mc(value:TileEMC):void 
		{
			_mc = value;
		}
		
		public function set currentTile(value:int):void 
		{
			_currentTile = value;
		}
		/*---------------------------------------------------------------------Getters---------------------------------------------------*/
		public function get mc():TileEMC 
		{
			return _mc;
		}
		
		public function get currentTile():int 
		{
			return _currentTile;
		}		
		/*---------------------------------------------------------------------EventHandlers---------------------------------------------*/
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			
		}
		
		private function onClickBtn(e:ButtonEvent):void 
		{				
			currentTile++;
			trace( "click current tile", _currentTile );
			
			if ( _currentTile >= _mc.totalFrames ) {
				_currentTile = 0;
				trace( "reset click current tile", _currentTile );
			}			
			
			if( _currentTile < _mc.totalFrames ){				
				_mc.gotoAndStop( _currentTile + 1 );
			}else {
				_mc.gotoAndStop( _currentTile );
			}
			//var btnName:String = e.obj.name;
			//
			//switch ( btnName ) 
			//{
				//case "upBtn":
					//_mc.upBtn.gotoAndStop( 3 );
				//break;
				//
				//case "downBtn":
					//_mc.downBtn.gotoAndStop( 3 );
				//break;		
				//
				//default:
				//break;	
			//}
		}				
	}

}