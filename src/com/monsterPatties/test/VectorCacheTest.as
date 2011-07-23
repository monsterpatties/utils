package com.monsterPatties.test 
{	
	import com.monsterPatties.utils.vectorCache.events.VectorCacheEvent;
	import com.monsterPatties.utils.vectorCache.VectorCache;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class VectorCacheTest extends Sprite
	{
		/*-----------------------------------------------------------------Constant---------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------properties---------------------------------------------------------------------------*/
		private var _vc:VectorCache;
		private var _vc2:VectorCache;
		private var _timer:Timer;
		private var _mc:PlanetMC;		
		private var _mc2:PlanetMC;
		/*-----------------------------------------------------------------Constructor---------------------------------------------------------------------------*/
		
		
		public function VectorCacheTest() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			setDisplay();
			trace( "init test vector cache..." );
		}
		
		/*-----------------------------------------------------------------Methods---------------------------------------------------------------------------*/
		private function setDisplay():void 
		{			
			_mc2 = new PlanetMC();
			_vc2 = new VectorCache(  );
			addChild( _vc2 );			
			_vc2.extractFrames3( _mc2, 6, true );
			_vc2.x = 200;
			_vc2.y = 100;
			_vc2.gotoAndStopCache2( 31 );
			
			//_mc = new PlanetMC();			
			//_vc = new VectorCache(  );
			//addChild( _vc );
			//_vc.extractFrames2( _mc, 7, true );
			//_vc.x = 200;
			//_vc.y = 100;			
			//_vc.addEventListener( VectorCacheEvent.CACHE_COMPLETE, onCompleteCache );
			//_vc.gotoAndStopCache( 31 );			
			//
			//_timer = new Timer( 30 );
			//_timer.addEventListener( TimerEvent.TIMER, onStartTimer );			
			//_timer.start();
		}			
		
		
		
		/*-----------------------------------------------------------------Setters---------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------Getters---------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------EventhHandlers---------------------------------------------------------------------------*/
		private function onCompleteCache(e:VectorCacheEvent):void 
		{
			//_vc.extractFrames3( _mc, 6, true );
		}
		
		//private function onAnimateVC(e:Event):void 
		//{
			//_vc.playCache( );
		//}
		
		private function onStartTimer(e:TimerEvent):void 
		{
			//_vc.playCache( );
			//_vc2.playCache2( );
		}
	}

}