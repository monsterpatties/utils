package com.monsterPatties.components 
{
	import flash.display.Sprite;
	import idv.cjcat.stardust.common.emitters.Emitter;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getTimer;
	import idv.cjcat.stardust.common.clocks.SteadyClock;
	import idv.cjcat.stardust.twoD.emitters.Emitter2D;
	import idv.cjcat.stardust.twoD.handlers.DisplayObjectHandler;
	import idv.cjcat.stardust.twoD.initializers.DisplayObjectClass;
	import idv.cjcat.stardust.twoD.zones.SinglePoint;
	/**
	 * ...
	 * @author ...
	 */
	public class TrailDust extends Sprite
	{
		protected var container:Sprite;
		protected var emitter:Emitter;
		
		public var _xpos:Number = 0;
		public var _ypos:Number = 0;
		
		
		public function TrailDust( xpos:Number, ypos:Number ) 
		{
			_xpos = xpos;
			_ypos = ypos;
			addEventListener( Event.ADDED_TO_STAGE, init );			
		}
		
		private function init(e:Event):void 
		{		
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			buildParticleSystem();
		}		
		
		private function buildParticleSystem():void {			
			container = new Sprite();
			addChild( container );
			
			emitter = new DustEmitter(new SteadyClock(2));
			emitter.particleHandler = new DisplayObjectHandler(container);
			
			DustEmitter(emitter).point.x = _xpos;
			DustEmitter(emitter).point.y = _ypos;
			
			addEventListener(Event.ENTER_FRAME, mainLoop);
		}
		
		private function removeParticleSystem():void 
		{
			if ( container != null ) {
				removeEventListener(Event.ENTER_FRAME, mainLoop);
				if ( this.contains( container ) ) {
					//emitter.particleHandler = null;
					emitter = null;
					this.removeChild( container );
					container = null;
				}
			}
		}
		
		private function mainLoop(e:Event):void {
			//abstract method
			//var time:int = getTimer();
			//DustEmitter(emitter).point.x = 320 + 200 * Math.cos(time / 777);
			//DustEmitter(emitter).point.y = 240 + 75 * Math.sin(time / 333);
			//DustEmitter(emitter).point.x = this.x;
			//DustEmitter(emitter).point.y = this.y;
			DustEmitter(emitter).point.x = _xpos;
			DustEmitter(emitter).point.y = _ypos;
			emitter.step();			
			//trace( "stardust looping......." );
		}
		
		
		public function update( xpos:Number, ypos:Number ):void 
		{
			_xpos = xpos;
			_ypos = ypos;
			//trace( "check xy", _xpos, _ypos );
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeParticleSystem();
		}
	}

}