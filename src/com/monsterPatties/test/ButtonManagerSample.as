package com.monsterPatties.test 
{
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author jc
	 */
	public class ButtonManagerSample extends Sprite
	{
		/*-----------------------------------------------------------------------Constant----------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------Properties---------------------------------------------------------*/
		private var _mc:SampleWindowMC;
		private var _bm:ButtonManager;
		/*-----------------------------------------------------------------------Constructor---------------------------------------------------------*/
		
		
		public function ButtonManagerSample() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}	
		
		/*-----------------------------------------------------------------------Methods----------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new SampleWindowMC();
			addChild( _mc  );
			
			_bm = new ButtonManager();			
			_bm.addBtnListener( _mc.okBtn );            
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {				
				_bm.removeBtnListener( _mc.okBtn );
				_bm.removeEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
				_bm.removeEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
				_bm.clearButtons();
				_bm = null;				
				if ( this.contains( _mc ) ) {
					this.removeChild( _mc );
					_mc = null;
				}
			}
		}
		/*-----------------------------------------------------------------------Setters----------------------------------------------------------*/
		/*-----------------------------------------------------------------------Getters----------------------------------------------------------*/
		/*-----------------------------------------------------------------------EventHandlers----------------------------------------------------*/
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
		
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{				
				case "okBtn":
					_mc.okBtn.gotoAndStop( 1 );
				break;                
				
				default:
				break;
			}
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{			
				case "okBtn":
					_mc.okBtn.gotoAndStop( 2 );
				break;                
				
				default:
				break;
			}
		}
		
		private function onClickBtn(e:ButtonEvent):void 
		{			
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{                  
				case "okBtn":
					_mc.okBtn.gotoAndStop( 3 );
				break;                
				
				default:
				break;
			}
		}
		
	}

}