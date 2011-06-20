package com.monsterPatties.utils.keyboardManager 
{		
	import com.monsterPatties.utils.keyboardManager.events.KeyboardManagerEvent;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author jc
	 */
	public class KeyboardManager extends EventDispatcher
	{
		
		/*--------------------------------------------------------------------------Constant------------------------------------------------------------------------*/		
		
		/*--------------------------------------------------------------------------Properties------------------------------------------------------------------------*/
		private var _stage:DisplayObject;
		private var _keys:Array;
		private var _kbManger:KeyboardManagerEvent;
		/*--------------------------------------------------------------------------Constructor------------------------------------------------------------------------*/
		
		public function KeyboardManager( stage:DisplayObject ) 
		{	
			_stage = stage;
			init();		
		}	
		
		private function init( ):void 
		{			
			addKeyboardListener();
			setKeys();
			trace( "init keyboardManager" );
		}
		
		public function destroy ( ):void 
		{
			removeKeyboardListener(  );	
			_keys = null;
			_stage = null;
		}		
		
		/*--------------------------------------------------------------------------Methods------------------------------------------------------------------------*/
		private function addKeyboardListener (  ):void 
		{	if( _stage != null ){		
				_stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyboardDown );
				_stage.addEventListener( KeyboardEvent.KEY_UP, onKeyboardUp );
			}
		}
		
		private function removeKeyboardListener(  ):void 
		{
			_stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyboardDown );
			_stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyboardUp );		
		}
		
		public function setKeys():void 
		{			
			_keys = new Array();
			_keys[ 37 ] = "LEFT";
			_keys[ 38 ] = "UP";
			_keys[ 39 ] = "RIGHT";
			_keys[ 40 ] = "DOWN";
			_keys[ 65 ] = "LEFT";
			_keys[ 87 ] = "UP";
			_keys[ 68 ] = "RIGHT";
			_keys[ 83 ] = "DOWN";
			_keys[ 32 ] = "SPACE";
			_keys[ 27 ] = "ESC";
			_keys[ 80 ] = "P";
			_keys[ 81 ] = "Q";
			_keys[ 69 ] = "E";
			_keys[ 67 ] = "C";
			_keys[ 49 ] = "1";
			_keys[ 50 ] = "2";
			_keys[ 51 ] = "3";			
		}
		
		/*--------------------------------------------------------------------------Getters------------------------------------------------------------------------*/
		
		
		/*--------------------------------------------------------------------------Setters------------------------------------------------------------------------*/
		
		
		/*--------------------------------------------------------------------------EventHandlers------------------------------------------------------------------------*/
		
		
		private function onKeyboardDown ( e:KeyboardEvent ):void 
		{			
			var key:String = "KEY_NOT_SET";
			var keyPressed:int = e.keyCode;
			trace( "keyDown", keyPressed );
			//trace( "[KBManager]keyPressed", keyPressed );
			
			for (var i:* in _keys ) 
			{				
				if ( keyPressed == i ) {
					//trace( "see", i , _keys[ i ] );
					//trace( "keypressed: ", _keys[ i ] );
					key = _keys[ i ];
					break;
				}				
			}			
			
			_kbManger = new KeyboardManagerEvent( KeyboardManagerEvent.KEY_DOWN );
			_kbManger.key = key;
			dispatchEvent( _kbManger );
		}
		
		private function onKeyboardUp ( e:KeyboardEvent ):void
		{			
			var keyPressed:int = e.keyCode;
			var key:String = "KEY_NOT_SET";			
			
			for (var i:* in _keys ) 
			{				
				if ( keyPressed == i ){					
					key = _keys[ i ];
					break;
				}				
			}			
			
			_kbManger = new KeyboardManagerEvent( KeyboardManagerEvent.KEY_UP );
			_kbManger.key = key;
			dispatchEvent( _kbManger );			
		}
		
	}

}