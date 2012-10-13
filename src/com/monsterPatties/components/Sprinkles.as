package com.monsterPatties.components {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import idv.cjcat.stardust.common.clocks.SteadyClock;
	import idv.cjcat.stardust.common.emitters.Emitter;
	import idv.cjcat.stardust.twoD.handlers.DisplayObjectHandler;
	import idv.cjcat.stardust.common.clocks.SteadyClock;
	import idv.cjcat.stardust.twoD.handlers.DisplayObjectHandler;
	
	public class Sprinkles extends Sprite
	{
		
		private var container:Sprite;
		private var emitter:Emitter;
		
		public var _xpos:Number = 0;
		public var _ypos:Number = 0;
		
		public function Sprinkles( xpos:Number, ypos:Number ) {
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
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);			
		}
		
		private function buildParticleSystem():void {
			container = new Sprite();
			addChild( container );			
			
			emitter = new SprinkleEmitter(new SteadyClock(2));
			emitter.particleHandler = new DisplayObjectHandler(container);
			
			SprinkleEmitter(emitter).point.x = _xpos;
			SprinkleEmitter(emitter).point.y = _ypos;
			
			addEventListener(Event.ENTER_FRAME, mainLoop);
		}
		
		private function mainLoop(e:Event):void {
			SprinkleEmitter(emitter).point.x = _xpos;
			SprinkleEmitter(emitter).point.y = _ypos;
			emitter.step();
		}
		
		public function update( xpos:Number, ypos:Number ):void 
		{
			_xpos = xpos;
			_ypos = ypos;
			//trace( "check xy", _xpos, _ypos );
		}
	}
}