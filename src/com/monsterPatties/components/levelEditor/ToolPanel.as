package com.monsterPatties.components.levelEditor 
{
	import com.monsterPatties.utils.buttonManager.ButtonManager;
	import com.monsterPatties.utils.buttonManager.events.ButtonEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class ToolPanel extends Sprite
	{
		/*-------------------------------------------------------------------------Constant----------------------------------------------------------------*/
		/*-------------------------------------------------------------------------Properties--------------------------------------------------------------*/
		private var _mc:ToolPanelMC;
		private var _bm:ButtonManager;
		private var _xPos:Number;
		private var _yPos:Number;
		private var _levelEditorEvent:LevelEditorEvent;
		/*-------------------------------------------------------------------------Constructor-------------------------------------------------------------*/
		
		public function ToolPanel( xpos:Number, ypos:Number ) 
		{
			_xPos  = xpos;
			_yPos = ypos;
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
		
		/*-------------------------------------------------------------------------Methods----------------------------------------------------------------*/
		private function setDisplay():void 
		{
			_mc = new ToolPanelMC();
			addChild( _mc );
			_mc.x = _xPos;
			_mc.y = _yPos;
			
			_bm = new ButtonManager();
			_bm.addBtnListener( _mc.zoomInBtn );
			_bm.addBtnListener( _mc.zoomOutBtn );
			_bm.addBtnListener( _mc.genBtn );
			_bm.addBtnListener( _mc.createMapBtn );
			_bm.addBtnListener( _mc.scroller.origin );
			_bm.addBtnListener( _mc.loadMapBtn );
			_bm.addBtnListener( _mc.addRow );
			_bm.addBtnListener( _mc.addCol );
			_bm.addBtnListener( _mc.subRow );
			_bm.addBtnListener( _mc.subCol );
			_bm.addEventListener( ButtonEvent.CLICK_BUTTON, onClickBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OVER_BUTTON, onRollOverBtn );
			_bm.addEventListener( ButtonEvent.ROLL_OUT_BUTTON, onRollOutBtn );
			_bm.addEventListener( ButtonEvent.MOUSE_DOWN_BUTTON, onMouseDownBtn );
			_bm.addEventListener( ButtonEvent.MOUSE_UP_BUTTON, onMouseUpBtn );
			_bm.addEventListener( ButtonEvent.MOUSE_MOVE_BUTTON, onMouseMoveBtn );	
			_mc.handle.addEventListener( MouseEvent.MOUSE_DOWN, OnStartDrag );
			_mc.handle.addEventListener( MouseEvent.MOUSE_UP, OnStopDrag );
		}						
		
		private function OnStopDrag(e:MouseEvent):void 
		{
			_mc.stopDrag();
		}
		
		private function OnStartDrag(e:MouseEvent):void 
		{
			_mc.startDrag();
		}
		
		private function removeDisplay():void 
		{
			if ( _mc != null ) {
				_bm.removeBtnListener( _mc.zoomInBtn );
				_bm.removeBtnListener( _mc.zoomOutBtn );
				_bm.removeBtnListener( _mc.genBtn );
				_bm.removeBtnListener( _mc.createMapBtn );
				_bm.removeBtnListener( _mc.scroller.origin );
				_bm.removeBtnListener( _mc.loadMapBtn );
				_bm.removeBtnListener( _mc.addRow );
				_bm.removeBtnListener( _mc.addCol );
				_bm.removeBtnListener( _mc.subRow );
				_bm.removeBtnListener( _mc.subCol );
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
		
		private function followMouse():void 
		{
			//stage.addEventListener( Event.ENTER_FRAME, onUpdate );
			//startDrag( true, new Rectangle( 0,0,1,200  ) );
			_mc.scroller.origin.startDrag( true, new Rectangle( 0,0,0.5,_mc.scroller.line.height ) );
		}		
		
		private function unfollowMouse():void 
		{			
			_mc.scroller.origin.stopDrag(  );			
		}
		
		private function updateScrollPosition():void 
		{
			var dir:int;			
			if ( _mc.scroller.origin.y > ( mouseY - 10 ) ) {
				dir = 1;
			}else {
				dir = 0;
			}	
			
			//_mc.scroller.origin.y = mouseY - 10;									
			_levelEditorEvent = new LevelEditorEvent( LevelEditorEvent.SCROLL_MAP );
			_levelEditorEvent.obj.originY = _mc.scroller.origin.y;
			_levelEditorEvent.obj.height = _mc.scroller.line.height;
			_levelEditorEvent.obj.dir = dir;
			dispatchEvent( _levelEditorEvent );	
		}
		
		/*-------------------------------------------------------------------------Setters----------------------------------------------------------------*/
		/*-------------------------------------------------------------------------Getters----------------------------------------------------------------*/
		/*-------------------------------------------------------------------------EventHandlers----------------------------------------------------------*/
		private function onRollOutBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "zoomInBtn":
					_mc.zoomInBtn.gotoAndStop( 1 );					
				break;
				
				case "zoomOutBtn":
					_mc.zoomOutBtn.gotoAndStop( 1 );
				break;
				
				case "genBtn":
					_mc.genBtn.gotoAndStop( 1 );
				break;
				
				case "createMapBtn":
					_mc.createMapBtn.gotoAndStop( 1 );
				break;				
				
				case "loadMapBtn":
					_mc.loadMapBtn.gotoAndStop( 1 );
				break;				
				
				case "addRow":
					_mc.addRow.gotoAndStop( 1 );
				break;
				
				case "addCol":
					_mc.addCol.gotoAndStop( 1 );
				break;
				
				case "subRow":
					_mc.subRow.gotoAndStop( 1 );
				break;
				
				case "subCol":
					_mc.subCol.gotoAndStop( 1 );
				break;
				
				case "origin":
					unfollowMouse();
				break;
				
				default:
				break;				
			}
			
			_levelEditorEvent = new LevelEditorEvent( LevelEditorEvent.MAP_STOP_MOVE );
			dispatchEvent( _levelEditorEvent );
		}
		
		private function onRollOverBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{				
				case "zoomInBtn":
					_mc.zoomInBtn.gotoAndStop( 2 );
				break;
				
				case "zoomOutBtn":
					_mc.zoomOutBtn.gotoAndStop( 2 );
				break;
				
				case "genBtn":
					_mc.genBtn.gotoAndStop( 2 );
				break;
				
				case "createMapBtn":
					_mc.createMapBtn.gotoAndStop( 2 );
				break;
				
				case "loadMapBtn":
					_mc.loadMapBtn.gotoAndStop( 2 );
				break;
				
				case "addRow":
					_mc.addRow.gotoAndStop( 2 );
				break;
				
				case "addCol":
					_mc.addCol.gotoAndStop( 2 );
				break;
				
				case "subRow":
					_mc.subRow.gotoAndStop( 2 );
				break;
				
				case "subCol":
					_mc.subCol.gotoAndStop( 2 );
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
				case "zoomInBtn":
					_mc.zoomInBtn.gotoAndStop( 3 );
					_levelEditorEvent = new LevelEditorEvent( LevelEditorEvent.MAP_SCALE_UP );
					dispatchEvent( _levelEditorEvent );
				break;
				
				case "zoomOutBtn":
					_mc.zoomOutBtn.gotoAndStop( 3 );
					_levelEditorEvent = new LevelEditorEvent( LevelEditorEvent.MAP_SCALE_DOWN );
					dispatchEvent( _levelEditorEvent );					
				break;				
				
				case "genBtn":
					_levelEditorEvent = new LevelEditorEvent( LevelEditorEvent.GENERATE_MAP );
					dispatchEvent( _levelEditorEvent );
					_mc.genBtn.gotoAndStop( 3 );
				break;
				
				case "createMapBtn":
					_mc.createMapBtn.gotoAndStop( 3 );
					_levelEditorEvent = new LevelEditorEvent( LevelEditorEvent.CREATE_NEW_MAP );
					_levelEditorEvent.obj.col = int( _mc.txtCol.text );
					_levelEditorEvent.obj.row = int( _mc.txtRow.text );
					dispatchEvent( _levelEditorEvent );
				break;
				
				case "loadMapBtn":
					_mc.loadMapBtn.gotoAndStop( 3 );
					_levelEditorEvent = new LevelEditorEvent( LevelEditorEvent.LOAD_MAP );
					_levelEditorEvent.obj.map = _mc.txtMap.text;
					dispatchEvent( _levelEditorEvent );
				break;
				
				case "addRow":
					_levelEditorEvent = new LevelEditorEvent( LevelEditorEvent.ADD_ROW );					
					dispatchEvent( _levelEditorEvent );
				break;
				
				case "addCol":
					_levelEditorEvent = new LevelEditorEvent( LevelEditorEvent.ADD_COL );
					dispatchEvent( _levelEditorEvent );
				break;
				
				case "subRow":
					_levelEditorEvent = new LevelEditorEvent( LevelEditorEvent.SUB_ROW );
					dispatchEvent( _levelEditorEvent );
				break;
				
				case "subCol":
					_levelEditorEvent = new LevelEditorEvent( LevelEditorEvent.SUB_COL );
					dispatchEvent( _levelEditorEvent );
				break;				
				
				default:
				break;	
			}
		}
		
		private function onMouseDownBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "origin":
					trace( "origin down" );
					followMouse();					
				break;
				
				default:
				break;	
			}
		}
		
		private function onMouseMoveBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "origin":
					updateScrollPosition();					
				break;
				
				default:
				break;	
			}
		}	
		
		private function onMouseUpBtn(e:ButtonEvent):void 
		{
			var btnName:String = e.obj.name;
			
			switch ( btnName ) 
			{
				case "origin":					
					unfollowMouse();
				break;
				
				default:
				break;	
			}
		}
	}

}