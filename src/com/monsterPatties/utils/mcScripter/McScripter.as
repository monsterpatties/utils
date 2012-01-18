package com.monsterPatties.utils.mcScripter 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class McScripter 
	{
		
		/**
		 * 
		 * @param	mc - the movieclip that has the labels
		 * @param	methods - an array of functions that will be call when never reach certain labels
		 * @param	labels - an array of framelabels where the function will be place
		 */	
		 
		public static function addScript ( mc:MovieClip, methods:Array , labels:Array ):void 
		{			
			for (var i:int = 0; i < mc.totalFrames; i++ ) 
			{					
				mc.gotoAndStop( i + 1 );				
				for (var j:int = 0; j < labels.length; j++) 
				{
					if ( labels[ j ] == mc.currentFrameLabel  ){
						mc.addFrameScript( i, methods[ j ] );
						//trace( "addFrameScript" );
					}
				}
			}			
		}
		
		/**
		 * 
		 * @param	mc - movieclip that has framescript that needs to remove
		 * @param	labels - an array of framelabels where the function is added
		 */
		
		public static function removeScript ( mc:MovieClip, labels:Array ):void 
		{			
			for (var i:int = 0; i < mc.totalFrames; i++ ) 
			{					
				mc.gotoAndStop( i + 1 );				
				for (var j:int = 0; j < labels.length; j++) 
				{
					if ( labels[ j ] == mc.currentFrameLabel  ){
						mc.addFrameScript( i, null );
						//trace( "removeFrameScript" );
					}
				}
			}			
		}
		
	}

}