package com.monsterPatties.components 
{
	import com.greensock.TweenLite;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class MapScroller
	{
		/*-----------------------------------------------------Constant-------------------------------------------------------*/	
		
		
		/*-----------------------------------------------------Properties-------------------------------------------------------*/
		private var _scroller:Rectangle;		
		private var _viewableWidth:Number;
		private var _viewableHeight:Number;
		private var _maxHeight:Number;
		private var _maxWidth:Number;
		private var _toBeScroll:*;
		
		private var _scrollerX:int;
		private var _scrollerY:int;	
		/*-----------------------------------------------------Constructor-------------------------------------------------------*/
		
		public function MapScroller(  toBeScroll:* , viewableWidth:Number, viewableHeight:Number , maxWidth:Number, maxHeight:Number  ) 
		{			
			_viewableWidth = viewableWidth;
			_viewableHeight = viewableHeight;
			_toBeScroll = toBeScroll;
			_maxWidth = maxWidth;
			_maxHeight = maxHeight;			
			
			_scroller = new Rectangle( 0 , 0 , viewableWidth , viewableHeight );
			_toBeScroll.scrollRect  = _scroller;
		}
		
		
		/*-----------------------------------------------------methods-------------------------------------------------------*/
		
		public function scrollMap( cameraTarget:* ):void 
		{			
			var min:Function = Math.min;
			var max:Function = Math.max;
			
			
            /*
			if (cameraTarget != null ){				
				var maxX:Number = ( _maxWidth - _viewableWidth );
				var maxY:Number = ( _maxHeight - _viewableHeight );
				
				var xPos:Number = cameraTarget.x - ( _viewableWidth * 0.5 );
				var yPos:Number = cameraTarget.y - ( _viewableHeight * 0.5 );
                
				TweenLite.to( _scroller, 1, { x:xPos, y:yPos } );				
                
				
				_scroller.x = max( 0, _scroller.x );
				_scroller.x = min( maxX, _scroller.x );
				
				_scroller.y = max( 0, _scroller.y );
                _scroller.y = min( maxY, _scroller.y );                
                
				_toBeScroll.scrollRect = _scroller;			
			}*/
			
            /*
			var yPos:Number = cameraTarget.y - ( _viewableHeight * 0.75 );            
			_scroller.y = max( _maxHeight, _scroller.y );				
			_scroller.y = min( 0, _scroller.y );            
			TweenLite.to( _scroller, 0.0001, { y:yPos } );            
			_toBeScroll.scrollRect = _scroller;  
            */
			
            var yPos:Number = cameraTarget.y - ( _viewableHeight * 0.10  );			
            _scroller.y = max( 0, _scroller.y );				
			_scroller.y = min( _maxHeight, _scroller.y );						
            TweenLite.to( _scroller, 0, { y:yPos } );
			_toBeScroll.scrollRect = _scroller;            
		}	
		
		
		/*-----------------------------------------------------Getters-------------------------------------------------------*/
		public function get scrollerX():int { return _scrollerX; }
		
		public function get scrollerY():int { return _scrollerY; }
		/*-----------------------------------------------------Setters-------------------------------------------------------*/
		
		public function set scrollerX(value:int):void 
		{
			_scrollerX = value;
		}		
		
		public function set scrollerY(value:int):void 
		{
			_scrollerY = value;
		}
		
		
		/*-----------------------------------------------------EventHandLers-------------------------------------------------------*/
	}

}