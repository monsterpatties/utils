package com.monsterPatties.test 
{
	import com.monsterPatties.utils.webCam.WebCam;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class CameraTest extends Sprite
	{
		
		/*------------------------------------------------------------Constant------------------------------------------------------*/
		
		/*------------------------------------------------------------Properties------------------------------------------------------*/
		private var _cam:WebCam;
		/*------------------------------------------------------------Constructor------------------------------------------------------*/
		
		public function CameraTest() 
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
		/*------------------------------------------------------------Methods------------------------------------------------------*/
		private function setDisplay():void 
		{
			_cam = new WebCam();
			addChild( _cam );
		}
		
		private function removeDisplay():void 
		{
			if ( _cam != null ) {
				if (this.contains( _cam ) ) {
					this.removeChild( _cam );
					_cam = null;
				}
			}
		}
		/*------------------------------------------------------------Setters------------------------------------------------------*/
		
		/*------------------------------------------------------------Getters------------------------------------------------------*/
		
		/*------------------------------------------------------------EventHandlers------------------------------------------------------*/
		
	}

}