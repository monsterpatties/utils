package com.monsterPatties.test 
{
	import com.monsterPatties.utils.randomSeed.PseudoRandom;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author jc
	 */
	public class TestRandomSeed 
	{
		
		public function TestRandomSeed() 
		{
			PseudoRandom.init( 0.3538 );
			var r1:String = String( PseudoRandom.random() * 1000000 );
			trace( "random seed: ", r1 );
		}
		
	}

}