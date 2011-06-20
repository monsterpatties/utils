package com.monsterPatties.test 
{
	import com.monsterPatties.utils.particleManager.ParticleManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class ParticleManagerTest extends Sprite
	{
		
		/*---------------------------------------------------------------Constant-------------------------------------------------*/
		
		private var _particle:ParticleManager;
		
		public function ParticleManagerTest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}
		
		private function setDisplay():void 
		{
			_particle = new ParticleManager( 640, 480 );
			addChild( _particle );
			addEventListener( Event.ENTER_FRAME, onGameLoop );
			_particle.createParticles( 300, 300, 50, false );
			
		}
		
		private function onGameLoop(e:Event):void 
		{
			_particle.moveParticles();
		}
		
	}

}