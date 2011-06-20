package com.monsterPatties.test.sampleWindows 
{	
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DMButton;
	import com.monsterPatties.utils.displayManager.DMTextField;
	import com.monsterPatties.utils.displayManager.event.DisplayManagerEvent;
	import com.monsterPatties.utils.displayManager.PopUpWindow;
	import com.monsterPatties.utils.fontManager.FontManager;
	import flash.events.Event;
	/**
	 * ...
	 * @author jc
	 */
	public class Pop2 extends PopUpWindow
	{
		/*-------------------------------------------------------------Constant-------------------------------------------*/
		/*-------------------------------------------------------------Properties-------------------------------------------*/
		
		private var _popWinSkin:PopUpWindowMessageSkin;
		private var _DMEvent:DisplayManagerEvent;
		private var _closeBtn:DMButton;
		private var _dmTxt:DMTextField;
		
		/*-------------------------------------------------------------Constructor-------------------------------------------*/
		public function Pop2( maxAreaWidth:Number, maxAreaHeight:Number  ) 
		{
			_popWinSkin = new PopUpWindowMessageSkin();
			super( DisplayManagerConfig.POP_UP_WINDOW_MESSAGE, _popWinSkin, maxAreaWidth, maxAreaHeight, true  );
			trace( "pop2......" );
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			setDisplay();			
		}
		
		/*-------------------------------------------------------------Methods---------------------------------------------------*/
		private function setDisplay():void 
		{
			_closeBtn = new DMButton( "closeBtn", "Close", 1, new CloseBtn()  , 127, 192 );
			_closeBtn.addEventListener( DisplayManagerEvent.BUTTON_CLICK , onClickCloseBtn );
			addChild( _closeBtn );
			
			_dmTxt = new DMTextField( "test text here!!........." );
			addChild( _dmTxt );
			
			var fm:FontManager = FontManager.getInstance();
			_dmTxt.setTxtFormat( fm.getTxtFormat( 0 ) );
		}
		
		private function removeDisplay():void 
		{
			if ( _closeBtn != null ) {
				if ( this.contains( _closeBtn ) ) {
					this.removeChild( _closeBtn );
					_closeBtn = null;
				}
			}
		}
		
		override public function destroy():void 
		{
			super.destroy();
			removeDisplay();
			trace(  "pop2 destroy" );
		}
		/*-------------------------------------------------------------Setters--------------------------------------------------*/
		/*-------------------------------------------------------------Getters--------------------------------------------------*/
		
		/*-------------------------------------------------------------EventHandlers-------------------------------------------*/
		private function onClickCloseBtn( e:DisplayManagerEvent ):void 
		{
			trace( "on close pop up window......" );
			_DMEvent = new DisplayManagerEvent( DisplayManagerEvent.REMOVE_POP_UP_WINDOW );
			_DMEvent.windowName = windowName;
			dispatchEvent( _DMEvent );
		}	
		
	}

}