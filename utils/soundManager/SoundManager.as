package com.monsterPatties.utils.soundManager 
{		
	import com.monsterPatties.utils.soundManager.config.SoundManagerConfig;
	import com.monsterPatties.utils.soundManager.events.SoundManagerEvent;	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author ...
	 */
	public class SoundManager extends EventDispatcher
	{
		/*-------------------------------------------------------------------Constant---------------------------------------------------------------------*/
		
		
		/*-------------------------------------------------------------------Properties---------------------------------------------------------------------*/
		private static var _instance:SoundManager;
		
		private var _bgMusicSound:Sound;	
		private var _soundChannelBg:SoundChannel;
		private var _bgSoundTransForm:SoundTransform;
		private var _loopBgMusic:Boolean;	
		
		private var _soundEffect:Sound;
		private var _soundEffectChannel_1:SoundChannel;
		private var _sfxSoundTransForm:SoundTransform;
		private var _isSfxLoop:Boolean;	
		
		private var _whichBgMusic:int;
		private var _whichEffect:int;
		
		private var _playingSfx:int;
		private var _sfxStillPlaying:Boolean;
		
		private var _emptySound:Sound;
		
		private var _bgmVol:Number;
		private var _sfxVol:Number;
		
		private var _bgmOff:Boolean;
		private var _sfxOff:Boolean;
		private var _soundManagerEvent:SoundManagerEvent;
		
		private var _bgmIsPlaying:Boolean;		
		/*-------------------------------------------------------------------Constructor---------------------------------------------------------------------*/	
		
		public function SoundManager ( enforcer:SingletonEnforcer ) {
			init();
		}
			
		
		public static function getInstance():SoundManager { 
			if ( SoundManager._instance == null ) {
				SoundManager._instance = new SoundManager( new SingletonEnforcer() );
			}			
			return SoundManager._instance;			
		}	
		
		private function init( ):void 
		{				
			prepareTransform();
			trace( "SoundManagerLoaded" );			
		}
		
		public function destroy():void 
		{			
			trace( "Sound Manager Garbage Has been collected!" );
		}		
		
		/*-------------------------------------------------------------------Methods---------------------------------------------------------------------*/	
		
		public function refreshSoundManager():void 
		{
			_bgmIsPlaying = false;			
		}
		
		private function prepareTransform():void 
		{
			_sfxSoundTransForm = new SoundTransform();
			_bgSoundTransForm = new SoundTransform();			
		}
		
		public function selectBgMusic( whichBgMusic:int ):void 
		{			
			_whichBgMusic = whichBgMusic;			
			if( whichBgMusic <  SoundManagerConfig.BGM_LIST.length  ){
				_bgMusicSound = SoundManagerConfig.BGM_LIST[ whichBgMusic ];
			}else {
				throw( "SoundManagerError: Invalid selection of Bgm!" );
			}
		}
		
		public function SetBgmVolume( vol:Number = 1 ):void 
		{
			_bgmVol = vol;
			_bgSoundTransForm.volume = _bgmVol;
			if( _soundChannelBg != null  ){
				_soundChannelBg.soundTransform = _bgSoundTransForm;
			}
		}
		
		public function increaseVolume():void 
		{
			
			if ( _bgmVol < 2 ) {
				_bgmVol += 0.1;
			}else {
				_bgmVol = 2;
			}
			
			_bgSoundTransForm.volume = _bgmVol;
			if( _soundChannelBg != null  ){
				_soundChannelBg.soundTransform = _bgSoundTransForm;
			}
			
			if ( _sfxVol < 2 ) {
				_sfxVol += 0.1;
			}else {
				_sfxVol = 2;
			}			
			
			_sfxSoundTransForm.volume = _sfxVol;
			if( _soundEffectChannel_1 != null ){
				_soundEffectChannel_1.soundTransform = _sfxSoundTransForm;
			}
		}
		
		public function decreaseVolume():void 
		{
			if( _bgmVol > 0 ){
				_bgmVol -= 0.1;				
			}else {
				_bgmVol = 0;
			}
			
			_bgSoundTransForm.volume = _bgmVol;
			if( _soundChannelBg != null  ){
				_soundChannelBg.soundTransform = _bgSoundTransForm;
			}
			
			if( _sfxVol > 0 ){
				_sfxVol -= 0.1;				
			}else {
				_sfxVol = 0;
			}
			
			_sfxSoundTransForm.volume = _sfxVol;
			if( _soundEffectChannel_1 != null ){
				_soundEffectChannel_1.soundTransform = _sfxSoundTransForm;
			}
		}
		
		
		public function playBgMusic( loop:Boolean = true ):void
		{	
			if ( !_bgmIsPlaying ) {
				_bgmIsPlaying = true;
				_loopBgMusic = loop;
				
				if ( _bgMusicSound != null  ) {
					try 
					{
						stopBgMusic();		
						_soundChannelBg = new SoundChannel();
						_soundChannelBg = _bgMusicSound.play();
						_soundChannelBg.soundTransform = _bgSoundTransForm;
						_soundChannelBg.addEventListener( Event.SOUND_COMPLETE, onBgMusicComplete );					
					}catch (err:Error)
					{
						_soundChannelBg = _bgMusicSound.play();
						trace( "soundManager Error: ", err, "soundChannelbgm",_soundChannelBg, "bgmS",_bgMusicSound  );
					}
					
				}
			}
		}		
		
		public function stopBgMusic():void 
		{	
			if( _soundChannelBg != null && _bgMusicSound != null ){
				_soundChannelBg.stop();				
			}	
		}
		
		public function removeBgSound():void 
		{
			stopBgMusic();
			if( _soundChannelBg!= null ){
				_soundChannelBg.removeEventListener( Event.SOUND_COMPLETE, onBgMusicComplete );
				_bgMusicSound = null;
			}
		}		
		
		public function selectSoundEffect( whichEffect:int ):void 
		{		
			if( whichEffect < SoundManagerConfig.SOUND_EFFECT_LIST.length && whichEffect > -1 ){
				_whichEffect = whichEffect;
				_soundEffect = SoundManagerConfig.SOUND_EFFECT_LIST[ _whichEffect ];
			}else {
				throw( "SoundManagerError: Invalid selection of sfx!" );
			}
		}
		
		
		public function setSfxVolume( vol:Number ):void 
		{
			_sfxVol = vol;
			_sfxSoundTransForm.volume = vol;
			if( _soundEffectChannel_1 != null ){
				_soundEffectChannel_1.soundTransform = _sfxSoundTransForm;
			}			
		}
		
		
		public function playSoundSfx( loop:Boolean = false  ):void 
		{
			_isSfxLoop = loop;
			
			if ( ( _playingSfx + 1 ) < 30 && _soundEffect != null ){
				if ( _sfxSoundTransForm != null ) {
					try {
						_playingSfx++;
						_sfxStillPlaying = true;
						_soundEffectChannel_1 = _soundEffect.play();
						_soundEffectChannel_1.soundTransform = _sfxSoundTransForm;
						_soundEffectChannel_1.addEventListener( Event.SOUND_COMPLETE, onSoundEffectComplete );
					}catch (err:Error)
					{
						trace( "soundManager Error: playsfx"  );
					}
					
				}				
			}
		}		
		
		public function stopSoundEffect():void 
		{	
			if( _soundEffectChannel_1 != null && _soundEffect != null ){
				_soundEffectChannel_1.stop();				
			}	
		}
		
		public function removeSoundEffect():void 
		{
			if( _soundEffectChannel_1 != null && _soundEffect != null ){
				stopSoundEffect();
				_soundEffectChannel_1.removeEventListener( Event.SOUND_COMPLETE, onSoundEffectComplete );
				_soundEffect = null;
			}
		}		
		
		
		public function playModifiedSound():void 
		{
			_emptySound =  new Sound();
			_emptySound.addEventListener( SampleDataEvent.SAMPLE_DATA, onPlaySampleData );
		}		
		
		public function muteSfx():void 
		{			
			_sfxSoundTransForm.volume = 0;
			_sfxOff = true;
			if( _soundEffectChannel_1 != null ){
				_soundEffectChannel_1.soundTransform = _sfxSoundTransForm;
			}
			
			_soundManagerEvent = new SoundManagerEvent( SoundManagerEvent.TOGGLE_SFX );
			_soundManagerEvent.obj.val = _sfxOff;
			dispatchEvent( _soundManagerEvent );			
		}
		
		public function unMuteSfx():void 
		{
			_sfxSoundTransForm.volume = _sfxVol;		
			_sfxOff = false;
			if( _soundEffectChannel_1 != null ){
				_soundEffectChannel_1.soundTransform = _sfxSoundTransForm;
			}
			
			_soundManagerEvent = new SoundManagerEvent( SoundManagerEvent.TOGGLE_SFX );
			_soundManagerEvent.obj.val = _sfxOff;
			dispatchEvent( _soundManagerEvent );
		}
		
		public function muteBgm():void 
		{
			_bgSoundTransForm.volume = 0;
			_bgmOff = true;
			if( _soundChannelBg != null  ){
				_soundChannelBg.soundTransform = _bgSoundTransForm;
			}
			
			_soundManagerEvent = new SoundManagerEvent( SoundManagerEvent.TOGGLE_BGM );
			_soundManagerEvent.obj.val = _bgmOff;
			dispatchEvent( _soundManagerEvent );
		}
		
		public function unMuteBgm():void 
		{
			_bgSoundTransForm.volume = _bgmVol;
			_bgmOff = false;
			if( _soundChannelBg != null  ){
				_soundChannelBg.soundTransform = _bgSoundTransForm;
			}
			
			_soundManagerEvent = new SoundManagerEvent( SoundManagerEvent.TOGGLE_BGM );
			_soundManagerEvent.obj.val = _bgmOff;
			dispatchEvent( _soundManagerEvent );
		}	
		
		/*-------------------------------------------------------------------Getters---------------------------------------------------------------------*/		
		public function get bgmOff():Boolean { return _bgmOff; }		
		
		public function get sfxOff():Boolean { return _sfxOff; }
		/*-------------------------------------------------------------------Setters---------------------------------------------------------------------*/
		public function set bgmOff(value:Boolean):void 
		{
			_bgmOff = value;
		}	
		
		public function set sfxOff(value:Boolean):void 
		{
			_sfxOff = value;
		}
		
		
		/*-------------------------------------------------------------------EventHandlers---------------------------------------------------------------------*/
		
		private function onBgMusicComplete ( e:Event ):void 
		{			
			trace( "bg1Complte!" );	
			refreshSoundManager();
			if( _loopBgMusic ){
				playBgMusic( );
			}			
		}		
		
		private function onSoundEffectComplete ( e:Event  ):void 
		{				
			if ( _isSfxLoop ) {
				//trace( "play sfx again: ", _isSfxLoop );
				playSoundSfx( true );
			}
			_sfxStillPlaying = false;
			_playingSfx--;
		}	
		
		
		private function onPlaySampleData ( e:SampleDataEvent ):void 
		{
			var ba:ByteArray = new ByteArray();
			_bgMusicSound.extract( ba, 4061 );
			e.data.writeBytes( upOctave( ba ) );
		}
		
		
		private function upOctave( ba:ByteArray ):ByteArray 
		{
			var newBa:ByteArray = new ByteArray();
			ba.position = 0;
			while ( ba.bytesAvailable > 0 ) 
			{
				newBa.writeFloat( ba.readFloat() );
				newBa.writeFloat( ba.readFloat() );
				
				if ( ba.bytesAvailable > 0 ) {
					ba.position += 8;
				}
			}
			return newBa;
		}				
	}
}

class SingletonEnforcer { }
