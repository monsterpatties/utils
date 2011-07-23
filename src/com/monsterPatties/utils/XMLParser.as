package com.monsterPatties.utils 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class XMLParser 
	{
		/*---------------------------------------------------------------Constant--------------------------------------------*/
		
		
		/*---------------------------------------------------------------Properties--------------------------------------------*/
		private var _myXML:XML;
		
		/*---------------------------------------------------------------Constrcutor--------------------------------------------*/
		
		
		public function XMLParser() 
		{
			
		}
		
		/*---------------------------------------------------------------Methods--------------------------------------------*/
		public function extractXmlData():void 
		{			
			var myLoader:URLLoader = new URLLoader();
			myLoader.load(new URLRequest("http://apps.facebook.com/surniatrailer/fb/fl.php"));
			myLoader.addEventListener( Event.COMPLETE, onProcessXMLComplete );			
		}
		/*---------------------------------------------------------------Setters--------------------------------------------*/
		
		/*---------------------------------------------------------------Getters--------------------------------------------*/
		
		/*---------------------------------------------------------------EventHandlers--------------------------------------*/
		private function onProcessXMLComplete(e:Event):void {
			//_myXML = new XML(e.target.data);
			//trace( "see me", e.target.data );
						try {

				_myXML = new XML((URLLoader(e.target).data))
				
				for (var i:Number=0; i<_myXML..file.length(); i++) {
				trace(_myXML..file[i]);
				}

				//tillgangligaBilder.htmlText+=_myXML;
			
			} catch (e:TypeError) {
				trace("A TypeError has occurred : \r\t" + e);
			}

		}
	}

}