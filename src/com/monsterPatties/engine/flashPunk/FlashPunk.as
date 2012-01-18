package com.monsterPatties.engine.flashPunk 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class FlashPunk extends Engine
	{
		
		public function FlashPunk() 
		{
			super( 640, 480, 60, false );
			FP.world =  new MyWorld();
		}
		
		override public function init():void 
		{
			super.init();
			trace( "[Flashpunk] started successfully!" );
			
		}
		
	}

}