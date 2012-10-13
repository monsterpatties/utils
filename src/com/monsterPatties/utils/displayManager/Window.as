package com.monsterPatties.utils.displayManager 
{		
	import com.monsterPatties.utils.displayManager.event.WindowEvent;
	import com.monsterPatties.utils.interfaces.IWindow;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class Window extends Sprite implements IWindow
	{
		
		/*------------------------------------------------------------Constant------------------------------------------------------------*/
		
		/*------------------------------------------------------------Properties------------------------------------------------------------*/		
		private var _windowName:String;
		private var _winWidth:Number;
		private var _winHeight:Number;
		private var _isWindowLostFocus:Boolean;
		/*------------------------------------------------------------Constructor------------------------------------------------------------*/
		
		public function Window( windowName:String, winWidth:Number = 0, winHeight:Number = 0 ) 
		{		
			//trace( _winWidth, _winHeight );			
			_winWidth = winWidth;
			_winHeight = winHeight
			_windowName = windowName;
		}
		
		/*------------------------------------------------------------Mehods------------------------------------------------------------*/	 		
		
		public function initWindow():void 
		{
			//init some thinsg here.......
			setUpStage();
		}
		
		public function clearWindow():void 
		{
			//clear some thinsg here.......
			this.stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeave );
			this.stage.removeEventListener(MouseEvent.CLICK, onClickWindow );
			this.stage.removeEventListener(Event.DEACTIVATE, onDeactivateWindow );
			this.stage.removeEventListener(Event.ACTIVATE, onActiveWindow );
		}		
		
		private function setUpStage():void 
		{	
			if ( stage != null ){				
				stage.stageFocusRect = false;
				//stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.focus = this;
				this.stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeave );
				this.stage.addEventListener(MouseEvent.CLICK, onClickWindow );
				this.stage.addEventListener(Event.DEACTIVATE, onDeactivateWindow );
				this.stage.addEventListener(Event.ACTIVATE, onActiveWindow );
			}
		}					
		
		/*------------------------------------------------------------Setters------------------------------------------------------------*/
		public function set windowName(value:String):void 
		{
			_windowName = value;
		}
		
		public function set isWindowLostFocus(value:Boolean):void 
		{
			_isWindowLostFocus = value;
		}
		
		/*------------------------------------------------------------Getters------------------------------------------------------------*/
		public function get windowName():String 
		{
			return _windowName;
		}
		
		public function get isWindowLostFocus():Boolean 
		{
			return _isWindowLostFocus;
		}	
		
		/*------------------------------------------------------------EventHandlers------------------------------------------------------------*/
		private function onMouseLeave(e:Event):void 
		{			
			var windowEvent:WindowEvent = new WindowEvent( WindowEvent.MOUSE_LEAVE_WINDOW );
			dispatchEvent( windowEvent );
		}
		
		private function onClickWindow(e:MouseEvent):void 
		{			
			var windowEvent:WindowEvent = new WindowEvent( WindowEvent.ON_CLICK_WINDOW );
			dispatchEvent( windowEvent );
		}
		
		private function onActiveWindow(e:Event):void 
		{
			var windowEvent:WindowEvent = new WindowEvent( WindowEvent.ON_CLICK_WINDOW );
			dispatchEvent( windowEvent );
		}
		
		private function onDeactivateWindow(e:Event):void 
		{
			var windowEvent:WindowEvent = new WindowEvent( WindowEvent.MOUSE_LEAVE_WINDOW );
			dispatchEvent( windowEvent );
		}
	}

}