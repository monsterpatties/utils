package com.monsterPatties.test 
{
	import com.monsterPatties.utils.assetLoader.AssetLoader;
	import com.monsterPatties.utils.assetLoader.events.AssetLoaderEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class TestLoadSwf extends Sprite
	{
		
		/*----------------------------------------------------------------------Constant----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Properties--------------------------------------------------------------------*/
		private var _loader:AssetLoader;
		/*----------------------------------------------------------------------Constructor-------------------------------------------------------------------*/
		
		public function TestLoadSwf() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			loadAsset(  );
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}
		
		/*----------------------------------------------------------------------Methods----------------------------------------------------------------------*/
		private function loadAsset():void 
		{
			_loader = AssetLoader.getInstance();
			//_loader.loadImage( "http://monsterpatties.net/stargazer/credits.swf" );
			//_loader.loadImage( "lib/credits.swf" );
			_loader.loadImage( "../lib/assets/credits.swf" );
			_loader.addEventListener( AssetLoaderEvent.ASSET_LOAD_COMPLETE, onLoadComplete );
		}
		
		
		/*----------------------------------------------------------------------Setters----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------Getters----------------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------EventhHandlers----------------------------------------------------------------------*/
		private function onLoadComplete(e:AssetLoaderEvent):void 
		{
			var arr:Array = _loader.loadedAsset;
			addChild( arr[ 0 ] );
		}
	}

}