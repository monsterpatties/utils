package com.monsterPatties.utils.sponsorLogo 
{
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.gotoUrl.UrlNavigator;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class SponsorLogo extends Sprite
	{
		
		/*-------------------------------------------------------------------------------Constant------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------------Properties------------------------------------------------------------*/
		private var _mc:MovieClip;
		private var _bm:ButtonManager;
		/*-------------------------------------------------------------------------------Constrcutor------------------------------------------------------------*/
		
		public function SponsorLogo( logoMC:MovieClip ) 
		{
			_mc = logoMC;
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
		
		/*-------------------------------------------------------------------------------Methods------------------------------------------------------------*/
		private function setDisplay(  ):void 
		{			
			addChild( _mc );
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickButton );
		}
		
		private function onClickButton(e:ButtonEvent):void 
		{
			//var btnName:String = e.obj.name;			
			UrlNavigator.gotoUrl( "http://www.youyouwin.com/" );
			
			//switch ( btnName ) 
			//{				
				//case "logoBtn":					
					//UrlNavigator.gotoUrl( "http://www.youyouwin.com/" );
				//break;
				//
				//default:
					//
				//break;
			//}
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
		/*-------------------------------------------------------------------------------Setters------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------------Getters------------------------------------------------------------*/
		
		/*-------------------------------------------------------------------------------EventHandlers------------------------------------------------------*/
		
	}

}