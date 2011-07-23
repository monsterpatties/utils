package com.monsterPatties.utils.siteLocker 
{
	import flash.display.LoaderInfo;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class SiteLocker 
	{
		/*------------------------------------------------------------------Constant--------------------------------------------*/
		
		/*------------------------------------------------------------------Properties--------------------------------------------*/
		
		/*------------------------------------------------------------------Constructor--------------------------------------------*/
		
		public function SiteLocker() 
		{
			
		}
		
		/*------------------------------------------------------------------Methods--------------------------------------------*/
		public function locked( arr:Array, loaderInfo:LoaderInfo ):Boolean 
		{
			var valid:Boolean;		
			
			//var siteArray:Array = [ "flashgamelicense.com", "monsterpatties.net", "kongregate.com" ];
			var siteArray:Array = arr;
		
			for ( var a:* in siteArray ){				
				if ( loaderInfo.url.indexOf( siteArray[ a ] ) >= 0  ) {
					valid = true;
					break;
				}
			}	
			
			return valid;
		}
		
		/*------------------------------------------------------------------Setters--------------------------------------------*/
		
		/*------------------------------------------------------------------Getters--------------------------------------------*/
		/*------------------------------------------------------------------EventHandlers----------------------------------------*/		
		
	}

}