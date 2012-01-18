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
	public class MyEntity extends Entity
	{		
		[Embed(source = 'assets/ships/spaceship.png')] private const PLAYER:Class;		
		
		public function MyEntity() 
		{
			graphic = new Image( PLAYER );
			Input.define("Jump", Key.Z, Key.UP);
			Input.define("Shoot", Key.SPACE, Key.X, Key.C);			
		}
		
		override public function update():void 
		{
			super.update();
			//trace( "[myEntity] updating..........." );
			
			if (Input.check(Key.LEFT)) { x -= 5; }
			if (Input.check(Key.RIGHT)) { x += 5; }
			if (Input.check(Key.UP)) { y -= 5; }
			if (Input.check(Key.DOWN)) { y += 5; }
			
			//if (Input.pressed(Key.SPACE))
			//{
				// The spacebar was just pressed THIS frame.
				//trace( "[myEntity] pressed space" );
			//}
			//if (Input.released(Key.SPACE))
			//{
				// The spacebar was just released THIS frame.
				//trace( "[myEntity] released space" );
			//}
			
			if (Input.pressed("Jump"))
			{
				// One (or several) of the "Jump" keys was pressed this frame.
				trace( "[myEntity] One (or several) of the /'Jump/' keys was pressed this frame." );
			}
			
			if (Input.check("Shoot"))
			{
				// One (or several) of the "Shoot" keys is being held down.
				trace( "[myEntity] One (or several) of the /'Shoot/' keys is being held down." );
			}
			
			if (Input.mouseDown)
			{
				// The mouse button is held down.
				trace( "[myEntity] The mouse button is held down." );
			}
			if (Input.mousePressed)
			{
				// The mouse button was just pressed this frame.
				trace( "[myEntity] The mouse button was just pressed this frame." );
			}
			if (Input.mouseReleased)
			{
				// The mouse button was just released this frame.
				trace( "[myEntity] The mouse button was just released this frame." );
			}
			
			// Assigns the Entity's position to that of the mouse (relative to the Camera).
			x =Input.mouseX;
			y =Input.mouseY;
			// Assigns the Entity's position to that of the mouse (relative to the World).
			x =FP.world.mouseX;
			y =FP.world.mouseY;
		}
		
	}

}