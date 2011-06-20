package com.monsterPatties.test.sampleWindows 
{	
	import com.monsterPatties.utils.displayManager.Window;	
	import com.monsterPatties.utils.interfaces.IDestroyable;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author jc
	 */
	public class GameScreen extends Window implements IDestroyable
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/		
		
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function GameScreen( windowName:String ) 
		{				
			addEventListener( Event.ADDED_TO_STAGE, init );			
			super( windowName );
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			setDisplay(  );
			trace( "init GameScreen........................" );			
		}
		
		public function destroy():void 
		{
			removeWindowBg();
			trace( windowName + " destroyed!!" );
		}
		
		public function setDisplay():void 
		{
			addWindowBg( new WindowGraphic() );		
			
		}		
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/		
		
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/		
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/
		
	}

}