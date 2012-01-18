package com.monsterPatties.utils.buttonManager 
{		
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class ButtonManager extends EventDispatcher
	{
		/*--------------------------------------------------------------Constant-------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties-------------------------------------------------*/		
		private var _buttons:Array;
		private var _buttonEvent:ButtonEvent;
		/*--------------------------------------------------------------Constructor-------------------------------------------------*/
		
		public function ButtonManager(  ) 
		{
			init();
		}	
		
		/*--------------------------------------------------------------Methods-------------------------------------------------*/
		
		private function init():void 
		{
			_buttons = new Array();
		}
		
		
		public function addBtnListener( btn:Object ):void {
			btn.buttonMode = true;
			_buttons.push( btn );
			btn.addEventListener( MouseEvent.ROLL_OVER, onRolloverBtn );
			btn.addEventListener( MouseEvent.ROLL_OUT, onRolloutBtn );
			btn.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDownBtn );
			btn.addEventListener( MouseEvent.CLICK, onClickBtn );
		}		
		
		
		public function removeBtnListener( btn:Object ):void {
			btn.buttonMode = false;
			btn.removeEventListener( MouseEvent.ROLL_OVER, onRolloverBtn );
			btn.removeEventListener( MouseEvent.ROLL_OUT, onRolloutBtn );
			btn.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDownBtn );
			btn.removeEventListener( MouseEvent.CLICK, onClickBtn );
		}
		
		public function clearButtons():void 
		{
			_buttons = new Array();
		}
		
		/*--------------------------------------------------------------Setters-------------------------------------------------*/
		/*--------------------------------------------------------------Getters-------------------------------------------------*/
		/*--------------------------------------------------------------EventHandlers-------------------------------------------------*/
		private function onRolloutBtn(e:MouseEvent):void 
		{
			var len:int = _buttons.length;
			var btnName:String = e.currentTarget.name;			
			
			for each ( var obj:* in _buttons ) 
			{				
				if ( btnName == obj.name ) {					
					_buttonEvent = new ButtonEvent( ButtonEvent.ROLL_OUT_BUTTON );					
					_buttonEvent.obj.name = obj.name;
					dispatchEvent( _buttonEvent );
					break;
				}
			}		
		}
		
		private function onRolloverBtn(e:MouseEvent):void 
		{			
			var btnName:String = e.currentTarget.name;			
			
			for each ( var obj:* in _buttons ) 
			{				
				if ( btnName == obj.name ){					
					_buttonEvent = new ButtonEvent( ButtonEvent.ROLL_OVER_BUTTON );					
					_buttonEvent.obj.name = obj.name;
					dispatchEvent( _buttonEvent );
					break;
				}
			}
		}
		
		private function onClickBtn(e:MouseEvent):void 
		{			
			var btnName:String = e.currentTarget.name;			
			
			for each ( var obj:* in _buttons ) 
			{				
				if ( btnName == obj.name ) {
					_buttonEvent = new ButtonEvent( ButtonEvent.CLICK_BUTTON);
					_buttonEvent.obj.name = obj.name;
					dispatchEvent( _buttonEvent );
					break;
				}
			}
		}
		
		private function onMouseDownBtn(e:MouseEvent):void 
		{			
			var btnName:String = e.currentTarget.name;			
			
			for each ( var obj:* in _buttons ) 
			{				
				if ( btnName == obj.name ){					
					break;
				}
			}
		}
	}

}