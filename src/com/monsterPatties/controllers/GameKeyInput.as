package com.monsterPatties.controllers 
{
	import com.monsterPatties.events.GameEvent;
	import com.monsterPatties.utils.keyboardManager.events.KeyboardManagerEvent;
	import com.monsterPatties.utils.keyboardManager.KeyboardManager;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class GameKeyInput extends EventDispatcher
	{
		/*-------------------------------------------------------------------------Constant----------------------------------------------------------------*/
		private static var _instance:GameKeyInput;
		/*-------------------------------------------------------------------------Properties----------------------------------------------------------------*/
		
		private var _kbManager:KeyboardManager;
		
		private var _leftIsPressed:Boolean;
		private var _rightIsPressed:Boolean;
		private var _upIsPressed:Boolean;
		private var _downIsPressed:Boolean;
		private var _spaceIsDown:Boolean;
		private var _oneIsPressed:Boolean;
		private var _twoIsPressed:Boolean;
		private var _threeIsPressed:Boolean;
		private var _plusIsPressed:Boolean;
		private var _minusIsPressed:Boolean;
		private var _muteBgm:Boolean;
		private var _muteSfx:Boolean;
		
		private var _stage:DisplayObject;
		private var _gameEvent:GameEvent;
		
		/*-------------------------------------------------------------------------Constructor----------------------------------------------------------------*/
		public function GameKeyInput( enforcer:SingletonEnforcer ) 
		{				
			trace( "GameKeyInput started............." );
		}
		
		public static function getIntance():GameKeyInput 
		{
			if ( GameKeyInput._instance == null ) {
				GameKeyInput._instance = new GameKeyInput( new SingletonEnforcer() );
			}
			
			return GameKeyInput._instance;
		}
		
		/*-------------------------------------------------------------------------Methods----------------------------------------------------------------*/
		public function initKeyboardListener( stage:DisplayObject ):void 
		{	
			trace( "init gameKeyInput..." );
			_stage = stage;
			_kbManager = new KeyboardManager( _stage );			
			_kbManager.addEventListener( KeyboardManagerEvent.KEY_DOWN, onKeyDown );
			_kbManager.addEventListener( KeyboardManagerEvent.KEY_UP, onKeyUp );
		}	
		
		public function clearKeyboardListener():void 
		{			
			_kbManager.removeEventListener( KeyboardManagerEvent.KEY_DOWN, onKeyDown );
			_kbManager.removeEventListener( KeyboardManagerEvent.KEY_UP, onKeyUp );
			_stage = null;
			_kbManager.destroy();
		}
		/*-------------------------------------------------------------------------Setters----------------------------------------------------------------*/
		public function set leftIsPressed(value:Boolean):void 
		{
			_leftIsPressed = value;
		}	
		
		public function set rightIsPressed(value:Boolean):void 
		{
			_rightIsPressed = value;
		}	
		
		public function set upIsPressed(value:Boolean):void 
		{
			_upIsPressed = value;
		}	
		
		public function set downIsPressed(value:Boolean):void 
		{
			_downIsPressed = value;
		}
		
		public function set spaceIsDown(value:Boolean):void 
		{
			_spaceIsDown = value;
		}
		
		public function set oneIsPressed(value:Boolean):void 
		{
			_oneIsPressed = value;
		}
		
		public function set plusIsPressed(value:Boolean):void 
		{
			_plusIsPressed = value;
		}
		
		public function set minusIsPressed(value:Boolean):void 
		{
			_minusIsPressed = value;
		}
		
		public function set twoIsPressed(value:Boolean):void 
		{
			_twoIsPressed = value;
		}
		
		public function set threeIsPressed(value:Boolean):void 
		{
			_threeIsPressed = value;
		}
		
		public function set muteBgm(value:Boolean):void 
		{
			_muteBgm = value;
		}
		
		public function set muteSfx(value:Boolean):void 
		{
			_muteSfx = value;
		}
		/*-------------------------------------------------------------------------Getters----------------------------------------------------------------*/
		public function get leftIsPressed():Boolean { return _leftIsPressed; }
		public function get rightIsPressed():Boolean { return _rightIsPressed; }
		public function get upIsPressed():Boolean { return _upIsPressed; }		
		public function get downIsPressed():Boolean { return _downIsPressed; }		
		public function get spaceIsDown():Boolean 
		{
			return _spaceIsDown;
		}		
		
		public function get oneIsPressed():Boolean { return _oneIsPressed; }			
		public function get plusIsPressed():Boolean { return _plusIsPressed; }		
		public function get minusIsPressed():Boolean { return _minusIsPressed; }			
		public function get twoIsPressed():Boolean { return _twoIsPressed; }				
		public function get threeIsPressed():Boolean { return _threeIsPressed; }	
		
		public function get muteBgm():Boolean { return _muteBgm; }
		
		public function get muteSfx():Boolean { return _muteSfx; }		
		
		/*-------------------------------------------------------------------------EventHandlers----------------------------------------------------------------*/
		private function onKeyUp(e:KeyboardManagerEvent):void 
		{
			switch ( e.key ) 
			{
				case "LEFT":
					_leftIsPressed = false;
				break;
				
				case "RIGHT":
					_rightIsPressed = false;
				break;
				
				case "UP":
					_upIsPressed = false;
				break;
				
				case "DOWN":
					_downIsPressed =  false;
				break;
				
				case "SPACE":
					_spaceIsDown =  false;
				break;
				
				case "1":
					_oneIsPressed = false;
				break;
				
				case "2":
					_twoIsPressed = false;
				break;
				
				case "3":
					_threeIsPressed = false;
				break;
				
				case "4":
					if ( !_muteBgm ) {
						_muteBgm = true;
					}else {
						_muteBgm = false;
					}
				break;
				
				case "5":
					if ( !_muteSfx ) {
						_muteSfx = true;
					}else {
						_muteSfx = false;
					}
				break;
				
				case "=+":
					trace( "+pluster" );
					_plusIsPressed = false;
				break;
				
				case "-_":
					trace( "minus" );
					_minusIsPressed = false;
				break;
				
				default:
					
				break;
			}
			
			/*
			if (  e.key =="LEFT") {
				_leftIsPressed = false;
			}else if (  e.key =="RIGHT") {
				_rightIsPressed =  false;
			}else if (  e.key == "UP") {
				_upIsPressed = false;
			}else if (  e.key =="DOWN") {
				_downIsPressed =  false;
			}else if (  e.key =="SPACE") {
				_spaceIsDown =  false;
			}else if (  e.key =="1"){
				_oneIsPressed = false;
			}else if (  e.key =="2"){
				
			}else if (  e.key =="1"){
				_oneIsPressed = false;
			}*/
		}
		
		private function onKeyDown(e:KeyboardManagerEvent):void 
		{
			trace( "titlescreen key detect", e.key );
			/*
			if (  e.key =="LEFT" ) {
				_leftIsPressed = true;
			}else if (  e.key =="RIGHT") {
				_rightIsPressed =  true;
			}else if (  e.key == "UP") {
				_upIsPressed = true;
			}else if (  e.key =="DOWN") {
				_downIsPressed =  true;
			}else if (  e.key =="ESC") {
				_gameEvent = new GameEvent( GameEvent.EXIT_GAME );
				dispatchEvent( _gameEvent );
			}else if (  e.key =="E") {
				
			}else if (  e.key =="SPACE") {				
				_spaceIsDown = true;
			}else if (  e.key == "Q") {				
				
			}else if (  e.key =="1"){
				_oneIsPressed = true;
			}else if (  e.key =="2"){
				
			}*/
			switch ( e.key ) 
			{
				case "LEFT":
					_leftIsPressed = true;
				break;
				
				case "RIGHT":
					_rightIsPressed = true;
				break;
				
				case "UP":
					_upIsPressed = true;
				break;
				
				case "DOWN":
					_downIsPressed =  true;
				break;
				
				case "SPACE":
					_spaceIsDown =  true;
				break;
				
				case "1":
					_oneIsPressed = true;
				break;
				
				case "2":
					_twoIsPressed = true;
				break;
				
				case "3":
					_threeIsPressed = true;
				break;
				
				case "=+":
					trace( "+pluster" );
					_plusIsPressed = true;
				break;
				
				case "-_":
					trace( "minus" );
					_minusIsPressed = true;
				break;
				
				default:
					
				break;
			}
			
		}	
	}
}

class SingletonEnforcer{}