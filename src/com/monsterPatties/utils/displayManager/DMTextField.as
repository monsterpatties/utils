package com.monsterPatties.utils.displayManager 
{
	import com.monsterPatties.utils.interfaces.IDestroyable;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author jc
	 */
	public class DMTextField extends Sprite implements IDestroyable
	{
		/*----------------------------------------------------------Constant--------------------------------------------------*/
		
		/*----------------------------------------------------------Properties--------------------------------------------------*/
		private var _txtField:TextField;
		private var _txt:String;
		private var _selectable:Boolean;
		
		/*----------------------------------------------------------Cosntructor--------------------------------------------------*/
		public function DMTextField( txt:String ) 
		{
			_txt = txt;
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			setDisplay();
		}
		
		/*----------------------------------------------------------Methods--------------------------------------------------*/
		private function setDisplay():void 
		{
			_txtField = new TextField();
			_txtField.text = _txt;
			_txtField.selectable = _selectable;
			addChild( _txtField );
		}
		
		private function removeDisplay():void 
		{
			if ( _txtField != null ) {
				if ( this.contains( _txtField ) ) {
					this.removeChild( _txtField );
					_txtField = null;
				}
			}
		}
		
		
		public function destroy():void 
		{
			removeDisplay();
		}	
		
		public function setTxtFormat( txtFormat:TextFormat ):void 
		{			
			_txtField.embedFonts = true;
			_txtField.setTextFormat( txtFormat );
			trace( "set Text" );
		}
		
		/*----------------------------------------------------------Setters--------------------------------------------------*/
		public function set selectable(value:Boolean):void 
		{
			_selectable = value;
		}
		/*----------------------------------------------------------Getters--------------------------------------------------*/
		public function get selectable():Boolean 
		{
			return _selectable;
		}
		/*----------------------------------------------------------EventHandlers--------------------------------------------------*/
		
	}

}