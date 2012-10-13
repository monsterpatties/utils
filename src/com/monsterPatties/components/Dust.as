package com.monsterPatties.components 
{
	import flash.display.Sprite;	
	/**
	 * ...
	 * @author ...
	 */
	public class Dust extends Sprite
	{			
		
		private var _mc:DustMC;
		
		public function Dust() 
		{	
			_mc = new DustMC();
			addChild( _mc );			
			_mc.cacheAsBitmap = true;
		}
		
	}

}