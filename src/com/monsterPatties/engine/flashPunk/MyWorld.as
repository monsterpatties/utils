package com.monsterPatties.engine.flashPunk 
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class MyWorld extends World
	{
		
		[Embed(source = 'assets/audio/bgm/Constancy Part One.mp3')]
		//Constancy Part One		
		private const BGM:Class;
		public var bgm:Sfx = new Sfx(BGM);
		
		public static var player:Player;
		
		public static var enemy:Enemy;
		
		public function MyWorld() 
		{
			//add( new MyEntity );
			player = new Player();
			add( player );
			enemy = new Enemy();
			add( enemy );
			
			add( new Bomb );			
			
			//bgm.play();
			// Play the sound with 50% volume and no panning.
			bgm.play(0.5);
			//FP.volume -= 0.05;
			 //FP.volume += 0.05
			 //FP.pan = -1;
			// Play the sound with 100% volume, panned to the right speaker.
			//bgm.play(1, 1);
			
			// Set the sound's volume to 25%.
			//mySfx.volume = 0.25;
			// Pan the sound to the left speaker by 50%.
			//mySfx.pan = -0.5;
		}		
	}
}