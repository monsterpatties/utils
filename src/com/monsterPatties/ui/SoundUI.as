package com.monsterPatties.ui 
{
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.sharedObjects.SharedData;
	import com.monsterPatties.utils.soundManager.SoundManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class SoundUI extends Sprite
	{
		/*-----------------------------------------------------------------Constant-----------------------------------------------------*/
		
		/*-----------------------------------------------------------------Properties-----------------------------------------------------*/
		private var _mc:SoundUIMC;
		private var _clickedBgm:Boolean;
		private var _clickedSfx:Boolean;
		private var _soundManager:SoundManager;
		
		private var _bm:ButtonManager;
		private var _sd:SharedData;
		/*-----------------------------------------------------------------Constructor-----------------------------------------------------*/
		
		public function SoundUI() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			prepareSoundManager();
			setDisplay();
			prepareSharedData();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*-----------------------------------------------------------------Methods-----------------------------------------------------*/
		private function setDisplay():void
		{
			_mc = new SoundUIMC();
			addChild( _mc );
			
			_mc.bgBtn.buttonMode = true;
			_mc.sfxBtn.buttonMode = true;			
			
			_bm.addBtnListener( _mc.bgBtn );
			_bm.addBtnListener( _mc.sfxBtn );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickButton );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverButton );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutButton );			
		}						
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				_bm.removeBtnListener( _mc.bgBtn );
				_bm.removeBtnListener( _mc.sfxBtn );
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickButton );
				if (this.contains( _mc ) ){
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		private function prepareSoundManager():void 
		{
			_bm = new ButtonManager();
			_soundManager = SoundManager.getInstance();
		}		
		
		private function sfxTriger():void 
		{			
			if ( !_clickedSfx ) {
				_clickedSfx = true;
				muteSfx();			
			}else {				
				_clickedSfx = false;
				unMuteSfx();				
			}
			
			_sd.addSharedData( "sfx", _clickedSfx );
		}
		
		private function bgmTriger():void {			
			if ( !_clickedBgm ){
				_clickedBgm = true;
				muteBgm();
			}else {				
				_clickedBgm = false;
				unMuteBgm();
			}
			_sd.addSharedData( "bgm", _clickedBgm );
		}
		
		private function prepareSharedData():void 
		{
			_sd = SharedData.getInstance();
			
			var sfx:* = _sd.getSharedData( "sfx" );
			var bgm:* = _sd.getSharedData( "bgm" );
			
			if( sfx != null ){
				_clickedSfx = sfx;
				if ( _clickedSfx ) {
					muteSfx();
				}else {
					unMuteSfx();
				}
				
				trace( "sfx soudnUI data", _clickedSfx );
				
			}else {
				trace( "null sfx soudnUI data" );
			}
			
			if( bgm != null ){
				_clickedBgm = bgm;
				if ( _clickedBgm ) {
					muteBgm();
				}else {
					unMuteBgm();
				}
				trace( "bgm soudnUI data", _clickedBgm );
			}else {
				trace( "null bgm soudnUI data" );
			}			
		}
		
		private function muteBgm():void 
		{
			_mc.bgBtn.gotoAndStop( 3 );
			_soundManager.muteBgm();
		}
		
		private function unMuteBgm():void 
		{
			_soundManager.unMuteBgm();
			_mc.bgBtn.gotoAndStop( 1 );
		}
		
		private function muteSfx():void {
			_mc.sfxBtn.gotoAndStop( 3 );
			_soundManager.muteSfx();
		}
		
		private function unMuteSfx():void {
			_soundManager.unMuteSfx();			
			_mc.sfxBtn.gotoAndStop( 1 );
		}
		
		
		/*-----------------------------------------------------------------Setters-----------------------------------------------------*/
		
		/*-----------------------------------------------------------------Getters-----------------------------------------------------*/
		
		/*-----------------------------------------------------------------EventHandlers-----------------------------------------------------*/		
		private function onRollOutButton(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "bgBtn":
					if ( _clickedBgm ){						
						_mc.bgBtn.gotoAndStop( 3 );
					}
				break;
				
				case "sfxBtn":
					if ( _clickedSfx ){						
						_mc.sfxBtn.gotoAndStop( 3 );
					}
				break;					
				
				default:
					
				break;
			}
		}
		
		private function onRollOverButton(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "bgBtn":
					if ( _clickedBgm ){						
						_mc.bgBtn.gotoAndStop( 3 );
					}
				break;
				
				case "sfxBtn":
					if ( _clickedSfx ){						
						_mc.sfxBtn.gotoAndStop( 3 );
					}
				break;					
				
				default:
					
				break;
			}			
		}
		
		private function onClickButton(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "bgBtn":
					bgmTriger();
				break;
				
				case "sfxBtn":
					sfxTriger();
				break;					
				
				default:
					
				break;
			}
		}
	}

}