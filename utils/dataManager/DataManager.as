package com.surnia.socialStar.utils.dataManager 
{
	import com.adobe.serialization.json.JSON;	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author jc
	 */
	public class DataManager 
	{
		/*---------------------------------------------------------------Constant--------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------Properties--------------------------------------------------------------------*/
		private var _request:URLRequest;
		private var _variables:URLVariables;
		private var _loader:URLLoader;
		private var _urlLoaderFormat:Boolean;
		private var _jsonMode:Boolean;
		
		/*---------------------------------------------------------------Constructor--------------------------------------------------------------------*/
		
		
		public function DataManager() 
		{
			prepareUrlLoader();			
		}
		/*---------------------------------------------------------------Methods--------------------------------------------------------------------*/
		private function prepareUrlLoader():void 
		{
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onDataComplete );
			_loader.addEventListener(ProgressEvent.PROGRESS, onProgress );
			_loader.addEventListener( IOErrorEvent.IO_ERROR, onIOError  );
		}						
		
		public function sendRequestVariables( url:String , urlLoaderFormat:Boolean = false, jsonMode:Boolean = false ):void 
		{
			_urlLoaderFormat = urlLoaderFormat;
			_jsonMode = jsonMode;
			
			//if you wnt to send jason use this.
			//var data:Array = new Array();
			//data[ 'itemId' ] = 001;
			//data[ 'itemName' ] = "Chips";
			//data[ 'price' ] = 150;
			//_variables.data = JSON.encode( data);
			
			_variables = new URLVariables();
			_variables.itemId = "001";
			_variables.itemName = "chips";
			_variables.itemPrice = "150";			
			_request = new URLRequest(url);
			
			if( _urlLoaderFormat ){
				_loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			}
			_request.method = URLRequestMethod.POST;
			_request.data = _variables;			
			_loader.load(_request);
		}
		
		
		public function sendNavigateToUrl( url:String , urlLoaderFormat:Boolean = false, jsonMode:Boolean = false ):void 
		{
			_urlLoaderFormat = urlLoaderFormat;
			_jsonMode = jsonMode;			
			
			_variables = new URLVariables();
			_variables.itemId = "001";
			_variables.itemName = "chips";
			_variables.itemPrice = "150";			
			_request = new URLRequest(url);
			
			if( _urlLoaderFormat ){
				_loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			}			
			_request.data = _variables;
			navigateToURL( _request, "_blank" );
		}
		
		public function sendRequest( url:String ):void 
		{				
			_request = new URLRequest( url );			
			_loader.load(_request);
		}
		
		private function extractJsonEncodedData( data:* ):void 
		{
			//trace( "data complete...", JSON.decode( _loader.data ).name, JSON.decode( _loader.data ).last  );
			trace( "extract json" );
			
			var obj:Object = JSON.decode ( data );
			
			for ( var prop:* in obj ) 
			{
				trace( "see", prop, obj[ prop ] );
			}
		}
		/*---------------------------------------------------------------Setters--------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------Getters--------------------------------------------------------------------*/
		
		/*---------------------------------------------------------------EventHandlers--------------------------------------------------------------------*/
		private function onDataComplete(e:Event):void 
		{			
			trace( "data Complete", _loader.data );
			
			if( _jsonMode ){
				extractJsonEncodedData( _loader.data );		
			}
		}		
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace( "There's IO Error!!..." );
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			var percent:Number = e.bytesLoaded / e.bytesTotal;
			trace( "loaded", percent );
		}
	}

}