package com.monsterPatties.test 
{
	import com.monsterPatties.test.sampleWindows.GameScreen;
	import com.monsterPatties.test.sampleWindows.OptionScreen;	
	import com.monsterPatties.test.sampleWindows.TitleScreen;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author jc
	 */
	public class TestDisplayManager extends Sprite
	{
		
		public function TestDisplayManager() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var dm:DisplayManager = DisplayManager.getInstance();
			addChild( dm );
			
			dm.addScreen( new GameScreen( DisplayManagerConfig.GAME_SCREEN  ) );
			dm.addScreen( new TitleScreen( DisplayManagerConfig.TITLE_SCREEN ) );			
			dm.addScreen( new OptionScreen( DisplayManagerConfig.OPTION_SCREEN ) );
			dm.loadScreen( DisplayManagerConfig.GAME_SCREEN );
			dm.loadScreen( DisplayManagerConfig.TITLE_SCREEN );
			dm.loadScreen( DisplayManagerConfig.GAME_SCREEN );
			dm.loadScreen( DisplayManagerConfig.TITLE_SCREEN );
			dm.removeScreen( DisplayManagerConfig.GAME_SCREEN );
			dm.loadScreen( DisplayManagerConfig.GAME_SCREEN );
			//dm.removeScreen( DisplayManagerConfig.TITLE_SCREEN );
			dm.loadScreen( DisplayManagerConfig.TITLE_SCREEN );
			//var gs2:GameScreen = new GameScreen( DisplayManagerConfig.GAME_SCREEN  );
			dm.addScreen( new GameScreen( DisplayManagerConfig.GAME_SCREEN  ) );
			dm.loadScreen( DisplayManagerConfig.GAME_SCREEN );
			dm.removeScreen( DisplayManagerConfig.OPTION_SCREEN );
			dm.addScreen( new OptionScreen( DisplayManagerConfig.OPTION_SCREEN ) );
			dm.loadScreen( DisplayManagerConfig.OPTION_SCREEN );						
		}
		
	}

}