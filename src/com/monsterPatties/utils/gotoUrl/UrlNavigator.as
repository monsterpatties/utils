package com.surnia.socialStar.utils.gotoUrl 
{
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class UrlNavigator 
	{
		
		public function UrlNavigator() 
		{
			
		}	
		
		public static function gotoUrl( url:String ):void 
		{
			 var request:URLRequest = new URLRequest( url );
			 navigateToURL(request);
		}
	}

}