package com.monsterPatties.utils.displayManager 
{		
	import com.monsterPatties.utils.displayManager.Window;
	import com.monsterPatties.utils.interfaces.IDestroyable;
	import com.monsterPatties.utils.interfaces.IDraggable;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author jc
	 */
	public class PopUpWindow extends Window implements IDestroyable, IDraggable
	{
		/*----------------------------------------------------------Constant----------------------------------------------------*/
		
		/*----------------------------------------------------------Properties----------------------------------------------------*/
		private var _popUpWindowSkin:MovieClip ;		
		private var _draggable:Boolean;
		private var _maxAreaWidth:Number;
		private var _maxAreaHeight:Number;
		/*----------------------------------------------------------Constrcutor----------------------------------------------------*/
		
		
		public function PopUpWindow( windowName:String, popUpWindowSkin:MovieClip,maxAreaWidth:Number, maxAreaHeight:Number, draggable:Boolean = true ) 
		{
			_maxAreaWidth = maxAreaWidth;
			_maxAreaHeight = maxAreaHeight;
			_draggable = draggable;
			_popUpWindowSkin = popUpWindowSkin;
			addEventListener( Event.ADDED_TO_STAGE, init );
			super( windowName, 0, 0 );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			setDisplay();
		}
		
		/*----------------------------------------------------------Methods----------------------------------------------------*/
		private function setDisplay():void 
		{		
			_popUpWindowSkin.addEventListener( MouseEvent.MOUSE_DOWN, onStartDrag );
			_popUpWindowSkin.addEventListener( MouseEvent.MOUSE_UP, onStopDrag );
			
			addWindowBg( _popUpWindowSkin );			
			
			this.x = ( _maxAreaWidth / 2 ) - ( _popUpWindowSkin.width / 2 );
			this.y = ( _maxAreaHeight / 2 ) - ( _popUpWindowSkin.height / 2 );
		}							
		private function removeDisplay():void 
		{
			if ( _popUpWindowSkin != null ){				
				_popUpWindowSkin.removeEventListener( MouseEvent.MOUSE_DOWN, onStartDrag );
				_popUpWindowSkin.removeEventListener( MouseEvent.MOUSE_UP, onStopDrag );
				
				if ( this.contains( _popUpWindowSkin ) ) {
					this.removeChild( _popUpWindowSkin );
					_popUpWindowSkin = null;
				}
			}
		}
		
		public function destroy():void 
		{
			removeDisplay();
		}
		
		public function startWindowDrag():void 
		{
			this.startDrag();
			startChecker();			
		}
		
		public function stopWindowDrag():void 
		{
			stopChecker();
			this.stopDrag();
		}
		
		private function startChecker():void 
		{
			stage.addEventListener( Event.ENTER_FRAME, onCheckCollision );			
		}
		
		private function stopChecker():void 
		{
			stage.removeEventListener( Event.ENTER_FRAME, onCheckCollision );
		}
		
		private function onCheckCollision(e:Event):void 
		{
			if ( this.x < 0 ){
				this.x = 0;
				stopWindowDrag();
			}else if ( ( this.x + this.width ) > _maxAreaWidth ){
				this.x = _maxAreaWidth - this.width;
				stopWindowDrag();
			}
			
			if ( this.y < 0 ) {
				this.y = 0;
				stopWindowDrag();
			}else if ( ( this.y + this.height ) > _maxAreaHeight ) {
				this.y = _maxAreaHeight - this.height;
				stopWindowDrag();
			}
		}
		
		/*----------------------------------------------------------Setters----------------------------------------------------*/
		public function set dragable(value:Boolean):void 
		{
			_draggable = value;
		}
		/*----------------------------------------------------------Getters----------------------------------------------------*/
		public function get dragable():Boolean 
		{
			return _draggable;
		}
		/*----------------------------------------------------------EventHandlers----------------------------------------------------*/
		
		private function onStopDrag(e:MouseEvent):void 
		{
			if( _draggable ){				
				stopWindowDrag();
			}
		}
		
		private function onStartDrag(e:MouseEvent):void 
		{
			if( _draggable ){	
				startWindowDrag();
			}
		}	
	}

}