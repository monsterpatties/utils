package com.monsterPatties.test 
{
	import com.monsterPatties.controllers.GameKeyInput;
	import com.monsterPatties.utils.keyboardManager.events.KeyboardManagerEvent;
	import com.monsterPatties.utils.soundManager.SoundManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class SoundManagerTest extends Sprite
	{
		/*-------------------------------------------------------------------------Constant-------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Properties-----------------------------------------------------------------*/
		private var _soundManager:SoundManager;
		private var _gameKeyInput:GameKeyInput;
		private var _windowBg:TestSoundManagerMC;
		/*-------------------------------------------------------------------------Constructor----------------------------------------------------------------*/
		
		
		public function SoundManagerTest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			_windowBg = new TestSoundManagerMC();
			addChild( _windowBg );
			initControllers();
			addEventListener( Event.ENTER_FRAME, onGameLoop );
			trace( "init Test...." );
		}		
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			_soundManager.refreshSoundManager();
		}
		
		/*-------------------------------------------------------------------------Methods-------------------------------------------------------------------*/
		
		private function initControllers():void 
		{
			_soundManager = SoundManager.getInstance();			
			_soundManager.SetBgmVolume( 1 );
			_soundManager.setSfxVolume( 1 );
			
			_gameKeyInput = GameKeyInput.getIntance();			
			_gameKeyInput.initKeyboardListener( stage );			
		}	
		
		/*-------------------------------------------------------------------------Setters-------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Getters-------------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------Eventhandlers-------------------------------------------------------------*/		
		
		private function onGameLoop(e:Event):void 
		{
			if ( _gameKeyInput.oneIsPressed ){
				_soundManager.selectBgMusic( 0 );				
				_soundManager.playBgMusic();
			}else if ( _gameKeyInput.plusIsPressed ){
				_soundManager.increaseVolume();
			}else if ( _gameKeyInput.minusIsPressed ) {
				_soundManager.decreaseVolume();
			}else if ( _gameKeyInput.twoIsPressed ) {
				_soundManager.selectSoundEffect( 0 );				
				_soundManager.playSoundSfx();
			}else if ( _gameKeyInput.threeIsPressed ) {
				_soundManager.selectSoundEffect( 0 );				
				_soundManager.playSoundSfx();
			}
			
			if ( _gameKeyInput.muteBgm ) {
				_soundManager.muteBgm();
			}else {
				_soundManager.unMuteBgm();
			}
			
			if ( _gameKeyInput.muteSfx ) {
				_soundManager.muteSfx();
			}else {
				_soundManager.unMuteSfx();
			}
		}
	}

}