package com.monsterPatties.utils.vectorCache 
{
	import com.monsterPatties.utils.vectorCache.events.VectorCacheEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author jc
	 */
	public class VectorCache extends Sprite
	{
		
		/*------------------------------------------------------------------Constant----------------------------------------------------------------------------*/
		
		
		/*------------------------------------------------------------------Properties----------------------------------------------------------------------------*/
		public var cacheBmd:Array;
		
		public var cacheBmd2:Array;
		private var _mcHolder2:Sprite;
		public var currentFrame2:int;
		
		private var _mcHolder:Sprite;
		private var _mc:MovieClip;
		public var currentFrame:int;
		
		private var _vcEvent:VectorCacheEvent;
		
		/*------------------------------------------------------------------Constructor----------------------------------------------------------------------------*/
		
		
		public function VectorCache() 
		{
			
		}
		
		/*------------------------------------------------------------------Methods----------------------------------------------------------------------------*/
		
		
		
		public function extractFrames( mc:MovieClip ):void 
		{
			cacheBmd = new Array();
			var frameCount:int = mc.totalFrames;
			trace( "cnt", frameCount );	

			for( var i:int =1; i <= frameCount; i++	){
				mc.gotoAndStop( i );
				var bmd:BitmapData = new BitmapData( mc.width, mc.height, true , 0  );
				var bm:Bitmap = new Bitmap( bmd );
				var matrix:Matrix = new Matrix();
				var rect:Rectangle = mc.getBounds( mc );
				matrix.translate( -rect.x , -rect.y );
				bmd.draw( mc ,matrix );
				cacheBmd.push( bm );
			}
			
			currentFrame = 0;
			_mcHolder = new Sprite();
			_mcHolder.addChild( cacheBmd[ currentFrame ] );
			addChild( _mcHolder );			
			
			_vcEvent = new VectorCacheEvent( VectorCacheEvent.CACHE_COMPLETE );
			dispatchEvent( _vcEvent );
		}
		
		
		public function extractFrames2( mc:MovieClip , whatFrameToBeExtracted:int , deepExtract:Boolean ):void 
		{
			if( deepExtract ){				
				mc.gotoAndStop( whatFrameToBeExtracted );
			}		
			
			var child:* = mc.mc.getChildByName( "mc" );		
			child.visible = false;		
			
			cacheBmd = new Array();
			var frameCount:int = mc.mc.totalFrames;
			trace( "cnt", frameCount );	

			for ( var i:int = 1; i <= frameCount; i++	) {							
				mc.mc.gotoAndStop( i );				
				var bmd:BitmapData = new BitmapData( mc.mc.width, mc.mc.height, true , 0  );
				var bm:Bitmap = new Bitmap( bmd );
				var matrix:Matrix = new Matrix();
				var rect:Rectangle = mc.mc.getBounds( mc.mc );
				matrix.translate( -rect.x , -rect.y );
				bmd.draw( mc.mc ,matrix );
				cacheBmd.push( bm );				
			}
			
			currentFrame = 0;
			_mcHolder = new Sprite();
			_mcHolder.addChild( cacheBmd[ currentFrame ] );
			addChild( _mcHolder );	
			
			_vcEvent = new VectorCacheEvent( VectorCacheEvent.CACHE_COMPLETE );
			dispatchEvent( _vcEvent );
		}		
		
		
		public function extractFrames3( mc:MovieClip , whatFrameToBeExtracted:int , deepExtract:Boolean ):void 
		{
			if( deepExtract ){				
				mc.gotoAndStop( whatFrameToBeExtracted );
			}
			cacheBmd2 = new Array();
			var frameCount:int = mc.mc.mc.totalFrames;
			trace( "cnt", frameCount );	

			for ( var i:int = 1; i <= frameCount; i++	) {				
				mc.mc.mc.gotoAndStop( i );
				var bmd:BitmapData = new BitmapData( mc.mc.mc.width, mc.mc.mc.height, true , 0  );
				var bm:Bitmap = new Bitmap( bmd );
				var matrix:Matrix = new Matrix();
				var rect:Rectangle = mc.mc.mc.getBounds( mc.mc.mc );
				matrix.translate( -rect.x , -rect.y );
				bmd.draw( mc.mc.mc ,matrix );
				cacheBmd2.push( bm );				
			}
			
			currentFrame2 = 0;
			_mcHolder2 = new Sprite();
			_mcHolder2.addChild( cacheBmd2[ currentFrame2 ] );
			addChild( _mcHolder2 );		
			
			_vcEvent = new VectorCacheEvent( VectorCacheEvent.CACHE_COMPLETE );
			dispatchEvent( _vcEvent );
		}
		
		
		public function playCache():void 
		{
			if( _mcHolder != null ){
				addEventListener( Event.ENTER_FRAME, onPlayMc );
			}
		}
		
		public function playCache2():void 
		{
			if( _mcHolder2 != null ){
				addEventListener( Event.ENTER_FRAME, onPlayMc2 );
			}
		}
		
		public function gotoAndStopCache( index:int ):void{
			_mcHolder.removeChildAt( 0 );
			if( index >= cacheBmd.length ){
				index = cacheBmd.length - 1;
			}			
			_mcHolder.addChildAt( cacheBmd[ index ], 0 );
		}		
		
		public function gotoAndStopCache2( index:int ):void{
			_mcHolder2.removeChildAt( 0 );
			if( index >= cacheBmd2.length ){
				index = cacheBmd2.length - 1;
			}			
			_mcHolder2.addChildAt( cacheBmd2[ index ], 0 );
		}
		
		
		public function destroy():void 
		{
			if ( _mcHolder != null ) {
				if ( this.contains( _mcHolder ) ) {
					this.removeChild( _mcHolder );
					_mcHolder = null;
				}
			}
			
			if ( _mcHolder2 != null ) {
				if ( this.contains( _mcHolder2 ) ) {
					this.removeChild( _mcHolder2 );
					_mcHolder2 = null;
				}
			}
			
			if( cacheBmd != null && cacheBmd2 != null ){
				cacheBmd = new Array();
				cacheBmd2 = new Array();
				
				cacheBmd = null;
				cacheBmd2 = null;
			}else {
				trace( "Vector cache error: cachebmd's is null not instantiated at all please check!! " );
			}
		}
		
		/*------------------------------------------------------------------Getters----------------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------Setters----------------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------EventHandlers----------------------------------------------------------------------------*/
		
		private function onPlayMc ( e:Event ):void {	
			if( _mcHolder != null && cacheBmd!= null ){
				var mcCnt:int = _mcHolder.numChildren -1;	
				while( mcCnt >= 0 ){
					var child:* = _mcHolder.getChildAt( mcCnt );
					
					if( _mcHolder.contains( child ) ){
						_mcHolder.removeChild( child );
						currentFrame++;
						if( currentFrame > cacheBmd.length - 2 ){
							currentFrame=0;
						}
						_mcHolder.addChildAt( cacheBmd[ currentFrame ] , mcCnt );
					}
					
					mcCnt--;
				}
			}
		}
		
		
		private function onPlayMc2 ( e:Event ):void {	
			if( _mcHolder2 != null && cacheBmd2 != null ){
				var mcCnt:int = _mcHolder2.numChildren -1;	
				while( mcCnt >= 0 ){
					var child:* = _mcHolder2.getChildAt( mcCnt );
					
					if( _mcHolder2.contains( child ) ){
						_mcHolder2.removeChild( child );
						currentFrame2++;
						if( currentFrame2 > cacheBmd2.length - 2 ){
							currentFrame2=0;
						}
						_mcHolder2.addChildAt( cacheBmd2[ currentFrame2 ] , mcCnt );
					}
					
					mcCnt--;
				}
			}
		}
		
	}

}