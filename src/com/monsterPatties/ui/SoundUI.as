package com.monsterPatties.ui 
{
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.soundManager.SoundManager;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class SoundUI extends Sprite
	{
		/*------------------------------------------------------------------Constant--------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------Properties------------------------------------------------------------------*/
		private var _mc:SoundUIMC;
		private var _xPos:Number;
		private var _yPos:Number;
		private var _bm:ButtonManager;
		private var _soundManager:SoundManager;
		/*------------------------------------------------------------------Constructor-----------------------------------------------------------------*/
		
		
		public function SoundUI( xPos:Number, yPos:Number ) 
		{
			_soundManager = SoundManager.getInstance();
			_xPos = xPos;
			_yPos = yPos;
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*------------------------------------------------------------------Methods--------------------------------------------------------------------*/
		private function setDisplay():void 
		{	
			addSoundManager();
			
			_mc = new SoundUIMC();
			addChild( _mc );		
			_mc.x = _xPos;
			_mc.y = _yPos;
			
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc.sfxBtn );
			_bm.addBtnListener( _mc.bgBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				removeSoundManager();
				_bm.removeBtnListener( _mc.sfxBtn );
				_bm.removeBtnListener( _mc.bgBtn );				
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
			_soundManager.loadBgm( "bgm1", new Bgm1 );			
			_soundManager.selectBgMusic( "bgm1" );
			_soundManager.SetBgmVolume( .5 );
			_soundManager.playBgMusic();			
			
			_soundManager.loadSfx( "getItem", new GetItem );
			//_soundManager.selectSfx( "getItem" );
			//_soundManager.playSoundSfx( false );
			trace( "[GE] add soundmanager Play again" );
		}
		
		private function removeSoundManager():void 
		{			
			_soundManager.stopBgMusic();
			_soundManager.stopSoundEffect();
			_soundManager.unloadBgm();
			_soundManager.unloadSfx();
		}
		/*------------------------------------------------------------------Setters--------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------Getters--------------------------------------------------------------------*/
		
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
						_mc.sfxBtn.gotoAndStop( 3 );
					}
				break;
				
				case "bgBtn":
					if ( !_soundManager.bgmOff ){
						_mc.bgBtn.gotoAndStop( 1 );
					}else {
						_mc.bgBtn.gotoAndStop( 3 );
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
						_mc.sfxBtn.gotoAndStop( 2 );
					}else {
						_mc.sfxBtn.gotoAndStop( 3 );
					}					
				break;
				
				case "bgBtn":
					if ( !_soundManager.bgmOff ){
						_mc.bgBtn.gotoAndStop( 2 );
					}else {
						_mc.bgBtn.gotoAndStop( 3 );
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
						_soundManager.muteSfx();
						_mc.sfxBtn.gotoAndStop( 3 );
					}else {
						_soundManager.unMuteSfx();
						_mc.sfxBtn.gotoAndStop( 1 );
					}
				break;
				
				case "bgBtn":
					if ( !_soundManager.bgmOff ) {
						_soundManager.muteBgm();
						_mc.bgBtn.gotoAndStop( 3 );
					}else {
						_soundManager.unMuteBgm();
						_mc.bgBtn.gotoAndStop( 1 );
					}
				break;			
				
				default:
				break;
			}
		}
	}

}