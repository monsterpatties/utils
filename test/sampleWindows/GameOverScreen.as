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
	public class GameOverScreen extends Window implements IDestroyable
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/		
		private var _windowBg:MovieClip;
		
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function GameOverScreen ( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );			
			super( windowName , winWidth, winHeight, hideWindowName );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);			
			setDisplay(  );
			trace( "init GameOverScreen........................" );			
		}
		
		
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		
		private function setDisplay():void 
		{
			_windowBg = new WindowGraphic();
			addWindowBg(_windowBg );
		}
		
		
		public function destroy():void 
		{
			removeWindowBg();
			trace( windowName + " destroyed!!" );
		}
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/		
		
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/
		
	}

}