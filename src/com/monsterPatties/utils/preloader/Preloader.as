package 
{	
	import com.monsterPatties.config.GameConfig;	
	import com.monsterPatties.utils.kongregateApi.Kong;
	import com.monsterPatties.utils.kongregateApi.KongregateApi;
	import com.monsterPatties.utils.siteLocker.SiteLocker;
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	//just change mc and ur on or use monsterpatties swc preloadeGraphics
	 [SWF(width = "640", height = "480", frameRate = "30", backgroundColor = "#000000")]
	public class Preloader extends MovieClip 
	{
		
		/*---------------------------------------------------------Constant-----------------------------------------------*/
		
		/*---------------------------------------------------------Properties-----------------------------------------------*/
		private var _preloader:preloaderMC;
		private const CENTER:Boolean = false;
		private var _kongApi:KongregateApi;
		private var _kong:Kong;
		private var _siteLocker:SiteLocker;
		/*---------------------------------------------------------Constructor-----------------------------------------------*/
		
		
		public function Preloader() 
		{		
			if (stage) {
				//stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			
			_siteLocker = new SiteLocker();
			var arr:Array = [ "flashgamelicense.com", "monsterpatties.net", "kongregate.com","https://www.flashgamelicense.com", "http://www.flashgamelicense.com" ];
			var valid:Boolean = _siteLocker.locked( arr, loaderInfo );
			
			if ( GameConfig.isLive ) {
				if( valid ){			
					initGamePreloader();
				}else {
					trace("this game is stolen fuck you!!");
				}
			}else {
				initGamePreloader();
			}			
		}
		
		/*---------------------------------------------------------Methods-----------------------------------------------*/
		
		private function initGamePreloader():void 
		{
			// TODO show loader
			trace( "preloader started...." );
			
			setDisplay();
				
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);			
			
			
			if ( GameConfig.isLive ) {
				if( GameConfig.isKongregate ){
					_kong = Kong.getInstance();			
					Kong.connectToKong( stage, kongLoadComplete );			
				}
			}
		}
		
		private function kongLoadComplete():void 
		{
			Kong.getPlayerInfo();
			trace( "kong load complete!" );
		}
		
		private function setDisplay():void 
		{
			_preloader = new preloaderMC();
			addChild( _preloader );
			
			if( CENTER ){
				_preloader.x = GameConfig.gameWidth / 2 - _preloader.width / 2;
				_preloader.y = GameConfig.gameHeight / 2 - _preloader.height / 2;
			}
		}
		
		private function removeDisplay():void 
		{
			if ( _preloader != null ) {
				if ( this.contains( _preloader ) ) {
					this.removeChild( _preloader );
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
			trace( "preloader ended...." );
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
			_preloader.txtLoading.text = "Loading " + Math.floor( percent * 100 ) + " %";
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