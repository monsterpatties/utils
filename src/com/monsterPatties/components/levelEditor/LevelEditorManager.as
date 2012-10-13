package com.monsterPatties.components.levelEditor 
{
	import com.greensock.BlitMask;
	import com.greensock.TweenLite;
	import com.monsterPatties.utils.fileManager.FileManager;
	import com.monsterPatties.utils.fileManager.FileManagerEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ...
	 */
	public class LevelEditorManager extends Sprite
	{		
		/*--------------------------------------------------------------Constant-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Properties---------------------------------------------------------------------------*/		
		private var _tileHolder:Sprite;
		private var _toolPanel:ToolPanel;
		private var _currentY:Number = 0;
		private var _bm:BlitMask;
		
		private var _timer:Timer;
		private var _mapDir:String;
		private var _mapMoveSpeed:Number = 7;
		private var _totalRow:int;
		private var _totalCol:int;
		private var _tiles:Array;
		
		private var _scaleRate:Number = 0.10;
		private var _fileManager:FileManager;
		private var map:Array = [[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									[0,0,1,0,0,0,0,0,0,0,1,3,3,0,0],
									[0,0,0,1,0,0,0,0,0,0,1,0,0,0,0],
									[0,0,0,1,0,0,0,0,0,0,0,1,0,0,0],
									[0,0,0,1,0,0,0,0,0,0,0,0,1,0,0],
									[0,0,1,0,0,0,0,0,0,0,0,0,1,0,0],
									[0,0,1,0,0,0,0,0,0,0,0,0,1,0,0],
									[0,0,0,1,0,0,0,0,0,0,0,0,1,0,0],
									[0,0,0,1,0,0,0,0,0,0,0,1,0,0,0],
									[0,0,1,0,0,0,0,0,0,0,1,0,0,0,0],
									[0,0,1,0,0,0,0,0,0,0,1,0,0,0,0],
									[0,0,0,1,0,0,0,0,0,0,0,1,0,0,0],
									[0,0,0,1,5,0,0,0,0,0,0,0,0,0,0],
									[0,0,0,1,6,0,0,0,0,0,0,1,0,0,0],
									[0,0,1,0,0,0,0,0,0,0,1,0,0,0,0],
									[0,0,0,1,0,0,12,12,14,0,0,0,0,0,0],
									[0,0,0,1,0,0,0,0,0,0,0,0,0,0,0],
									[0,0,1,0,0,0,1,2,0,0,0,0,0,0,0],
									[0,0,0,0,0,1,2,1,1,0,0,0,0,0,0],
									[0,0,0,0,0,0,1,0,1,0,0,0,0,0,0],
									[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									[0,0,0,8,8,8,0,0,0,0,0,0,0,0,0],
									[0,0,0,6,9,3,0,0,0,0,0,0,0,0,0],
									[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
									[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]];
		/*--------------------------------------------------------------Constructor--------------------------------------------------------------------------*/
		
		public function LevelEditorManager() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			prepareHolders();			
			addToolPanel();
			addTimer();
			addFileManager();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);			
			removeMovePanel();
			removeTimer();
		}
		
		private function addFileManager():void 
		{
			_fileManager = new FileManager();
			_fileManager.addEventListener( FileManagerEvent.FILE_LOADED, onFileLoaded );
			_fileManager.addEventListener( FileManagerEvent.FILE_SAVE, onFileSave );
		}		
		
		private function prepareHolders():void {			
			_tileHolder = new Sprite();
			addChild( _tileHolder );
			_tileHolder.x = 0; 
			_tileHolder.y = 0; 
			
			//var mask:Sprite = new Sprite();
			//mask.graphics.lineStyle( 1, 0xFF0000 );			
			//mask.graphics.beginFill( 0xFF0000 );
			//mask.graphics.drawRect( 0, 0, 345, 500 );
			//addChild( mask );
			//
			//_tileHolder.mask = mask;
		}
		
		private function createEmptyMap( totalRow:int, totalCol:int ):void {
			
			if( _tiles != null ){
				if ( _tiles.length > 0 ) {
					clearMap();
				}
			}
			
			_tiles = new Array();			
			_totalRow = totalRow;
			_totalCol = totalCol;			
			
			for (var row:int = 0; row < _totalRow ; row++) 
			{
				_tiles[ row ] = new Array();
				for (var col:int = 0; col < _totalCol ; col++) 
				{						
					var tile:EditorTile = new EditorTile();															
					_tileHolder.addChild( tile );					
					_tiles[ row ][ col ] = tile;
					tile.mc.x = ( tile.width * col ); 
					tile.mc.y = ( tile.height * row )					
					//tile.cacheAsBitmap = true;
				}
			}		
			scaleMap( 1 );
		}
		
		private function clearMap():void 
		{
			while ( _tileHolder.numChildren > 0 ) 
			{
				_tileHolder.removeChildAt( 0 ); 
				//trace( "removing tile map" );
			}
			
			_tiles = new Array();
		}
		
		
		private function loadMap( map:Array ):void 
		{		
			if( _tiles != null ){
				if ( _tiles.length > 0 ) {
					clearMap();
				}
			}
			
			_tiles = new Array();
			_totalRow = map.length;
			_totalCol = map[ 0 ].length;			
			
			for (var row:int = 0; row < _totalRow ; row++) 
			{
				_tiles[ row ] = new Array();
				for (var col:int = 0; col < _totalCol ; col++) 
				{						
					var tile:EditorTile = new EditorTile();															
					_tileHolder.addChild( tile );
					tile.setTile( map[ row ][ col ] );
					_tiles[ row ][ col ] = tile;
					tile.mc.x = ( tile.width * col ); 
					tile.mc.y = ( tile.height * row )					
					//tile.cacheAsBitmap = true;
				}
			}
			
			scaleMap( 1 );
		}
		
		
		private function addToolPanel():void 
		{			
			_toolPanel = new ToolPanel( 310, 15 );
			addChild( _toolPanel );			
			_toolPanel.addEventListener( LevelEditorEvent.MAP_STOP_MOVE, onMapStopMove );
			_toolPanel.addEventListener( LevelEditorEvent.GENERATE_MAP, onGenerateMap );
			_toolPanel.addEventListener( LevelEditorEvent.CREATE_NEW_MAP, onCreateNewMap );
			_toolPanel.addEventListener( LevelEditorEvent.SCROLL_MAP, onScrollMap );
			_toolPanel.addEventListener( LevelEditorEvent.MAP_SCALE_DOWN, onScaleDownMap );
			_toolPanel.addEventListener( LevelEditorEvent.MAP_SCALE_UP, onScaleUpMap );
			_toolPanel.addEventListener( LevelEditorEvent.LOAD_MAP, onLoadpMap );
			_toolPanel.addEventListener( LevelEditorEvent.ADD_ROW, onAddRow );
			_toolPanel.addEventListener( LevelEditorEvent.ADD_COL, onAddCol );
			_toolPanel.addEventListener( LevelEditorEvent.SUB_ROW, onSubRow );
			_toolPanel.addEventListener( LevelEditorEvent.SUB_COL, onSubCol );
			
			//_bm = new BlitMask(_tileHolder, _tileHolder.x, _tileHolder.y, 500, 700, false);
		}															
		
		private function removeMovePanel():void 
		{
			if ( _toolPanel != null ) {
				_toolPanel.removeEventListener( LevelEditorEvent.MAP_STOP_MOVE, onMapStopMove );
				_toolPanel.removeEventListener( LevelEditorEvent.GENERATE_MAP, onGenerateMap );
				_toolPanel.removeEventListener( LevelEditorEvent.CREATE_NEW_MAP, onCreateNewMap );
				_toolPanel.removeEventListener( LevelEditorEvent.SCROLL_MAP, onScrollMap );
				if ( this.contains( _toolPanel ) ) {
					this.removeChild( _toolPanel );
					_toolPanel = null;
				}
			}
		}
		
		private function addTimer():void 
		{
			_timer = new Timer( 30 );
			_timer.addEventListener( TimerEvent.TIMER, onTick );
		}		
		
		private function removeTimer():void 
		{
			_timer.stop();
			_timer.removeEventListener( TimerEvent.TIMER, onTick );
			_timer = null;
		}		
		/*--------------------------------------------------------------Methods-----------------------------------------------------------------------------*/
		private function scaleMap( scaleRate:Number ):void 
		{	
			if ( scaleRate == 1 ) {
				_tileHolder.scaleX = 1;
				_tileHolder.scaleY = 1;
			}else {
				_tileHolder.scaleX += scaleRate;
				_tileHolder.scaleY += scaleRate;
			}
			
			_tileHolder.cacheAsBitmap = true;
			trace( "tileHolderHeight", _tileHolder.height );			
		}
		
		private function stripAllArray( originalstring:String ):Array{
			var original:Array=originalstring.split(" ");
			var filter:String = original.join("");
			
			original=filter.split("[");
			filter = original.join("");
			
			original=filter.split("]");
			filter = original.join("");
			
			original=filter.split(";");
			filter = original.join("");
			
			original=filter.split(",");			
			
			return original;
		}		
		
		
		private function countRows( originalstring:String ):Array{
			var original:Array=originalstring.split(" ");
			var filter:String = original.join("");
			
			original=filter.split("[");
			filter = original.join("");	
			
			original=filter.split(",");
			filter = original.join("");
			
			return original;
		}

		private function countCols( originalstring:String ):Array{
			var original:Array=originalstring.split(" ");
			var filter:String = original.join("");
			
			original=filter.split("]");
			filter = original.join("");
			
			return original;
		}

		/*--------------------------------------------------------------Setters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------Getters-----------------------------------------------------------------------------*/
		
		/*--------------------------------------------------------------EventHandlers-----------------------------------------------------------------------*/		
		private function onMapStopMove(e:LevelEditorEvent):void 
		{
			//TweenLite.killTweensOf( _tileHolder );
			//trace( "stop map move!" );
			_timer.stop();
		}
		
		private function onTick(e:TimerEvent):void 
		{
			if ( _mapDir == "up" ) {
				_tileHolder.y -= _mapMoveSpeed;
			}else {
				_tileHolder.y += _mapMoveSpeed;
			}
		}
		
		private function onGenerateMap(e:LevelEditorEvent):void 
		{
			var map:String;
			var inner:String = "[";
			
			for (var row:int = 0; row < _totalRow ; row++) 
			{				
				for (var col:int = 0; col < _totalCol ; col++) 
				{	
					if ( col == 0 ) {
						inner += "["
					}
					if ( ( col + 1 ) >= _totalCol ) {
						inner += "" + _tiles[ row ][ col ].currentTile;
					}else {
						inner += _tiles[ row ][ col ].currentTile + ",";
					}
					
					//trace( "check ===========>",_tiles[ row ][ col ].currentTile );
					//trace( "row: ",row, "col ", col );
				}
				
				if ( ( row + 1 ) >= _totalRow ) {
					inner += "]";
				}else {
					inner += "],\n";
				}				
				//trace( "row: ",row, "col ", col );
			}			
			
			map = inner + "];";			
			
			trace( "show map array here \n", map );
			_fileManager.saveData( map );
		}
		
		private function onCreateNewMap(e:LevelEditorEvent):void 
		{
			createEmptyMap( e.obj.row , e.obj.col );
		}
		
		private function onScrollMap(e:LevelEditorEvent):void 
		{
			var percent:Number = ( e.obj.originY / e.obj.height );
			var totalHeight:Number = _tileHolder.height;
			if ( percent <= 0 ) {
				percent = 0;
			}else if ( percent >= 1 ) {
				percent = 1;
			}
			
			var currPosition:Number = totalHeight * percent;
			var remainingHeight:Number = ( totalHeight - currPosition );
			//trace( "percent Scroller", percent, "currPosition: ", currPosition, "totalHeight", totalHeight, "remainingHeight", remainingHeight );
			
			if ( remainingHeight >= 400 ) {								
				_tileHolder.y = -currPosition;				
			}else {
				//trace( "limit scroll1 remaining height", remainingHeight );
			}			
		}
		
		private function onScaleUpMap(e:LevelEditorEvent):void 
		{			
			scaleMap( _scaleRate );			
		}
		
		private function onScaleDownMap(e:LevelEditorEvent):void 
		{
			scaleMap( -_scaleRate );			
		}
		
		public function stripspaces(originalstring:String):String
		{
			var original:Array=originalstring.split(" ");
			return(original.join(""));
		}
		
		private function onLoadpMap(e:LevelEditorEvent):void {
			_fileManager.browseAndLoadData(  );
		}
		
		private function onFileSave(e:FileManagerEvent):void 
		{
			
		}
		
		private function onFileLoaded(e:FileManagerEvent):void 
		{
			trace( "check map ===>>", e.obj.data );
			var map:Array = new Array();			
			
			var mapDat:String = stripspaces( e.obj.data);
			var len:int = mapDat.length;
			var cleanMap:Array = stripAllArray( mapDat );
			var mapa:Array = new Array();
			var foundLen:Boolean = false;
			var rowLen:int = countCols( mapDat ).length - 2;
			var colLen:int;
			
			var filteredArray2:Array = countRows( mapDat );

			var rowe:int = 1;
			for( var i:int = 0; i < filteredArray2.length; i++ ){
				//trace( "searching", filteredArray2[ i ] );
				var sString:String = filteredArray2[ i ];
				if( sString.indexOf( "]" ) != -1 ){					
					break;
				}
				rowe++;
			}
			
			colLen = rowe;			
			
			var index:int = 0;
			
			for (var k:int = 0; k < rowLen; k++) 
			{
				map[ k ] = new Array();
				for (var l:int = 0; l < colLen; l++) 
				{					
					map[ k ][ l ] = cleanMap[ index ];
					index++;
				}
			}
			
			loadMap( map );
		}
		
		private function onSubCol(e:LevelEditorEvent):void 
		{
			trace( "sub col",_tiles  );			
			_totalCol--;
			for (var row:int =  0 ; row < _totalRow; row++) 
			{					
				for (var col:int = _totalCol; col < ( _totalCol + 1 ) ; col++) 
				{					
					if ( _tiles[ row ][ col ] != null ) {
						if ( _tileHolder.contains( _tiles[ row ][ col ] ) ) {
							_tileHolder.removeChild( _tiles[ row ][ col ] );
							_tiles[ row ][ col ] = null;							
							trace( "pop col" );
						}
					}					
				}
			}			
		}
		
		private function onSubRow(e:LevelEditorEvent):void 
		{
			trace( "sub row" );
			_totalRow--;			
			for (var row:int = _totalRow; row < ( _totalRow + 1 ); row++)
			{					
				for (var col:int = 0; col < _totalCol; col++) 
				{	
					if ( _tiles[ row ][ col ] != null ) {
						if ( _tileHolder.contains( _tiles[ row ][ col ] ) ) {
							_tileHolder.removeChild( _tiles[ row ][ col ] );
							_tiles[ row ][ col ] = null;							
							trace( "pop" );
						}
					}										
				}
			}			
		}
		
		private function onAddCol(e:LevelEditorEvent):void 
		{
			trace( "add col map b4 add col",_tiles  );			
			_totalCol++;
			for (var row:int =  0 ; row < _totalRow; row++) 
			{					
				for (var col:int = ( _totalCol - 1 ); col < _totalCol ; col++) 
				{					
					var tile:EditorTile = new EditorTile();															
					_tileHolder.addChild( tile );					
					_tiles[ row ][ col ] = tile;
					tile.mc.x = ( tile.width * col ); 
					tile.mc.y = ( tile.height * row )					
				}
			}
			
			trace( "add col map after add col",_tiles  );			
		}
		
		private function onAddRow(e:LevelEditorEvent):void 
		{			
			trace( "add row" );			
			_totalRow++;
			for (var row:int = ( _totalRow - 1 ) ; row < _totalRow; row++) 
			{
				_tiles[ row ] = new Array();
				for (var col:int = 0; col < _totalCol ; col++) 
				{						
					var tile:EditorTile = new EditorTile();															
					_tileHolder.addChild( tile );					
					_tiles[ row ][ col ] = tile;
					tile.mc.x = ( tile.width * col ); 
					tile.mc.y = ( tile.height * row )					
				}
			}		
		}
		
		/*
		private function onLoadpMap(e:LevelEditorEvent):void 
		{
			trace( "check map ===>>", e.obj.map );
			var map:Array = new Array();
			//map = e.obj.map as Array;
			//loadMap( map );
			
			var mapDat:String = stripspaces( e.obj.map);
			var len:int = mapDat.length;
			var cleanMap:Array = stripAllArray( mapDat );
			var mapa:Array = new Array();
			var foundLen:Boolean = false;
			var rowLen:int = countCols( mapDat ).length - 2;
			var colLen:int;
			
			var filteredArray2:Array = countRows( mapDat );

			var rowe:int = 1;
			for( var i:int = 0; i < filteredArray2.length; i++ ){
				//trace( "searching", filteredArray2[ i ] );
				var sString:String = filteredArray2[ i ];
				if( sString.indexOf( "]" ) != -1 ){
					//trace( "found===>", filteredArray2[ i ] );
					break;
				}
				rowe++;
			}
			
			colLen = rowe;
			
			
			//for (var i:int = 0; i < len ; i++) 
			//{
				//if ( mapDat.charAt( i ) != "," && mapDat.charAt( i ) != ";" && mapDat.charAt( i ) != " " ) {
					//mapa.push( mapDat.charAt( i ) );
					//trace( "insert this",mapDat.charAt( i ) , "index", i  );
				//}				
			//}		
			
			//var foundLen:Boolean = false;
			//var colLen:int;
			//var rowLen:int;
			//for (var j:int = 0; j < mapa.length; j++) 
			//{
				//if ( mapa[ j ] == "]" && !foundLen ) {
					//foundLen = true;
					//colLen = j - 3;					
					//trace( "index", j - 2, "actual index", j );
				//}
				//
				//if ( mapa[ j ] == "]"  ) {
					//rowLen++;					
				//}
			//}		
			//
			//
			//rowLen -=1;
			//trace( "Totalrow", rowLen, "Totalcol", colLen, "cleanMap", cleanMap[ 10 ] );			
			//trace( "clean mapa0", cleanMap[ 0 ],"mapa1", cleanMap[ 1 ],"mapa2", cleanMap[ 2 ], "mapa3", cleanMap[ 3 ],"mapa4", cleanMap[ 4 ], "mapa5", cleanMap[ 5 ], "mapa len", cleanMap.length );
			//trace( "mapa0", mapa[ 0 ],"mapa1", mapa[ 1 ],"mapa2", mapa[ 2 ], "mapa3", mapa[ 3 ],"mapa4", mapa[ 4 ], "mapa5", mapa[ 5 ], "mapa len", mapa.length );
			
			
			var index:int = 0;
			
			for (var k:int = 0; k < rowLen; k++) 
			{
				map[ k ] = new Array();
				for (var l:int = 0; l < colLen; l++) 
				{					
					map[ k ][ l ] = cleanMap[ index ];
					index++;
				}
			}
			
			loadMap( map );			
		}
		*/
	}

}