package com.monsterPatties.test 
{
	import com.monsterPatties.utils.box2dWrapper.Box2dWrapper;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class Box2dWorldTest extends Sprite
	{
		/*------------------------------------------------------------------------------Constant----------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------Properties--------------------------------------------------------------*/
		private  var _box2dWorld:Box2dWrapper;
		
		/*------------------------------------------------------------------------------Constructor-------------------------------------------------------------*/
		
		
		public function Box2dWorldTest() 
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
		
		/*------------------------------------------------------------------------------Methods----------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_box2dWorld = new Box2dWrapper();
			addChild( _box2dWorld );
		}
		
		private function removeDisplay():void 
		{
			if ( _box2dWorld != null ) {
				if ( this.contains( _box2dWorld ) ) {
					this.removeChild(  _box2dWorld );
					_box2dWorld = null;
				}
			}
		}
		/*------------------------------------------------------------------------------Setters----------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------Getters----------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------EventHandlers----------------------------------------------------------*/
		
	}

}