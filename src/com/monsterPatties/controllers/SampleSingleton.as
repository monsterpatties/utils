package com.monsterPatties.controllers 
{
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class SampleSingleton 
	{
		
		private static var _instance:SampleSingleton;
		
		public function SampleSingleton( enforcer:SingletonEnforcer ) 
		{
			
		}
		
		public static function getInstance():SampleSingleton {
			if ( SampleSingleton._instance == null ) {
				SampleSingleton._instance = new SampleSingleton( new SingletonEnforcer() );
			}
			
			return SampleSingleton._instance;
		}
		
	}

}

class SingletonEnforcer{}