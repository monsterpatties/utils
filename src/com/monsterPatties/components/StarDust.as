package com.monsterPatties.components 
{
	import com.monsterPatties.interfaces.IBasic;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class StarDust extends Sprite implements IBasic
	{
		/*------------------------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------Properties-------------------------------------------------------------*/
		private var _mc:StarDustMC;
		private var _xpos:Number = 0;
		private var _ypos:Number = 0;
		/*------------------------------------------------------------------------Constructor------------------------------------------------------------*/		
		
		public function StarDust( xpos:Number, ypos:Number ) 
		{
			_xpos = xpos;
			_ypos = ypos;
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
		
		/*------------------------------------------------------------------------Methods----------------------------------------------------------------*/
		public function setDisplay():void 
		{
			_mc = new StarDustMC();
			addChild( _mc );
			_mc.x = _xpos;
			_mc.y = _ypos;
			_mc.addFrameScript( _mc.totalFrames - 1, removeDisplay );
		}
		
		public function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
					//trace( "[StarDust]: remove display!!! mc " + _mc );
				}
			}
		}
		
		public function show(  ):void 
		{
			if ( _mc == null ) {
				return;
			}
			_mc.visible = true;
		}
		
		public function hide():void 
		{
			if ( _mc == null ) {
				return;
			}
			_mc.visible = false;
		}
		/*------------------------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------Getters---------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------EventHandlers---------------------------------------------------------*/
		
	}

}