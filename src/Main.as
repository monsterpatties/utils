package 
{
	import com.monsterPatties.config.GameConfig;	
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.frameRateViewer.FrameRateViewer;
	import com.monsterPatties.utils.memoryProfiler.MemoryProfiler;
	import com.monsterPatties.views.GameOverScreen;
	import com.monsterPatties.views.GameScreen;
	import com.monsterPatties.views.HowToPlayScreen;
	import com.monsterPatties.views.LevelSelectScreen;
	import com.monsterPatties.views.PausedScreen;
	import com.monsterPatties.views.TitleScreen;
	import com.monsterPatties.views.UpgradeScreen;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author monsterpatties
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		/*-------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*-------------------------------------------------Properties---------------------------------------------------------------*/
		private var _dm:DisplayManager;
		private var _frameRateViewer:FrameRateViewer;
		private var _memoryProfiler:MemoryProfiler;	
		/*-------------------------------------------------Constructor---------------------------------------------------------------*/
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addDisplayManager();
			// entry point
		}
		
		/*-------------------------------------------------Methods---------------------------------------------------------------*/
		private function addDisplayManager():void 
		{
			_dm = DisplayManager.getInstance();
			addChild( _dm );
			
			_dm.addScreen( new HowToPlayScreen( DisplayManagerConfig.HOW_TO_PLAY_SCREEN, GameConfig.GAME_WIDTH, GameConfig.GAME_HEIGHT ) );
			_dm.addScreen( new GameOverScreen( DisplayManagerConfig.GAME_OVER_SCREEN, GameConfig.GAME_WIDTH, GameConfig.GAME_HEIGHT ) );
			_dm.addScreen( new PausedScreen( DisplayManagerConfig.PAUSED_SCREEN, GameConfig.GAME_WIDTH, GameConfig.GAME_HEIGHT ) );
			_dm.addScreen( new GameScreen( DisplayManagerConfig.GAME_SCREEN, GameConfig.GAME_WIDTH, GameConfig.GAME_HEIGHT ) );
			_dm.addScreen( new TitleScreen( DisplayManagerConfig.TITLE_SCREEN, GameConfig.GAME_WIDTH, GameConfig.GAME_HEIGHT ) );
			_dm.addScreen( new LevelSelectScreen( DisplayManagerConfig.LEVEL_SELECTION_SCREEN, GameConfig.GAME_WIDTH, GameConfig.GAME_HEIGHT ) );
			_dm.addScreen( new UpgradeScreen( DisplayManagerConfig.UPGRADE_SCREEN, GameConfig.GAME_WIDTH, GameConfig.GAME_HEIGHT ) );
			_dm.loadScreen( DisplayManagerConfig.TITLE_SCREEN  );
			
			
			if( GameConfig.isDebug ){
				_frameRateViewer = new FrameRateViewer();
				addChild( _frameRateViewer );
				
				_memoryProfiler = new MemoryProfiler();
				addChild( _memoryProfiler );
			}			
		}
		/*-------------------------------------------------Getters---------------------------------------------------------------*/
		
		/*-------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*-------------------------------------------------EventHandlers---------------------------------------------------------------*/

	}

}