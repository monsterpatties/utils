package com.monsterPatties.utils.fontManager 
{
	import flash.filters.GlowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author jc
	 */
	public class FontManager 
	{
		/*---------------------------------------------------------------Constant---------------------------------------------------------*/
		
		/*---------------------------------------------------------------Properties---------------------------------------------------------*/
		public static var _instance:FontManager;
		/*---------------------------------------------------------------Constructor---------------------------------------------------------*/
		
		
		public function FontManager( enforcer:SingletonEnforcer ) 
		{
			init();
		}
		
		public static function getInstance():FontManager 
		{
			if ( FontManager._instance == null ) {
				FontManager._instance = new FontManager( new SingletonEnforcer() );
			}
			
			return FontManager._instance;
		}
		
		/*---------------------------------------------------------------Methods---------------------------------------------------------*/
		private function init():void 
		{		
			var len:int = FontManagerConfig.FONT_LIST.length;
			for ( var i:int = 0; i < len; i++) 
			{				
				Font.registerFont( FontManagerConfig.FONT_LIST[ i ] );
				var font:* = FontManagerConfig.FONT_LIST[ i ];
				var fontName:String = new font().fontName;				
				trace( "myFontNames", fontName );
			}			
			
			
			//txtField = _messageBoxMc.txtScore;
			//txtFormat = txtField.getTextFormat();
			//txtFormat.font = 'AdLib BT';
			//txtField.embedFonts = true;
			//txtField.selectable = false;
			//txtField.setTextFormat( txtFormat );
			
			//sample how to use
			//var fontManager:FontManager = FontManager.getInstance();
			//btn.txtOverview.setTextFormat( fontManager.getTxtFormat( 0 ) );
		}
		
		//public function integrateFont( txtField:TextField , whichFont:int ):TextField 
		//{			
			//var txtFormat:TextFormat;
			//txtFormat.color = 0x00E4FF;			
			//txtFormat.align = TextFormatAlign.CENTER;
			//
			//txtFormat = txtField.getTextFormat();
			//if( whichFont <= FontManagerConfig.FONT_NAME.length ){
				//txtFormat.font = FontManagerConfig.FONT_NAME[ whichFont  ];
			//}else {
				//txtFormat.font = FontManagerConfig.FONT_NAME[ 0 ];				
			//}
			//
			//txtField.embedFonts = true;
			//txtField.selectable = false;
			//txtField.setTextFormat( txtFormat );
			//
			//return txtField;
		//}
		
		
		public function getTxtFormat( whichFont:int, color:String = "0x000000", size:int = 12,
									  bold:Boolean = false, italic:Boolean = false  ):TextFormat 
		{		
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.color = color;
			txtFormat.size = size;
			txtFormat.bold = bold;
			txtFormat.bold = italic;
			txtFormat.align = TextFormatAlign.CENTER;			
			
			if( whichFont <= FontManagerConfig.FONT_NAME.length ){
				txtFormat.font = FontManagerConfig.FONT_NAME[ whichFont  ];
			}else {
				txtFormat.font = FontManagerConfig.FONT_NAME[ whichFont ];
			}			
			
			return txtFormat;
		}
		
		
		public function getTextField( label:String , whichFont:int, border:Boolean = false ):TextField 
		{
			var txt:TextField = new TextField();
			txt.text = label;
			txt.border = border;
			txt.width = 75;
			txt.x = 0;
			txt.y = 0;
			
			
			txt.getTextFormat();
			txt.embedFonts = true;
			txt.selectable = false;
			
			if ( whichFont > FontManagerConfig.FONT_LIST.length ) {
				whichFont = 0;
			}
			
			txt.setTextFormat( getTxtFormat( whichFont ) );
			
			
			var filt:GlowFilter = new GlowFilter;
			  //
			//here we add some properties to the two filters, the glow filter we give a color.   
			filt.color = 0x0188B5;  
			  //
			//and how much it should blur.   
			filt.blurX = 4;  
			filt.blurY = 4;  
			  //
			filt.strength = 2000;		
			txt.filters = [ filt ];
			
			
			return txt;
		}
		
		/*---------------------------------------------------------------Getters---------------------------------------------------------*/
		
		/*---------------------------------------------------------------Setters---------------------------------------------------------*/
		
		/*---------------------------------------------------------------EventHandlers---------------------------------------------------------*/
		
	}

}

class SingletonEnforcer{}
