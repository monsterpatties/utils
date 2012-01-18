package com.monsterPatties.engine.flashPunk 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class Player extends Entity
	{
		//[Embed(source = 'assets/ships/spaceship.png')] 
		[Embed(source = 'assets/chars/swordguy.png')] 
		private const PLAYER:Class;
		public var sprSwordguy:Spritemap = new Spritemap(PLAYER, 48, 32);
		
		
		
		[Embed(source = 'assets/audio/sfx/bottlerocket.mp3')]			
		private const SHOOT:Class;
		public var shoot:Sfx = new Sfx(SHOOT);
		
		public var time:int = 0;
		public var sec:Number = 0;
		
		// Movement speed (pixels per second).
		public var speed:Number = 150;		
		
		public function Player() 
		{
			setHitbox( 50, 50 );
			
			//none animated
			//graphic = new Image( PLAYER );
			
			//animated graphic
			sprSwordguy.add("stand", [0, 1, 2, 3, 4, 5], 20, true);
			sprSwordguy.add("run", [6, 7, 8, 9, 10, 11], 20, true);
			graphic = sprSwordguy;
			sprSwordguy.play( "stand" );
			
			//revoking
			//sprSwordguy.play( "run", true );
			
			Input.define("Jump", Key.Z, Key.UP);
			Input.define("Shoot", Key.SPACE, Key.X, Key.C)
		}
		
		override public function update():void 
		{
			super.update();
			
			/*
			if ( collide( "bullet", x,y ) ) {
				//colliding
			}
			*/
			
			
			// Assign the collided Bullet Entity to a temporary var.
			var b:Bullet = collide("bullet", x, y) as Bullet;

			// Check if b has a value (true if a Bullet was collided with).
			if (b)
			{
				// Call the Bullet's destroy() function.
				trace( "[PLayerEnetity]: colliding with bullet!" );
				b.destroy();
			}
			
			//if (Input.check(Key.LEFT)) { x -= 5; }
			//if (Input.check(Key.RIGHT)) { x += 5; }
			//if (Input.check(Key.UP)) { y -= 5; }
			//if (Input.check(Key.DOWN)) { y += 5; FP.pan = -1; }
			
			if (Input.check(Key.LEFT)) { x -= speed * FP.elapsed; }
			if (Input.check(Key.RIGHT)) { x += speed * FP.elapsed; }
			if (Input.check(Key.UP)) { y -= speed * FP.elapsed; }
			if (Input.check(Key.DOWN)) { y += speed * FP.elapsed; }
			
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
				// Play the sound when the spacebar is pressed.
				shoot.play();
				//shoot.stop();
				//shoot.loop();
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
			//x =Input.mouseX;
			//y =Input.mouseY;
			// Assigns the Entity's position to that of the mouse (relative to the World).
			//x =FP.world.mouseX;
			//y = FP.world.mouseY;
			
			//timing per frames
			
			//time ++;
			//if (time == 60)
			//{
				// Reset the counter after 60 frames has elapsed.
				//trace( "[player] 60 frames reacheD" );
				//time = 0;
			//}
			
			sec += FP.elapsed;
			if (sec >= 2)
			{
				// Reset the counter after 2 seconds has elapsed.
				//trace( "[player] 60 sec reacheD" );
				//sec = 0;
				sec = -2;
				//trace( "[player] 60 frames reacheD" );
			}
		}		
	}

}