package com.monsterPatties.ui 
{
	import com.monsterPatties.controllers.GameDataController;
	import com.monsterPatties.events.GameEvent;
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.eventSatellite.EventSatellite;
	import com.monsterPatties.utils.soundManager.SoundManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class SoundGUI extends Sprite
	{
		/*------------------------------------------------------------------Constant--------------------------------------------------------------------*/
		private static var _instance:SoundGUI;
		
		public static const COLLECT_RING_SFX:String = "collectRing";
		public static const COLLECT_SPECIAL_SFX:String = "collectSpecial";
		public static const COLLECT_BAD_SFX:String = "collectBad";
		public static const BOUNCE_SFX:String = "bounce";
		public static const DIVING_SFX:String = "diving";
		public static const SPLASH_SFX:String = "splash";
		public static const GOAL_COMPLETE_SFX:String = "goalComplete";
		public static const RETRY_SFX:String = "retry";
		/*------------------------------------------------------------------Properties------------------------------------------------------------------*/
		private var _mc:BgmSfxUIMC;
		private var _xPos:Number;
		private var _yPos:Number;
		private var _bm:ButtonManager;
		private var _soundManager:SoundManager;
        private var _isBgmSfxToggle:Boolean;
		private var _es:EventSatellite;
		private var _gameEvent:GameEvent;
		private var _gdc:GameDataController;		
		/*------------------------------------------------------------------Constructor-----------------------------------------------------------------*/
		
		
		public function SoundGUI( enforcer:SingletonEnforcer ) 
		{
			_soundManager = SoundManager.getInstance();			
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		public static function getIntance():SoundGUI 
		{
			if ( SoundGUI._instance == null ) {
				SoundGUI._instance = new SoundGUI( new SingletonEnforcer() );
			}
			
			return SoundGUI._instance;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );			
			setDisplay();
		}
		
		public function setXYPos( xpos:Number, ypos:Number ):void 
		{
			_xPos = xpos
			_yPos = ypos;			
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*------------------------------------------------------------------Methods--------------------------------------------------------------------*/
		private function setDisplay():void 
		{	
			_gdc = GameDataController.getInstance();
			addSoundManager();
			
			_mc = new BgmSfxUIMC();
			addChild( _mc );		
			_mc.x = _xPos;
			_mc.y = _yPos;
			
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc.bgmBtn );
			_bm.addBtnListener( _mc.sfxBtn );
			_bm.addBtnListener( _mc.pauseBtn );
			_bm.addBtnListener( _mc.settingsBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
            
            //_mc.bgmBtn.visible = false;
            //_mc.sfxBtn.visible = false;
			
			_es = EventSatellite.getInstance();
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				removeSoundManager();
				_bm.removeBtnListener( _mc.bgmBtn );
				_bm.removeBtnListener( _mc.sfxBtn );							
				_bm.removeBtnListener( _mc.pauseBtn );
				_bm.removeBtnListener( _mc.settingsBtn );
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
				_bm.clearButtons();
				_bm = null;
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}	
		
		private function addSoundManager():void 
		{
			_soundManager =  SoundManager.getInstance();

			_soundManager.loadBgm( "bgm1", new CBgm1() );
			
			/*
			_soundManager.loadBgm( "bgm1", new BGM1 );			
			_soundManager.loadSfx( COLLECT_RING_SFX, new CollectRingSFX() , .3 );
			_soundManager.loadSfx( COLLECT_SPECIAL_SFX, new CollectSpecialSFX() , 1 );
			_soundManager.loadSfx( COLLECT_BAD_SFX, new CollectBadSFX() , 1 );
			_soundManager.loadSfx( DIVING_SFX, new DivingSFX() , 1 );
			_soundManager.loadSfx( SPLASH_SFX, new SplashSFX() , 1 );
			_soundManager.loadSfx( BOUNCE_SFX, new BounceSFX() , 1 );
			_soundManager.loadSfx( GOAL_COMPLETE_SFX, new GoalCompleteSFX() , 1 );
			_soundManager.loadSfx( RETRY_SFX, new RetrySFX() , 1 );
			*/
			trace( "[SoundGUI]: init..." );
		}
		
		private function removeSoundManager():void 
		{			
			_soundManager.stopBgMusic();
			_soundManager.stopSoundEffect();
			_soundManager.unloadBgm();
			_soundManager.unloadSfx();
		}
		
		public function muteSfx():void 
		{			
			if ( !_soundManager.sfxOff ) {
				_soundManager.muteSfx();
				_mc.sfxBtn.gotoAndStop( 2 );				
			}
			
			_soundManager.stopSoundEffect();
			_soundManager.setSfxVolume( 0 );
		}
		
		public function muteBgm():void 
		{			
			if ( !_soundManager.bgmOff ) {
				_soundManager.muteBgm();
				_mc.bgmBtn.gotoAndStop( 2 );				
			}
			
			_soundManager.stopBgMusic();
			_soundManager.SetBgmVolume( 0 );
		}
		
		public function unMuteSFX():void 
		{
			_soundManager.setSfxVolume( .6 );
			if ( _soundManager.sfxOff ) {								
				_soundManager.unMuteSfx();
				_mc.sfxBtn.gotoAndStop( 1 );
			}
		}
		
		public function unMuteBgm():void 
		{
			_soundManager.SetBgmVolume( .8 );
			if ( _soundManager.bgmOff ) {								
				_soundManager.unMuteBgm();
				_mc.bgmBtn.gotoAndStop( 1 );
				
				if ( !_soundManager.bgmIsPlaying ) {
					_soundManager.stopBgMusic();
					_soundManager.selectBgMusic( "bgm1" );
					_soundManager.SetBgmVolume( .4 );
					_soundManager.playBgMusic();
				}					
			}
		}
		
		public function playBgMusic( type:int ):void 
		{			
			if( type == 0 ){
				_soundManager.selectBgMusic( "bgm1" );
			}else if( type == 1 ){
				muteBgm();
				unMuteBgm();
			}
			
			_soundManager.SetBgmVolume( .4 );
			_soundManager.playBgMusic();
			trace( "play bg ko1" );
		}
		
		public function playSFX( sfx:String ):void 
		{			
			_soundManager.selectSfx( sfx );
			_soundManager.playSoundSfx( false );			
		}
		
        public function toggleBgmSfx():void 
        {
            if ( !_isBgmSfxToggle ) {
                _isBgmSfxToggle = true;
                muteBgm();
                muteSfx();
            }else {
                _isBgmSfxToggle = false;
                unMuteBgm();
                unMuteSFX();
            }           
        }
        
		/*------------------------------------------------------------------Setters--------------------------------------------------------------------*/
		public function set isBgmSfxToggle(value:Boolean):void 
        {
            _isBgmSfxToggle = value;
        }
		/*------------------------------------------------------------------Getters--------------------------------------------------------------------*/
		 public function get isBgmSfxToggle():Boolean 
        {
            return _isBgmSfxToggle;
        }       
        
		/*------------------------------------------------------------------EventHandlers--------------------------------------------------------------*/
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "sfxBtn":
					if ( !_soundManager.sfxOff ){
						_mc.sfxBtn.gotoAndStop( 1 );
					}else {
						_mc.sfxBtn.gotoAndStop( 2 );
					}
				break;
				
				case "bgmBtn":
					if ( !_soundManager.bgmOff ){
						_mc.bgmBtn.gotoAndStop( 1 );
					}else {
						_mc.bgmBtn.gotoAndStop( 2 );
					}
				break;			
				
				default:
				break;
			}
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "sfxBtn":
					if ( !_soundManager.sfxOff ){
						_mc.sfxBtn.gotoAndStop( 1 );
					}else {
						_mc.sfxBtn.gotoAndStop( 2 );
					}					
				break;
				
				case "bgmBtn":
					if ( !_soundManager.bgmOff ){
						_mc.bgmBtn.gotoAndStop( 1 );
					}else {
						_mc.bgmBtn.gotoAndStop( 2 );
					}
				break;				
				
				default:
				break;
			}
		}
		
		private function onClickBtn(e:ButtonEvent):void 
		{			
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "sfxBtn":
					if ( !_soundManager.sfxOff ) {						
						muteSfx();
					}else{						
						unMuteSFX();
					}
				break;
				
				case "bgmBtn":
					if ( !_soundManager.bgmOff ) {						
						muteBgm();
					}else {
						unMuteBgm();						
					}
				break;		
				
				case "pauseBtn":					
					//if ( !_gdc.getPausedGame() ) {
						//trace( "[SoundGui]: pause"  );						
						//_gameEvent = new GameEvent( GameEvent.GAME_PAUSED );						
					//}else{
						//trace( "[SoundGui]: un pause"  );						
						//_gameEvent = new GameEvent( GameEvent.GAME_UNPAUSED );
					//}
					_gameEvent = new GameEvent( GameEvent.SHOW_PAUSED_SCREEN );
					_es.dispatchESEvent( _gameEvent );
				break;
				
				case "settingsBtn":
					_gameEvent = new GameEvent( GameEvent.SHOW_GAME_SETTING );
					_es.dispatchESEvent( _gameEvent );
					trace( "[SoundGui]:click settings......." );
				break;
				
				default:
				break;
			}
		}      
	}

}

class SingletonEnforcer{}