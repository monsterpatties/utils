package com.monsterPatties.components 
{
	import flash.display.Sprite;	
	/**
	 * ...
	 * @author ...
	 */
	public class Sprinkle extends Sprite
	{			
		
		private var _mc:SprinkleMC;
		
		public function Sprinkle() 
		{	
			_mc = new SprinkleMC();
			addChild( _mc );			
			_mc.cacheAsBitmap = true;
		}
		
	}

}