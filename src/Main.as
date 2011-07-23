package 
{	
	import com.monsterPatties.config.GameConfig;
	import com.monsterPatties.controllers.GameDataController;	
	import com.monsterPatties.screens.CreditScreen;	
	import com.monsterPatties.screens.GameScreen;		
	import com.monsterPatties.screens.TitleScreen;
	import com.monsterPatties.test.Box2dWorldTest;
	import com.monsterPatties.test.SoundManagerTest;
	import com.monsterPatties.ui.SoundUI;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.event.DisplayManagerEvent;
	import com.monsterPatties.utils.displayQualityManager.DisplayQualityManager;
	import com.monsterPatties.utils.frameRateViewer.FrameRateViewer;	
	import com.monsterPatties.utils.memoryProfiler.MemoryProfiler;	
	import com.monsterPatties.utils.stats.Stats;	
	import flash.display.Sprite;
	import flash.events.Event;	

	/**
	 * ...
	 * @author monsterpatties
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		
		/*---------------------------------------------------------------------------Constant----------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------Properties----------------------------------------------------------*/
		private var _dm:DisplayManager;
		private var _fps:FrameRateViewer;
		private var _mp:MemoryProfiler;
		private var _soundUI:SoundUI;
		private var _dqm:DisplayQualityManager;
		/*---------------------------------------------------------------------------Constructor----------------------------------------------------------*/

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);			
			// entry point			
			
			addDisplayManager();
			//addChild( new Stats() );			
			addFpsViewer();
			addMemoryProfiler();
			addSoundUI();
			addDisplayQualityManager();
		}		
		
		/*---------------------------------------------------------------------------Methods----------------------------------------------------------*/
		private function addDisplayManager():void 
		{				
			_dm = DisplayManager.getInstance();
			addChild( _dm );			
			//
			_dm.addScreen( new GameScreen( DisplayManagerConfig.GAME_SCREEN, 640, 480 ) );
			//_dm.addScreen( new TitleScreen( DisplayManagerConfig.TITLE_SCREEN, 640, 480 ) );
			//_dm.addScreen( new CreditScreen( DisplayManagerConfig.CREDIT_SCREEN, 640, 480 ) );
			_dm.loadScreen( DisplayManagerConfig.GAME_SCREEN );
			//addChild( new Box2dWorldTest() );
		}		
		
		private function addFpsViewer():void 
		{
			_fps = new FrameRateViewer();
			addChild( _fps );
		}
		
		private function addMemoryProfiler():void 
		{
			_mp = new MemoryProfiler();
			addChild( _mp );
		}
		
		private function addSoundUI():void 
		{
			_soundUI = new SoundUI();
			addChild( _soundUI );
			_soundUI.x = 550;
			_soundUI.y = 5;
		}
		
		private function addDisplayQualityManager():void 
		{
			_dqm = DisplayQualityManager.getInstance();
			_dqm.changeQuality( stage, 0 );
		}
		/*---------------------------------------------------------------------------Setters----------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------Getters----------------------------------------------------------*/
		
		/*---------------------------------------------------------------------------EventHandlers------------------------------------------------------*/				
	}

}