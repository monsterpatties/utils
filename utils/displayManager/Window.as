package com.monsterPatties.utils.displayManager 
{		
	import com.monsterPatties.utils.interfaces.IWindow;	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
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
		}
		
		private function setUpStage():void 
		{	
			if ( stage != null ){				
				stage.stageFocusRect = false;
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.focus = this;
			}
		}	
		/*------------------------------------------------------------Setters------------------------------------------------------------*/
		public function set windowName(value:String):void 
		{
			_windowName = value;
		}
		/*------------------------------------------------------------Getters------------------------------------------------------------*/
		public function get windowName():String 
		{
			return _windowName;
		}
		/*------------------------------------------------------------EventHandlers------------------------------------------------------------*/
		
	}

}