package com.monsterPatties.utils.dynamicUI 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author jc
	 */
	public class ToolTip extends MovieClip
	{
		
		/*-----------------------------------------------------------------------------------Constant--------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------Properties--------------------------------------------------------------------------*/		
		private var _txtTooltip:TextField;
		private var _txtFormat:TextFormat;
		private var _information:String;
		/*-----------------------------------------------------------------------------------Constructor--------------------------------------------------------------------------*/
		
		public function ToolTip( info:String ) 
		{
			_information = info;
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();			
		}
		
		/*-----------------------------------------------------------------------------------Methods--------------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_txtFormat = new TextFormat();
			_txtFormat.size = 15;
			
			_txtTooltip = new TextField();			
			_txtTooltip.autoSize = 'left';
			_txtTooltip.background = true;
			_txtTooltip.backgroundColor = 0xFFFFFF;
			_txtTooltip.border = true;
			_txtTooltip.borderColor = 0x000000;			
			_txtTooltip.multiline = true;
			_txtTooltip.selectable = false;
			this.addChild( _txtTooltip );	
			
			if( _information != null ){
				_txtTooltip.text = _information;
				_txtTooltip.setTextFormat( _txtFormat );
			}
		}
		
		private function removeDisplay():void 
		{
			if ( _txtTooltip != null ) {
				if ( this.contains( _txtTooltip ) ) {
					this.removeChild( _txtTooltip );
					_txtTooltip = null;
					_txtFormat = null;
				}
			}
		}
		
		/*-----------------------------------------------------------------------------------Getters--------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------Setters--------------------------------------------------------------------------*/
		/*-----------------------------------------------------------------------------------EventHandlers--------------------------------------------------------------------------*/
		
	}

}