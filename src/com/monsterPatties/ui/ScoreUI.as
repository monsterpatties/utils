package com.monsterPatties.ui 
{
	import com.monsterPatties.utils.soundManager.SoundManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ScoreUI extends Sprite
	{
		/*--------------------------------------------------------------------------------Constant----------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------Properties--------------------------------------------------------*/
		private var _mc:ScoreUIMC;
		private var _xPos:int;
		private var _yPos:int;
		private var _soundManager:SoundManager;
		/*--------------------------------------------------------------------------------Constructor---------------------------------------------------------*/
		
		
		public function ScoreUI( xPos:int, yPos:int ) 
		{
			_xPos = xPos
			_yPos = yPos;			
			addEventListener( Event.ADDED_TO_STAGE, init )
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
		
		/*--------------------------------------------------------------------------------Methods----------------------------------------------------------*/
		private function setDisplay():void 
		{		
			_mc = new ScoreUIMC();
			addChild( _mc );
			_mc.x = _xPos
			_mc.y = _yPos;
			updateScore( 99 );
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		public function updateScore( val:int ):void 
		{
			_mc.txtScore.text = val.toString();
		}
		/*--------------------------------------------------------------------------------Setters----------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------Getters----------------------------------------------------------*/
		
		/*--------------------------------------------------------------------------------EventHandlers----------------------------------------------------*/
		
	}

}