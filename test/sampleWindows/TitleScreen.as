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
	public class TitleScreen extends Window implements IDestroyable
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/		
		private var _windowBg:MovieClip;
		
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function TitleScreen ( windowName:String, winWidth:Number = 0, winHeight:Number = 0 ) 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );			
			super( windowName , winWidth, winHeight );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);			
			setDisplay(  );
			trace( "init TitleScreen........................" );			
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