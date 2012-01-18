package com.monsterPatties.utils.frameRateViewer{
    import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;

	/**
	 * @author MonsterPatties
	 */
	public class FrameRateViewer extends Sprite {
		/*-------------------------------Constant---------------------------------------------*/
		
		/*-------------------------------Properties--------------------------------------------*/	
		
		private var frameRateText:TextField = null;
		private var frameRateText2:TextField = null;
		private var timer:Timer = null;
		private var frameCount:uint = 0;

		private var currentTime:int;		
		private var _lastFrameTime:Number;		
		
		
		/*-------------------------------Constructor-------------------------------------------*/
		public function FrameRateViewer () {
			addEventListener( Event.ADDED_TO_STAGE, init );			
		}
		
		private function init ( e:Event ):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );			
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );						
			
			addFrameRateViewer();		
			
			this.mouseEnabled = false;
			this.mouseChildren = false;	
		}
		
		private function destroy ( e:Event ):void 
		{			
			removeFrameRateviewer();
			removeEventListener( Event.REMOVED_FROM_STAGE, destroy );
			trace( "FrameRateViewer Garbage Collected.." );
		}
		
		/*-------------------------------Methods----------------------------------------------*/
		
		private function addFrameRateViewer():void 
		{
			frameRateText = new TextField();

			frameRateText.autoSize = 'left';
			frameRateText.background = true;
			frameRateText.backgroundColor = 0xFFFFFF;
			frameRateText.border = true;
			frameRateText.borderColor = 0x000000;
			this.addChild( frameRateText );
			
			frameRateText2 = new TextField();
			frameRateText2.autoSize = 'left';
			frameRateText2.background = true;
			frameRateText2.backgroundColor = 0xFFFFFF;
			frameRateText2.border = true;
			frameRateText2.borderColor = 0x000000;
			frameRateText2.x = 70;
			this.addChild( frameRateText2 );

			timer = new Timer( 1000 );
			timer.addEventListener( TimerEvent.TIMER, update );			
			
			currentTime = 0;
			frameCount = 0;
			timer.start();
			
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			stage.addEventListener( Event.ENTER_FRAME, countFrame );			
		}
		
		
		private function removeFrameRateviewer():void 
		{
			stage.removeEventListener( Event.ENTER_FRAME, countFrame );
			timer.stop();			
			timer.removeEventListener( TimerEvent.TIMER, update );
			timer = null;			
			
			if ( this.contains( frameRateText )  ) {
				this.removeChild( frameRateText );
				frameRateText = null;
			}
			
			if ( this.contains( frameRateText2 )  ) {
				this.removeChild( frameRateText2 );
				frameRateText2 = null;
			}
		}
		
		public function checkMe():void 
		{
			var rect:Rectangle = frameRateText.getBounds( this );
			if ( rect.contains( mouseX, mouseY ) ) {
				frameRateText.visible = false;
			}else {
				frameRateText.visible = true;
			}
			
			var rect2:Rectangle = frameRateText2.getBounds( this );
			if ( rect2.contains( mouseX, mouseY ) ) {
				frameRateText2.visible = false;
			}else {
				frameRateText2.visible = true;
			}		
		}
		
		/*-------------------------------Getters----------------------------------------------*/
		/*-------------------------------setters-----------------------------------------------*/
		
		/*-------------------------------EventHandlers---------------------------------------*/		

		private function countFrame ( event:Event ):void {
			frameCount++;
			
			var now:Number = getTimer();
			var elapsed:Number = now - _lastFrameTime;
			var framePerSecond:Number = Math.round( 1000 / elapsed );
			frameRateText2.text = "FPS: " + String ( framePerSecond );
			_lastFrameTime = now;
			
			checkMe();
		}

		private function update ( event:TimerEvent ):void {
			currentTime++;
			frameRateText.text = stage.frameRate + " : " + frameCount + " - " + currentTime;			
			frameCount = 0;					
		}		
	}
}