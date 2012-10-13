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
		public function locked( arr:Array, info:LoaderInfo ):Boolean 
		{			
			var valid:Boolean;
			var siteArray:Array = arr;			
		
			for ( var a:* in siteArray ){
				trace( "[SiteLocker]: see site", siteArray[ a ], "index of: ", info.url.indexOf( siteArray[ a ] ) );
				if ( info.url.indexOf( siteArray[ a ] ) >= 0  ) {
					trace( "[SiteLocker]: valid website / machine", siteArray[ a ] );
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