package com.monsterPatties.components 
{
    import com.greensock.TweenLite;
	import com.monsterPatties.controllers.GameDataController;
	import com.monsterPatties.data.GameData;
    import com.monsterPatties.events.GameEvent;
    import com.monsterPatties.utils.eventSatellite.EventSatellite;
    import flash.display.Sprite;
    import flash.events.Event;
	/**
     * ...
     * @author jc
     */
    public class GoalPrompt extends Sprite
    {
        /*-------------------------------------------------------------------------------------------Constant----------------------------------------------------------------------------*/
        
        /*-------------------------------------------------------------------------------------------Properties--------------------------------------------------------------------------*/
        private var _mc:GoalPromptMC;
        private var _es:EventSatellite;
		private var _gameEvent:GameEvent;
        private var _xpos:Number = 0;
        private var _ypos:Number = 0;
		private var _gdc:GameDataController;
        /*-------------------------------------------------------------------------------------------Constructor-------------------------------------------------------------------------*/
        
        
        public function GoalPrompt( xpos:Number, ypos:Number ) 
        {
            _xpos = xpos;
            _ypos = ypos;
            addEventListener( Event.ADDED_TO_STAGE, init );
        }
        
        private function init(e:Event):void 
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            addEventListener( Event.REMOVED_FROM_STAGE, destroy );
            initControllers();
            setDisplay();
        }
        
        private function destroy(e:Event):void 
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
            removeDisplay();
        }
        
        /*-------------------------------------------------------------------------------------------Methods----------------------------------------------------------------------------*/
        private function setDisplay():void 
        {
          _mc = new GoalPromptMC();
          addChild( _mc );
          _mc.x = _xpos;
          _mc.y = _ypos;		
		  var level:int = _gdc.getLevel() + 1;
		  //var goal:int = GameData.LEVEL_TARGET[ level -1 ];
		  var goal:int = GameData.TARGET_START * (_gdc.getLevel() + 1);		   
		  _mc.txtGoal.text = "Collect " + goal + " Floaties ";
		  _mc.txtLevel.text = "Level " + level;
		  
          _mc.addFrameScript( _mc.totalFrames - 1, onEndAnimation );		  
        }
        
        private function removeDisplay():void 
        {
            if ( _mc != null ) {
				_gameEvent = new GameEvent( GameEvent.START_COUNT_DOWN );
				_es.dispatchESEvent( _gameEvent );
				
                _mc.addFrameScript( _mc.totalFrames - 1, null );		  
                TweenLite.killTweensOf( _mc );
                if ( this.contains( _mc ) ) {
                    this.removeChild( _mc );
                    _mc = null;
                    trace( "[CountDown] garbage collected...." );
                }
            }
        }
        
        private function initControllers():void 
		{           
			_es = EventSatellite.getInstance();		
			_gdc = GameDataController.getInstance();
		}
        
        private function onEndAnimation():void 
        {
            _mc.stop();
            TweenLite.to( _mc, 1.5, { alpha:0, onComplete:removeDisplay } );            
        }		
        /*-------------------------------------------------------------------------------------------Setters----------------------------------------------------------------------------*/
        
        /*-------------------------------------------------------------------------------------------Getters----------------------------------------------------------------------------*/
        
        /*-------------------------------------------------------------------------------------------EventHandlers---------------------------------------------------------------------*/
        
    }

}