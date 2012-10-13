package com.monsterPatties.utils.fileManager 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ...
	 */
	public class FileManager extends EventDispatcher
	{
		/*-------------------------------------------------------------------------Constant------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Properties----------------------------------------------------------------*/
		private var _fileReference:FileReference;
		private var _fileData:XML;
		private var _fileManagerEvent:FileManagerEvent;
		/*-------------------------------------------------------------------------Constructor---------------------------------------------------------------*/
		
		
		
		public function FileManager() 
		{			
			_fileReference=new FileReference(); 
			_fileData=new XML();
		}
		
		/*-------------------------------------------------------------------------Methods------------------------------------------------------------------*/
		public function saveData(data:String):void
		{
			_fileReference.addEventListener(Event.COMPLETE, onSaveComplete);
			var newXml:XML=new XML(data);			
			//_fileReference.save( newXml, "Map.xml");			
			_fileReference.save( newXml, "map.txt" );			
		}
		
		public function loadData(fileName:String, filePath:String):void //"../xml/Map.xml"
		{
			var xmlUrl:URLRequest=new URLRequest(filePath + fileName);
			var myXml:URLLoader=new URLLoader(xmlUrl);
			myXml.addEventListener(Event.COMPLETE, xmlLoaded);
		}
		public function browseAndLoadData():void
		{
			//var fileFilter:FileFilter=new FileFilter("XML Documents", "*.xml;");
			var fileFilter:FileFilter=new FileFilter("TXT Documents", "*.txt");
			_fileReference.browse([fileFilter]);
			_fileReference.addEventListener(Event.SELECT, selectHandler);
		}
		
		/*-------------------------------------------------------------------------Setters------------------------------------------------------------------*/
		/*-------------------------------------------------------------------------Getters------------------------------------------------------------------*/
		/*-------------------------------------------------------------------------EventHandlers-----------------------------------------------------------*/
		private function onSaveComplete(e:Event):void 
		{
			_fileReference.removeEventListener(Event.COMPLETE, onSaveComplete );			
			_fileManagerEvent = new FileManagerEvent( FileManagerEvent.FILE_SAVE );
			_fileManagerEvent.obj.data = _fileData;
			dispatchEvent( _fileManagerEvent );
		}		
		
		private function xmlLoaded(evt:Event):void
		{
			evt.target.removeEventListener(Event.COMPLETE, xmlLoaded);
			var xmlData:XML=new XML(evt.target.data);
			_fileData=xmlData;			
		}
		private function selectHandler(evt:Event):void
		{
			_fileReference.removeEventListener(Event.SELECT, selectHandler);
			_fileReference.addEventListener(Event.COMPLETE, loadCompleteHandler);
			_fileReference.load();
		}
		private function loadCompleteHandler(evt:Event):void
		{
			_fileReference.removeEventListener(Event.COMPLETE, loadCompleteHandler);
			var xmlData:XML=new XML(_fileReference.data);
			_fileData = xmlData;
			trace( "[FileManager]: file load complete!", _fileData );
			
			_fileManagerEvent = new FileManagerEvent( FileManagerEvent.FILE_LOADED );
			_fileManagerEvent.obj.data = _fileData;
			dispatchEvent( _fileManagerEvent );
		}
	}

}