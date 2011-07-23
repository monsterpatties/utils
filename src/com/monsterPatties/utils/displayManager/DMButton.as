package com.monsterPatties.utils.displayManager 
{
	import com.monsterPatties.utils.displayManager.event.DisplayManagerEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author jc
	 */
	public class DMButton extends Sprite
	{
		
		/*---------------------------------------------------------Constant-------------------------------------------------*/
		
		/*---------------------------------------------------------Properties-------------------------------------------------*/
		private var _btnName:String;
		private var _btnLabel:String;
		private var _btnType:int;
		private var _btnMc:MovieClip;
		private	var _DMEvent:DisplayManagerEvent;		
		/*---------------------------------------------------------Constructor-------------------------------------------------*/
		
		public function DMButton( name:String, label:String, type:int, buttonMC:MovieClip , x:Number = 0, y:Number = 0 ) 
		{
			_btnName = name;
			_btnLabel = label;
			_btnType = type;
			_btnMc  = buttonMC;			
			this.x = x;
			this.y = y;
			
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			setDisplay();
		}
		
		/*---------------------------------------------------------Methods-------------------------------------------------*/
		private function setDisplay():void 
		{	
			addChild( _btnMc );			
			_btnMc.addEventListener( MouseEvent.CLICK, onClickBtn );
			_btnMc.addEventListener( MouseEvent.ROLL_OVER, onRollOverBtn );
			_btnMc.addEventListener( MouseEvent.ROLL_OUT, onRollOutBtn );			
		}
		
		
		
		private function removeDisplay():void 
		{
			if ( _btnMc != null ) {				
				_btnMc.removeEventListener( MouseEvent.CLICK, onClickBtn );
				_btnMc.removeEventListener( MouseEvent.ROLL_OVER, onRollOverBtn );
				_btnMc.removeEventListener( MouseEvent.ROLL_OUT, onRollOutBtn );
				
				if ( this.contains( _btnMc ) ) {
					this.removeChild( _btnMc );
					_btnMc = null;
				}
			}
		}
		/*---------------------------------------------------------Setters-------------------------------------------------*/
		
		/*---------------------------------------------------------Getters-------------------------------------------------*/
		
		/*---------------------------------------------------------EventHandlers-------------------------------------------------*/
		
		private function onRollOverBtn(e:MouseEvent):void 
		{
			_btnMc.gotoAndStop( 2 );			
		}
		
		private function onRollOutBtn(e:MouseEvent):void 
		{
			_btnMc.gotoAndStop( 1 );			
		}
		
		private function onClickBtn(e:MouseEvent):void 
		{
			_DMEvent = new DisplayManagerEvent( DisplayManagerEvent.BUTTON_CLICK );
			dispatchEvent( _DMEvent );			
		}
	}

}