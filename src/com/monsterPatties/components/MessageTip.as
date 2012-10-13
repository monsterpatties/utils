package com.monsterPatties.components 
{
	import com.greensock.easing.Elastic;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author jc
	 */
	public class MessageTip extends Sprite	
	{
		/*-----------------------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------Properties-------------------------------------------------------------*/
		private var _mc:MessageTipMC;
		private var _msg:String;
		private var _xpos:Number;
		private var _ypos:Number;
		/*-----------------------------------------------------------------------Constructor------------------------------------------------------------*/
		
		
		public function MessageTip(xpos:Number, ypos:Number, msg:String ) 
		{
			_xpos = xpos;
			_ypos = ypos;
			_msg = msg;
			addEventListener( Event.ADDED_TO_STAGE, init );
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
		
		/*-----------------------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new MessageTipMC();
			addChild( _mc );
			_mc.x = -200;
			_mc.y = _ypos;
			
			if( _msg != null && _mc != null ){
				_mc.txtMessage.text = _msg;
				TweenLite.to(_mc, 1, { x:_xpos, y:_ypos, ease:Elastic.easeOut, onComplete:OnDoneAnimation } );
			}
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				TweenLite.killTweensOf( _mc );
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		
		
		private function OnDoneAnimation():void 
		{
			TweenLite.to(_mc, 1, {alpha:0, onComplete:OnDoneAlphaAnimation });
		}
		
		private function OnDoneAlphaAnimation():void 
		{
			removeDisplay();
		}
		/*-----------------------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------Getters---------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------Eventhandlers---------------------------------------------------------*/
		
	}

}