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
			_keys = null;
			_stage = null;
		}
		
		/*
		 * 
		    Backspace = 8
			Tab = 9

			Enter = 13

			Shift = 16

			Control = 17

			CapsLock = 20

			Esc = 27

			Spacebar = 32

			PageUp = 33

			PageDown = 34

			End = 35

			Home = 36

			LeftArrow = 37

			UpArrow = 38

			RightArrow = 39

			DownArrow = 40

			Insert = 45

			Delete = 46

			NumLock = 144

			ScrLk = 145

			Pause/Break = 19
			

			a = 65

			b = 66

			c = 67
			d = 68
			e = 69

			f = 70

			g = 71

			h = 72

			i = 73

			j = 74

			k = 75

			l = 76

			m = 77

			n = 78

			o = 79

			p = 80

			q = 81

			r = 82

			s = 83

			t = 84

			u = 85

			v = 86

			w = 87

			x = 88

			y = 89

			z = 90

			0 = 48

			1 = 49
			2 = 50
			3 = 51

			4 = 52

			5 = 53

			6 = 54

			7 = 55

			8 = 56

			9 = 57

			;: = 186

			=+ = 187

			-_ = 189

			/? = 191

			`~ = 192

			[{ = 219

			\| = 220

			]} = 221

			"' = 222

			, = 188

			. = 190

			/ = 191

			Numpad 0 = 96

			Numpad 1 = 97

			Numpad 2 = 98

			Numpad 3 = 99

			Numpad 4 = 100
			
			Numpad 5 = 101
			Numpad 6 = 102

			Numpad 7 = 103

			Numpad 8 = 104

			Numpad 9 = 105

			Numpad Multiply = 106

			Numpad Add = 107

			Numpad Enter = 13

			Numpad Subtract = 109

			Numpad Decimal = 110

			Numpad Divide = 111

			F1 = 112

			F2 = 113

			F3 = 114

			F4 = 115

			F5 = 116

			F6 = 117

			F7 = 118

			F8 = 119

			F9 = 120

			F10 = nokey

			F11 = 122

			F12 = 123

			F13 = 124

			F14 = 125
			F15 = 126
		 * 
		 * */
		
		public function setKeys():void 
		{			
			_keys = new Array();
			_keys[ 37 ] = "LEFT";
			_keys[ 38 ] = "UP";
			_keys[ 39 ] = "RIGHT";
			_keys[ 40 ] = "DOWN";
			
			//_keys[ 65 ] = "LEFT";
			//_keys[ 87 ] = "UP";
			//_keys[ 68 ] = "RIGHT";
			//_keys[ 83 ] = "DOWN";
			
			_keys[ 48 ] = "0";
			_keys[ 49 ] = "1";
			_keys[ 50 ] = "2";
			_keys[ 51 ] = "3";
			_keys[ 52 ] = "4";
			_keys[ 53 ] = "5";
			_keys[ 54 ] = "6";
			_keys[ 55 ] = "7";
			_keys[ 56 ] = "8";
			_keys[ 57 ] = "9";
			_keys[ 186 ] = ";:";
			_keys[ 187 ] = "=+";
			_keys[ 189 ] = "-_";
			_keys[ 191 ] = "/?";
			_keys[ 192 ] = "`~";
			_keys[ 219 ] = "[{";
			_keys[ 220 ] = "\|";
			_keys[ 221 ] = "]}";
			_keys[ 222 ] = "\"'";
			//"' = 222
			_keys[ 188 ] = ",";
			_keys[ 190 ] = ".";
			_keys[ 191 ] = "/";
			
			_keys[ 65 ] = "A";
			_keys[ 66 ] = "B";
			_keys[ 67 ] = "C";
			_keys[ 68 ] = "D";
			_keys[ 69 ] = "E";
			_keys[ 70 ] = "F";
			_keys[ 71 ] = "G";
			_keys[ 72 ] = "H";
			_keys[ 73 ] = "I";
			_keys[ 74 ] = "J";
			_keys[ 75 ] = "K";
			_keys[ 76 ] = "L";
			_keys[ 77 ] = "M";
			_keys[ 78 ] = "N";
			_keys[ 79 ] = "O";
			_keys[ 80 ] = "P";
			_keys[ 81 ] = "Q";
			_keys[ 82 ] = "R";
			_keys[ 83 ] = "S";
			_keys[ 84 ] = "T";
			_keys[ 85 ] = "U";
			_keys[ 86 ] = "V";
			_keys[ 87 ] = "W";
			_keys[ 88 ] = "X";
			_keys[ 89 ] = "Y";
			_keys[ 90 ] = "Z";
			
			_keys[ 8 ] = "BACK_SPACE";
			_keys[ 9 ] = "TAB";	
			_keys[ 13 ] = "ENTER";
			_keys[ 16 ] = "SHIFT";
			_keys[ 17 ] = "CONTROL";
			_keys[ 20 ] = "CAPSLOCK";
			_keys[ 27 ] = "ESC";
			_keys[ 32 ] = "SPACE";
			_keys[ 33 ] = "PAGE_UP";
			_keys[ 34 ] = "PAGE_DOWN";
			_keys[ 35 ] = "END";
			_keys[ 36 ] = "HOME";
			_keys[ 45 ] = "INSERT";
			_keys[ 46 ] = "DELETE";
			_keys[ 144 ] = "NUMLOCK";
			_keys[ 145 ] = "SCROLL_LOCK";
			_keys[ 19 ] = "BREAK";
			_keys[ 19 ] = "PAUSED";
			
			
			_keys[ 96 ] = "Numpad_0";
			_keys[ 97 ] = "Numpad_1";
			_keys[ 98 ] = "Numpad_2";
			_keys[ 99 ] = "Numpad_3";
			_keys[ 100 ] = "Numpad_4";
			_keys[ 101 ] = "Numpad_5";
			_keys[ 102 ] = "Numpad_6";
			_keys[ 103 ] = "Numpad_7";
			_keys[ 104 ] = "Numpad_8";
			_keys[ 105 ] = "Numpad_9";
			_keys[ 106 ] = "*";
			_keys[ 107 ] = "+";
			_keys[ 109 ] = "-";
			_keys[ 110 ] = "%";
			_keys[ 111 ] = "/";
			
			_keys[ 112 ] = "F1";
			_keys[ 113 ] = "F2";
			_keys[ 114 ] = "F3";
			_keys[ 115 ] = "F4";
			_keys[ 116 ] = "F5";
			_keys[ 117 ] = "F6";
			_keys[ 118 ] = "F7";
			_keys[ 119 ] = "F8";
			_keys[ 120 ] = "F9";
			_keys[ 122 ] = "F11";
			_keys[ 123 ] = "F12";
			_keys[ 124 ] = "F13";
			_keys[ 125 ] = "F14";
			_keys[ 126 ] = "F15";
			//F10 = nokey			
		}
		
		/*--------------------------------------------------------------------------Getters------------------------------------------------------------------------*/
		
		
		/*--------------------------------------------------------------------------Setters------------------------------------------------------------------------*/
		
		
		/*--------------------------------------------------------------------------EventHandlers------------------------------------------------------------------------*/
		
		
		private function onKeyboardDown ( e:KeyboardEvent ):void 
		{			
			var key:String = "KEY_NOT_SET";
			var keyPressed:int = e.keyCode;
			//trace( "keyDown", keyPressed );
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