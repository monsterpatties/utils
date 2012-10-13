package com.monsterPatties.test 
{
	import com.greensock.TweenLite;
	import com.monsterPatties.components.Sprinkles;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author jc
	 */
	public class StarDustTest extends Sprite
	{
		private var sprinkle:Sprinkles;
		
		public function StarDustTest() 
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
			
		}
		
		private function setDisplay():void 
		{
			sprinkle = new Sprinkles( 100, 100 );
			addChild(sprinkle );
			TweenLite.delayedCall( 1, removeMe );			
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function removeMe():void 
		{
			if ( sprinkle != null ) {
				removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				if ( this.contains( sprinkle ) ) {
					this.removeChild( sprinkle );
					sprinkle = null;
				}
			}
		}
		
		private function onEnterFrame(e:Event):void 
		{
			sprinkle.update( mouseX, mouseY );
		}
		
		
		
	}

}