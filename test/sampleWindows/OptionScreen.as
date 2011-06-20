package com.monsterPatties.test.sampleWindows 
{	
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;	
	import com.monsterPatties.utils.displayManager.Window;	
	import com.monsterPatties.utils.interfaces.IDestroyable;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author jc
	 */
	public class OptionScreen extends Window implements IDestroyable
	{
		/*-----------------------------------------------------------Constant--------------------------------------------------------*/
		
		/*-----------------------------------------------------------Properties--------------------------------------------------------*/
		private var _windowBg:MovieClip;
		/*-----------------------------------------------------------Constructor--------------------------------------------------------*/
		
		
		public function OptionScreen( windowName:String , winWidth:Number = 0, winHeight:Number =0 ) 
		{
			super( windowName , winWidth, winHeight );
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			setDisplay();
		}
		
		/*-----------------------------------------------------------Methods--------------------------------------------------------*/
		private function setDisplay ():void 
		{
			_windowBg = new WindowGraphic();
			addWindowBg( _windowBg );			
			this.addEventListener( MouseEvent.CLICK, onShowPopUp );
		}
		
		//sample show add and  show popup
		private function onShowPopUp(e:MouseEvent):void 
		{
			var dm:DisplayManager = DisplayManager.getInstance();			
			var popUpWindow:Pop2 = new Pop2( _windowBg.width, _windowBg.height );
			dm.addPopWindow( popUpWindow );
			dm.loadPopUpWindow( DisplayManagerConfig.POP_UP_WINDOW_MESSAGE );			
			trace( "show popup" );
		}
		
		private function removeDisplay ():void 
		{
			removeWindowBg();
		}
		
		
		public function destroy():void 
		{
			removeDisplay();
		}
		
		/*-----------------------------------------------------------Setters--------------------------------------------------------*/
		/*-----------------------------------------------------------Getters--------------------------------------------------------*/
		/*-----------------------------------------------------------EventHandlers--------------------------------------------------------*/
	}

}