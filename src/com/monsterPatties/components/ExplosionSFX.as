package com.monsterPatties.components 
{
	import com.monsterPatties.utils.vectorCache.events.VectorCacheEvent;
	import com.monsterPatties.utils.vectorCache.VectorCache;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class ExplosionSFX extends Sprite
	{
		/*-----------------------------------------------------------------Constant---------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------Properties-------------------------------------------------------------------*/
		private var _mc:ExplosionMC;
		private var _vc:VectorCache;
		/*-----------------------------------------------------------------Constructor------------------------------------------------------------------*/
		
		
		public function ExplosionSFX() 
		{
			addEventListener(  Event.ADDED_TO_STAGE, init );
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
		
		/*-----------------------------------------------------------------Methods---------------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new ExplosionMC();
			addChild( _mc );
			_mc.addFrameScript( _mc.totalFrames - 2, removeDisplay );
			_mc.cacheAsBitmap = true;
			
			//_vc = new VectorCache();
			//addChild( _vc );			
			//_vc.extractFrames( _mc );
			//_vc.playCache();
			//_vc.addEventListener( VectorCacheEvent.CACHE_COMPLETE, onCacheComplete );			
			
		}		
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		/*-----------------------------------------------------------------Setters---------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------Getters---------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------EventHandlers---------------------------------------------------------------*/
		private function onCacheComplete(e:VectorCacheEvent):void 
		{
			_vc.playCache();
		}
	}

}