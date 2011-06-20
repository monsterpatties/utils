package com.monsterPatties.utils.displayManager 
{	
	import com.monsterPatties.utils.interfaces.IWindow;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author jc
	 */
	public class Window extends Sprite implements IWindow
	{
		
		/*------------------------------------------------------------Constant------------------------------------------------------------*/
		
		/*------------------------------------------------------------Properties------------------------------------------------------------*/
		private var _windowBg:MovieClip;
		private var _windowName:String;
		private var _winWidth:Number;
		private var _winHeight:Number;
		private var _hideWindowName:Boolean;
		/*------------------------------------------------------------Constructor------------------------------------------------------------*/
		
		public function Window( windowName:String, winWidth:Number = 0, winHeight:Number = 0, hideWindowName:Boolean = false ) 
		{		
			//trace( _winWidth, _winHeight );
			_hideWindowName = hideWindowName;
			_winWidth = winWidth;
			_winHeight = winHeight
			_windowName = windowName;
		}
		
		/*------------------------------------------------------------Mehods------------------------------------------------------------*/	 
		
		public function addWindowBg( windowBg:MovieClip ):void 
		{
			_windowBg = windowBg;			
			addChild( _windowBg );
			
			if( _windowBg.txtWindowName != null ){
				_windowBg.txtWindowName.text = _windowName;
				if( _hideWindowName ){
					_windowBg.txtWindowName.visible = false;
				}else {
					_windowBg.txtWindowName.visible = true;
				}
			}			
			
			if ( _winWidth == 0 || _winHeight == 0 ) {
				_winWidth = _windowBg.width;
				_winHeight = _windowBg.height;
			}
			
			_windowBg.width = _winWidth;
			_windowBg.height = _winHeight;
			trace( _windowBg.width, _windowBg.height );
		}
		
		public function removeWindowBg():void 
		{
			if ( _windowBg != null ) {
				
				if ( this.contains( _windowBg ) ){
					this.removeChild( _windowBg );
					_windowBg = null;
				}
			}
		}		
		
		public function initWindow():void 
		{
			//init some thinsg here.......
		}
		
		public function clearWindow():void 
		{
			//clear some thinsg here.......
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