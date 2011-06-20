package com.monsterPatties.utils.memoryProfiler
{	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author JC
	 */
	public class MemoryProfiler extends Sprite
	{
		
		/*---------------------------------------------------------Constant----------------------------------------------------------*/
		
		/*---------------------------------------------------------Properties----------------------------------------------------------*/
		private var _profilerHolder:Sprite;
		private var _txtProfiler:TextField;
		private var _txtFormat:TextFormat;
		
		/*---------------------------------------------------------Constructor----------------------------------------------------------*/
		
		public function MemoryProfiler(){
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event ):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );			
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			addProfiler();
			
			this.mouseEnabled = false;
			this.mouseChildren = false;	

		}
		
		private function destroy ( e:Event ):void 
		{
			removeProfiler();
			removeEventListener( Event.REMOVED_FROM_STAGE, destroy );
			trace( "memory Profiler Garbage Colllected" );
		}
		
		/*---------------------------------------------------------Methods----------------------------------------------------------*/
		private function addProfiler():void 
		{
			_profilerHolder = new Sprite();
			addChild( _profilerHolder );
			
			_txtFormat = new TextFormat();
			_txtFormat.size = 14;
			_txtFormat.color = 0xFF0000;			
			
			_txtProfiler = new TextField();			
			_txtProfiler.text = "waiting";
			_txtProfiler.autoSize = "left";
			_txtProfiler.background = true;
			_txtProfiler.backgroundColor = 0xFFFFFF;
			_txtProfiler.border = true;
			_txtProfiler.borderColor = 0x000000;
			_txtProfiler.setTextFormat( _txtFormat );
			_txtProfiler.width = 200;
			_txtProfiler.height = 50;
			_txtProfiler.selectable = false;			
			
			_profilerHolder.y = 25;
			_profilerHolder.addChild( _txtProfiler );			
			addEventListener( Event.ENTER_FRAME, onUpdateProfiler );			
		}				
		
		private function removeProfiler():void 
		{
			removeEventListener( Event.ENTER_FRAME, onUpdateProfiler );
			
			if ( _txtProfiler != null ) {
				if ( _profilerHolder !=  null ) {
					if ( _profilerHolder.contains( _txtProfiler ) ) {
						_profilerHolder.removeChild( _txtProfiler );
						_txtProfiler = null;
					}
				}				
			}
			
			_txtFormat = null;
			
			if ( _profilerHolder != null ) {
				if ( this.contains( _profilerHolder ) ) {
					this.removeChild( _profilerHolder );
					_profilerHolder = null;
				}
			}
		}	
		
		
		public function checkMe():void 
		{
			var rect:Rectangle = _txtProfiler.getBounds( this );
			if ( rect.contains( mouseX, mouseY ) ) {
				_txtProfiler.visible = false;
			}else {
				_txtProfiler.visible = true;
			}			
		}
		
		/*---------------------------------------------------------Getters----------------------------------------------------------*/
		
		/*---------------------------------------------------------Setters----------------------------------------------------------*/
		
		/*---------------------------------------------------------EventHanders-----------------------------------------------------*/
		private function onUpdateProfiler( e:Event ):void
		{
			var memoryUsed:int = Math.round( System.totalMemory / ( 1024 * 1024  ) );
			
			_txtProfiler.text = String( memoryUsed )+ "mb";
			_txtProfiler.setTextFormat( _txtFormat );
			_txtProfiler.width = 200;
			_txtProfiler.height = 50;
			_txtProfiler.selectable = false;
			
			checkMe();
		}	
	}

}