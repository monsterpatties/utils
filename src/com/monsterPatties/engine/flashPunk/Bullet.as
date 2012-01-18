package com.monsterPatties.engine.flashPunk 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class Bullet extends Entity
	{
		[Embed(source = 'assets/weapons/missile.png')] private const BULLET:Class;
		
		public function Bullet() 
		{
			setHitbox( 50, 50 );
			type = "bullet";
			graphic = new Image( BULLET );
			
			x = 200;
			y = 200;
		}
		
		
		override public function update():void 
		{
			super.update();
			
			if (x < MyWorld.player.x) x += 1;
			if (x > MyWorld.player.x) x -= 1;
			if (y < MyWorld.player.y) y += 1;
			if (y > MyWorld.player.y) y -= 1;
			
			//if (Input.check(Key.LEFT)) { x -= 5; }
			//if (Input.check(Key.RIGHT)) { x += 5; }
			//if (Input.check(Key.UP)) { y -= 5; }
			//if (Input.check(Key.DOWN)) { y += 5; }
		}
		
		public function destroy():void 
		{
			// Here we could place specific destroy-behavior for the Bullet.
			FP.world.remove(this);
			trace( "[Bullet destroyed!!]" );
		}
		
		
		
	}

}