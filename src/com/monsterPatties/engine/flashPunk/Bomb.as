package com.monsterPatties.engine.flashPunk 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class Bomb extends Entity
	{
		[Embed(source = 'assets/weapons/bomb.png')] private const BULLET:Class;
		
		public function Bomb() 
		{
			setHitbox( 50, 50 );
			type = "bomb";
			graphic = new Image( BULLET );
			
			x = 640;
			y = 480;		
		}
		
		
		public function explode():void
		{
			
			// First, we will create an empty array.
			var enemyList:Array = [];

			// Then, we populate the array with all existing Enemy objects!
			world.getClass(Enemy, enemyList);

			// Finally, we can loop through the array and call each Enemy's die() function.
			for each (var e:Enemy in enemyList)
			{
				e.die();
			}
			
			/*
			  getClass() -> gets all Entities by Class
				getType() -> gets all Entities by Type (faster than getClass!)
				getLayer() -> gets all Entities by layer
				classFirst() -> returns the first Entity of the Class found
				typeFirst() -> returns the first Entity of the type found
				layerFirst() -> returns the first Entity on the layer
				nearestToEntity() -> returns the Entity of a type nearest to another
				nearestToPoint() -> returns the Entity nearest to the position
				nearestToRect() -> returns the Entity nearest to the rectangular area
			 */		 
			trace( "bomb explode!!!!!!" );
		}
		
		override public function update():void 
		{
			super.update();
			if (x < MyWorld.enemy.x) x += 1;
			if (x > MyWorld.enemy.x) x -= 1;
			if (y < MyWorld.enemy.y) y += 1;
			if (y > MyWorld.enemy.y) y -= 1;
		}
		
		public function destroy():void 
		{
			// Here we could place specific destroy-behavior for the Bullet.
			FP.world.remove(this);
			trace( "[Bullet destroyed!!]" );
		}
		
		
	}

}