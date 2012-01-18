package com.surnia.socialStar.utils.xmlParser 
{	
	import com.surnia.socialStar.utils.xmlParser.events.XMLExtractorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.xml.XMLDocument;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class XMLExtractor extends EventDispatcher
	{
		/*---------------------------------------------------------------Constant--------------------------------------------*/
		
		
		/*---------------------------------------------------------------Properties--------------------------------------------*/
		private var _xml:XML;
		private var _myLoader:URLLoader;
		private var _xmlExtractorEvent:XMLExtractorEvent;
		private var _timer:Timer;
		private var _tick:int;
		/*---------------------------------------------------------------Constrcutor--------------------------------------------*/
		
		
		public function XMLExtractor() 
		{
			
		}
		
		/*---------------------------------------------------------------Methods--------------------------------------------*/
		public function extractXmlData( url:String ):void 
		{			
			trace( "extract xml................." );
			_myLoader = new URLLoader();
			//_myLoader.load(new URLRequest("http://apps.facebook.com/surniatrailer/fb/fl.php"));
			//_myLoader.load(new URLRequest("http://apps.facebook.com/surniatrailer/public/fb/fl.php"));										   
			//_myLoader.load(new URLRequest("http://202.124.129.14/surnia/public/fb/fl.php"));
			//_myLoader.load(new URLRequest("http://202.124.129.14/surnia/data/playerui"));
			//_myLoader.load(new URLRequest("http://www.w3schools.com/xml/note.xml") );
			//_myLoader.load(new URLRequest("http://monsterpatties.net/test/hello.php") );
			//_myLoader.load(new URLRequest("http://monsterpatties.net/test/sample.xml") );
			//_myLoader.load(new URLRequest("http://monsterpatties.net/test/hello2.php") );
			//_myLoader.load(new URLRequest("http://monsterpatties.net/test/player.xml") );
			_myLoader.load(new URLRequest(url) );
			_myLoader.addEventListener( Event.COMPLETE, onProcessXMLComplete );
			_myLoader.addEventListener( IOErrorEvent.IO_ERROR, onError );			
		}	
		
		
		/*---------------------------------------------------------------Setters--------------------------------------------*/
		public function set xml(value:XML):void 
		{
			_xml = value;
		}
		/*---------------------------------------------------------------Getters--------------------------------------------*/
		public function get xml():XML 
		{
			return _xml;
		}
		/*---------------------------------------------------------------EventHandlers--------------------------------------*/
		private function onProcessXMLComplete(e:Event):void {
			
			//trace( "xml result: ",e.target.data );
			//var xml:XML = XML( e.target.data);			
			//var xmlDoc:XMLDocument = new XMLDocument();
			//xmlDoc.ignoreWhite = true;
			//xmlDoc.parseXML(xml);
			//trace( xmlDoc );
			//trace( xml );
			
			
			
			try {
				_xml = new XML(e.target.data);
				_xml.ignoreWhite  = true;
				
				//SAME
				//trace( "see me", _xml );
				//trace( "see me", _xml.* );
				
				//trace( "see me", _xml.IMAGE );
				//trace( "see me", _xml.IMAGE.* );
				//trace( "see me", _xml.IMAGE[ 0 ] );
				//trace( "see me", _xml.IMAGE.@TITLE );
				
				//SAME
				//trace( "see me", _xml.IMAGE.@TITLE[ 1 ] );
				//trace( "see me", _xml.IMAGE[ 1 ].@TITLE );
				
				//trace( "see me", _xml.IMAGE.( @TITLE=="garden") );
				//trace( "see me", _xml.IMAGE.length() );
				//trace( "see me", _xml.*.length() );
				
				//trace( "see me", _xml.friend.@name[ 0 ] );
				//var fLen:int = _xml.friend.length();
				//for (var i:int = 0; i < fLen; i++) 
				//{
					//trace( "Friend # ",i,": ", _xml.friend[ i ].@fbid,  _xml.friend[ i ].@name, _xml.friend[ i ].@pic );
				//}
				
				
				_myLoader.removeEventListener(Event.COMPLETE, onProcessXMLComplete);
				_myLoader.removeEventListener(IOErrorEvent.IO_ERROR,
				onError);
				
				_xmlExtractorEvent = new XMLExtractorEvent( XMLExtractorEvent.XML_EXTRACTION_COMPLETE );
				dispatchEvent( _xmlExtractorEvent );
			} catch (err:Error) {
				trace("Could not parse loaded content as XML:\n" + err.
				message);
				
				_xmlExtractorEvent = new XMLExtractorEvent( XMLExtractorEvent.XML_EXTRACTION_FAILED );
				dispatchEvent( _xmlExtractorEvent );
			}			
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			trace( "loading xml error!!!..........." );
			_xmlExtractorEvent = new XMLExtractorEvent( XMLExtractorEvent.XML_EXTRACTION_FAILED );
			dispatchEvent( _xmlExtractorEvent );
		}		
	}

}