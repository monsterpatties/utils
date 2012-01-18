package com.monsterPatties.views 
{			
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import com.monsterPatties.utils.displayManager.config.DisplayManagerConfig;
	import com.monsterPatties.utils.displayManager.DisplayManager;
	import com.monsterPatties.utils.displayManager.Window;
	/**
	 * ...
	 * @author jc
	 */
	public class LevelSelectScreen extends Window
	{
		/*----------------------------------------------------------Constant---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Properties---------------------------------------------------------------*/				
		private var _dm:DisplayManager;
		private var _bm:ButtonManager;
		private var _mc:LevelSelectionDefaultMC;
		/*----------------------------------------------------------Constructor---------------------------------------------------------------*/
		public function LevelSelectScreen ( windowName:String, winWidth:Number = 0, winHeight:Number = 0 , hideWindowName:Boolean = false ) 
		{			
			super( windowName , winWidth, winHeight );
		}		
		
		override public function initWindow():void 
		{
			super.initWindow();			
			prepareControllers();
			setDisplay(  );				
			trace( windowName + " init!!" );
		}
		
		override public function clearWindow():void 
		{			
			super.clearWindow();			
			removeDisplay();
			trace( windowName + " destroyed!!" );
		}
		
		/*----------------------------------------------------------Methods---------------------------------------------------------------*/
		private function setDisplay():void 
		{				
			_mc = new LevelSelectionDefaultMC();
			addChild( _mc );
			
			_mc.txtWindowName.text = "Level Selection";
			_mc.levelBtn1.txtLabel.text = "1";
			_mc.levelBtn2.txtLabel.text = "2";
			_mc.levelBtn3.txtLabel.text = "3";
			_mc.levelBtn4.txtLabel.text = "4";
			_mc.levelBtn5.txtLabel.text = "5";
			_mc.levelBtn6.txtLabel.text = "6";
			_mc.levelBtn7.txtLabel.text = "7";
			_mc.levelBtn8.txtLabel.text = "8";
			_mc.levelBtn9.txtLabel.text = "9";
			_mc.levelBtn10.txtLabel.text = "10";
			_mc.levelBtn11.txtLabel.text = "11";
			_mc.levelBtn12.txtLabel.text = "12";
			_mc.levelBtn13.txtLabel.text = "13";
			_mc.levelBtn14.txtLabel.text = "14";
			_mc.levelBtn15.txtLabel.text = "15";
			_mc.levelBtn16.txtLabel.text = "16";
			_mc.levelBtn17.txtLabel.text = "17";
			_mc.levelBtn18.txtLabel.text = "18";
			_mc.levelBtn19.txtLabel.text = "19";
			_mc.levelBtn20.txtLabel.text = "20";			
			
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc.menuBtn );
			_bm.addBtnListener( _mc.upgradeBtn );
			_bm.addBtnListener( _mc.levelBtn1 );
			_bm.addBtnListener( _mc.levelBtn2 );
			_bm.addBtnListener( _mc.levelBtn3 );
			_bm.addBtnListener( _mc.levelBtn4 );
			_bm.addBtnListener( _mc.levelBtn5 );
			_bm.addBtnListener( _mc.levelBtn6 );
			_bm.addBtnListener( _mc.levelBtn7 );
			_bm.addBtnListener( _mc.levelBtn8 );
			_bm.addBtnListener( _mc.levelBtn9 );
			_bm.addBtnListener( _mc.levelBtn10 );
			_bm.addBtnListener( _mc.levelBtn11 );
			_bm.addBtnListener( _mc.levelBtn12 );
			_bm.addBtnListener( _mc.levelBtn13 );
			_bm.addBtnListener( _mc.levelBtn14 );
			_bm.addBtnListener( _mc.levelBtn15 );
			_bm.addBtnListener( _mc.levelBtn16 );
			_bm.addBtnListener( _mc.levelBtn17 );
			_bm.addBtnListener( _mc.levelBtn18 );
			_bm.addBtnListener( _mc.levelBtn19 );
			_bm.addBtnListener( _mc.levelBtn20 );
			
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
		}	
		
		private function removeDisplay():void 
		{				
			if ( _mc != null ) {				
				_bm.removeBtnListener( _mc.menuBtn );
				_bm.removeBtnListener( _mc.upgradeBtn );
				_bm.removeBtnListener( _mc.levelBtn1 );
				_bm.removeBtnListener( _mc.levelBtn2 );
				_bm.removeBtnListener( _mc.levelBtn3 );
				_bm.removeBtnListener( _mc.levelBtn4 );
				_bm.removeBtnListener( _mc.levelBtn5 );
				_bm.removeBtnListener( _mc.levelBtn6 );
				_bm.removeBtnListener( _mc.levelBtn7 );
				_bm.removeBtnListener( _mc.levelBtn8 );
				_bm.removeBtnListener( _mc.levelBtn9 );
				_bm.removeBtnListener( _mc.levelBtn10 );
				_bm.removeBtnListener( _mc.levelBtn11 );
				_bm.removeBtnListener( _mc.levelBtn12 );
				_bm.removeBtnListener( _mc.levelBtn13 );
				_bm.removeBtnListener( _mc.levelBtn14 );
				_bm.removeBtnListener( _mc.levelBtn15 );
				_bm.removeBtnListener( _mc.levelBtn16 );
				_bm.removeBtnListener( _mc.levelBtn17 );
				_bm.removeBtnListener( _mc.levelBtn18 );
				_bm.removeBtnListener( _mc.levelBtn19 );
				_bm.removeBtnListener( _mc.levelBtn20 );				
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
		
		private function prepareControllers():void 
		{			
			_dm = DisplayManager.getInstance();			
		}
		
		/*----------------------------------------------------------Setters---------------------------------------------------------------*/
		
		/*----------------------------------------------------------Getters---------------------------------------------------------------*/		
		
		
		/*----------------------------------------------------------EventHandlers---------------------------------------------------------------*/				
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "menuBtn":
					_mc.menuBtn.gotoAndStop( 1 );
				break;
				
				case "upgradeBtn":
					_mc.upgradeBtn.gotoAndStop( 1 );
				break;
				
				case "levelBtn1":
					_mc.levelBtn1.gotoAndStop( 1 );
				break;
				
				case "levelBtn2":
					_mc.levelBtn2.gotoAndStop( 1 );
				break;
				
				case "levelBtn3":
					_mc.levelBtn3.gotoAndStop( 1 );
				break;
				
				case "levelBtn4":
					_mc.levelBtn4.gotoAndStop( 1 );
				break;
				
				case "levelBtn5":
					_mc.levelBtn5.gotoAndStop( 1 );
				break;
				
				case "levelBtn6":
					_mc.levelBtn6.gotoAndStop( 1 );
				break;
				
				case "levelBtn7":
					_mc.levelBtn7.gotoAndStop( 1 );
				break;
				
				case "levelBtn8":
					_mc.levelBtn8.gotoAndStop( 1 );
				break;
				
				case "levelBtn9":
					_mc.levelBtn9.gotoAndStop( 1 );
				break;
				
				case "levelBtn10":
					_mc.levelBtn10.gotoAndStop( 1 );
				break;
				
				case "levelBtn11":
					_mc.levelBtn11.gotoAndStop( 1 );
				break;
				
				case "levelBtn12":
					_mc.levelBtn12.gotoAndStop( 1 );
				break;
				
				case "levelBtn13":
					_mc.levelBtn13.gotoAndStop( 1 );
				break;
				
				case "levelBtn14":
					_mc.levelBtn14.gotoAndStop( 1 );
				break;
				
				case "levelBtn15":
					_mc.levelBtn15.gotoAndStop( 1 );
				break;
				
				case "levelBtn16":
					_mc.levelBtn16.gotoAndStop( 1 );
				break;
				
				case "levelBtn17":
					_mc.levelBtn17.gotoAndStop( 1 );
				break;
				
				case "levelBtn18":
					_mc.levelBtn18.gotoAndStop( 1 );
				break;
				
				case "levelBtn19":
					_mc.levelBtn19.gotoAndStop( 1 );
				break;
				
				case "levelBtn20":
					_mc.levelBtn20.gotoAndStop( 1 );
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
				case "menuBtn":
					_mc.menuBtn.gotoAndStop( 2 );
				break;
				
				case "upgradeBtn":
					_mc.upgradeBtn.gotoAndStop( 2 );
				break;
				
				case "levelBtn1":
					_mc.levelBtn1.gotoAndStop( 2 );
				break;
				
				case "levelBtn2":
					_mc.levelBtn2.gotoAndStop( 2 );
				break;
				
				case "levelBtn3":
					_mc.levelBtn3.gotoAndStop( 2 );
				break;
				
				case "levelBtn4":
					_mc.levelBtn4.gotoAndStop( 2 );
				break;
				
				case "levelBtn5":
					_mc.levelBtn5.gotoAndStop( 2 );
				break;
				
				case "levelBtn6":
					_mc.levelBtn6.gotoAndStop( 2 );
				break;
				
				case "levelBtn7":
					_mc.levelBtn7.gotoAndStop( 2 );
				break;
				
				case "levelBtn8":
					_mc.levelBtn8.gotoAndStop( 2 );
				break;
				
				case "levelBtn9":
					_mc.levelBtn9.gotoAndStop( 2 );
				break;
				
				case "levelBtn10":
					_mc.levelBtn10.gotoAndStop( 2 );
				break;
				
				case "levelBtn11":
					_mc.levelBtn11.gotoAndStop( 2 );
				break;
				
				case "levelBtn12":
					_mc.levelBtn12.gotoAndStop( 2 );
				break;
				
				case "levelBtn13":
					_mc.levelBtn13.gotoAndStop( 2 );
				break;
				
				case "levelBtn14":
					_mc.levelBtn14.gotoAndStop( 2 );
				break;
				
				case "levelBtn15":
					_mc.levelBtn15.gotoAndStop( 2 );
				break;
				
				case "levelBtn16":
					_mc.levelBtn16.gotoAndStop( 2 );
				break;
				
				case "levelBtn17":
					_mc.levelBtn17.gotoAndStop( 2 );
				break;
				
				case "levelBtn18":
					_mc.levelBtn18.gotoAndStop( 2 );
				break;
				
				case "levelBtn19":
					_mc.levelBtn19.gotoAndStop( 2 );
				break;
				
				case "levelBtn20":
					_mc.levelBtn20.gotoAndStop( 2 );
				break;			
				
				default:
				break;
			}
		}
		
		private function onClickBtn(e:ButtonEvent):void 
		{			
			var btnName:String = e.obj.name;
			var level:int = 0;
			
			switch ( btnName ) 
			{
				case "menuBtn":
					_mc.menuBtn.gotoAndStop( 3 );
					_dm.loadScreen( DisplayManagerConfig.TITLE_SCREEN );
				break;
				
				case "upgradeBtn":
					_mc.upgradeBtn.gotoAndStop( 3 );
					_dm.loadScreen( DisplayManagerConfig.UPGRADE_SCREEN );
				break;
				
				case "levelBtn1":
					_mc.levelBtn1.gotoAndStop( 3 );
					level = 1;
				break;
				
				case "levelBtn2":
					_mc.levelBtn2.gotoAndStop( 3 );
					level = 2;
				break;
				
				case "levelBtn3":
					_mc.levelBtn3.gotoAndStop( 3 );
					level = 3;
				break;
				
				case "levelBtn4":
					_mc.levelBtn4.gotoAndStop( 3 );
					level = 4;
				break;
				
				case "levelBtn5":
					_mc.levelBtn5.gotoAndStop( 3 );
					level = 5;
				break;
				
				case "levelBtn6":
					_mc.levelBtn6.gotoAndStop( 3 );
					level = 6;
				break;
				
				case "levelBtn7":
					_mc.levelBtn7.gotoAndStop( 3 );
					level = 7;
				break;
				
				case "levelBtn8":
					_mc.levelBtn8.gotoAndStop( 3 );
					level = 8;
				break;
				
				case "levelBtn9":
					_mc.levelBtn9.gotoAndStop( 3 );
					level = 9;
				break;
				
				case "levelBtn10":
					_mc.levelBtn10.gotoAndStop( 3 );
					level = 10;
				break;
				
				case "levelBtn11":
					_mc.levelBtn11.gotoAndStop( 3 );
					level = 11;
				break;
				
				case "levelBtn12":
					_mc.levelBtn12.gotoAndStop( 3 );
					level = 12;
				break;
				
				case "levelBtn13":
					_mc.levelBtn13.gotoAndStop( 3 );
					level = 13;
				break;
				
				case "levelBtn14":
					_mc.levelBtn14.gotoAndStop( 3 );
					level = 14;
				break;
				
				case "levelBtn15":
					_mc.levelBtn15.gotoAndStop( 3 );
					level = 15;
				break;
				
				case "levelBtn16":
					_mc.levelBtn16.gotoAndStop( 3 );
					level = 16;
				break;
				
				case "levelBtn17":
					_mc.levelBtn17.gotoAndStop( 3 );
					level = 17;
				break;
				
				case "levelBtn18":
					_mc.levelBtn18.gotoAndStop( 3 );
					level = 18;
				break;
				
				case "levelBtn19":
					_mc.levelBtn19.gotoAndStop( 3 );
					level = 19;
				break;
				
				case "levelBtn20":
					_mc.levelBtn20.gotoAndStop( 3 );
					level = 20;
				break;			
				
				default:
				break;
			}
			
			if ( level > 0 ) {
				trace( "[load level ] ", level );
				_dm.loadScreen( DisplayManagerConfig.GAME_SCREEN );
			}
		}
	}

}