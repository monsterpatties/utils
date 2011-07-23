package com.monsterPatties.test 
{
	import com.monsterPatties.utils.displayManager.DMTextField;
	import com.monsterPatties.utils.fontManager.FontManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * ...
	 * @author jc
	 */
	public class TestFontManager extends Sprite
	{
		
		public function TestFontManager() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addTextField();
		}
		
		private function addTextField():void 
		{	
			var fontManager:FontManager = FontManager.getInstance();
			
			var txt:TxtMC = new TxtMC();
			addChild( txt );			
			
			txt.txtLabel.embedFonts =true;			
			txt.txtLabel.setTextFormat( fontManager.getTxtFormat( 0, "0xFF0000", 50 ) );			
			
			
			//var txtField:DMTextField = new DMTextField( "Test Mike!!!" );
			//addChild( txtField );
			
			//txtField.setTxtFormat( fontManager.getTxtFormat( 0, "0xFF0000" ) );			
		}
		
	}

}