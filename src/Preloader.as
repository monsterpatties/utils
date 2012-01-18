package
{
	import com.monsterPatties.config.GameConfig;
	import com.monsterPatties.controllers.GameController;	
	import com.monsterPatties.utils.kongregateApi.Kong;
	import com.monsterPatties.utils.siteLocker.SiteLocker;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.system.Security;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	//just change mc and ur on or use monsterpatties swc preloadeGraphics
	[SWF(width="640",height="480",frameRate="30",backgroundColor="#000000")]
	
	public class Preloader extends MovieClip
	{
		
		/*---------------------------------------------------------Constant-----------------------------------------------*/
		
		/*---------------------------------------------------------Properties-----------------------------------------------*/
		private var _preloader:PreloaderMC;
		private const CENTER:Boolean = true;		
		private var _kong:Kong;
		private var _siteLocker:SiteLocker;
		private var _gameController:GameController;
		
		/*---------------------------------------------------------Constructor-----------------------------------------------*/
		
		public function Preloader()
		{
			Security.allowDomain("www.mochiads.com");
			Security.allowDomain("www.mochiads.com/static/lib/services/mochiLC.swf");
			Security.allowDomain("http://www.mochiads.com/static/lib/services/mochiLC.swf");
			Security.allowDomain("http://www.mochiads.com/static/lib/services/services.swf");
			Security.allowDomain("http://www.mochiads.com/static/lib/services/services.swf?api%5Fversion=3%2E9%2E4%20as3&listenLC=%5F%5Fms%5F1323016260010%5F14763&mochiad%5Foptions=undefined");
			Security.allowDomain("127.0.0.1");
			
			if (stage)
			{
				//stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			
			//why this thing doesn't work
			//_siteLocker = new SiteLocker();
			//var arr:Array = ["flashgamelicense.com", "monsterpatties.net", "kongregate.com", "https://www.flashgamelicense.com", "http://www.flashgamelicense.com", "mochimedia.com", "kongregate", "newgrounds","127.0.0.1"];
			//var valid:Boolean = _siteLocker.locked(arr, loaderInfo );
			//why this thing doesn't work
			
			//hacked
			var valid:Boolean = true;
			
			if (GameConfig.isLive)
			{
				if (valid)
				{
					initGamePreloader();
				}
				else
				{
					trace("this game is stolen fuck you!!");
				}
			}
			else
			{
				initGamePreloader();
			}
		}
		
		/*---------------------------------------------------------Methods-----------------------------------------------*/
		
		private function initGamePreloader():void
		{
			// TODO show loader
			trace("preloader started....");
			
			setDisplay();
			
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			if (GameConfig.isLive)
			{
				_gameController = GameController.getInstance();
				_gameController.addMochibot(this, GameConfig.MOCHI_BOT_ID );
			
				if ( GameConfig.isMochimedia ){				
					_gameController.connectMochi(root, GameConfig.MOCHI_ADS_ID, GameConfig.MOCHI_LEADER_BOARD_ID  );					
					_gameController.startGamePlay();
				}				
				
				if (GameConfig.isKongregate)
				{
					_kong = Kong.getInstance();
					Kong.connectToKong(stage, kongLoadComplete);
				}
			}
		}
		
		private function kongLoadComplete():void
		{
			Kong.getPlayerInfo();
			trace("kong load complete!");
		}
		
		private function setDisplay():void
		{
			_preloader = new PreloaderMC();
			addChild(_preloader);
			
			if (CENTER)
			{
				_preloader.x = GameConfig.GAME_WIDTH / 2 - _preloader.width / 2;
				_preloader.y = GameConfig.GAME_HEIGHT / 2 - _preloader.height / 2;
			}
		}
		
		private function removeDisplay():void
		{
			if (_preloader != null)
			{
				if (this.contains(_preloader))
				{
					this.removeChild(_preloader);
					_preloader = null;
				}
			}
		}
		
		private function loadingFinished():void
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			removeDisplay();
			startup();
			trace("preloader ended....");
		}
		
		private function startup():void
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
		/*---------------------------------------------------------Setters-----------------------------------------------*/
		
		/*---------------------------------------------------------Getters-----------------------------------------------*/
		
		/*---------------------------------------------------------EventHandlers-----------------------------------------------*/
		
		private function ioError(e:IOErrorEvent):void
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void
		{
			// TODO update loader
			var percent:Number = e.bytesLoaded / e.bytesTotal;
			_preloader.txtLoading.text = "Loading " + Math.floor(percent * 100) + " %";
			_preloader.bar.scaleX = percent;
			//trace( "loading Game..." );
		}
		
		private function checkFrame(e:Event):void
		{
			if (currentFrame == totalFrames)
			{
				stop();
				loadingFinished();
			}
		}
	
	}

}