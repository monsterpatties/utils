package com.monsterPatties.utils.pathFinder 
{
	import com.monsterPatties.controllers.mapManager.Map;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author master earl ,edited  by JC
	 */
	
	
	public class PathFinder {		
		
		private var path:Object =  new Object();
		public var paths:Array = new Array();
		private var theStage:Map;
		private var myTyped:Number;
		
		function PathFinder() {
			//trace("PathFinder class initialized");
		}
		
		public function findPath(startx:Number, starty:Number, targetx:Number, targety:Number, mystage:Map, myType:Number = 0):Boolean {
		
			theStage = mystage;
			myTyped = myType;
			//make new path object
			//path = {};
			path = new Object();
			//make new array for unchecked tiles
			//path.Unchecked_Neighbours = [];
			path.Unchecked_Neighbours = new Array();
			//not done yet
			
			path.time =  getTimer();
			path.done = false;
			//initialize
			path.named = "node_" + starty + "_" + startx;
			
			//trace( "pathName: ", path.named , path.Unchecked_Neighbours.length , path.done );
			
			//create first node
			var cost:Number = Math.abs( startx - targetx ) + Math.abs( starty - targety );
			
			//trace( "cost: ", cost );
			
			path[ path.named ] = { xx:startx, yy:starty, visited:true, parentx:null, parenty:null, cost:cost };
			
			//trace( "path2: " , path[ path.named ].xx );
			
			//add node to array
			path.Unchecked_Neighbours.push(path[path.named]);
			
			//trace( "checkArray2: ", path.Unchecked_Neighbours.length );
		
			//loop
			while ( path.Unchecked_Neighbours.length > 0 ) {
				//get the next node
				var N:* = path.Unchecked_Neighbours.shift();
				
				//trace( "N", N.xx, N.yy );
		
				//we've finished
				if (N.xx == targetx && N.yy == targety) {
					//trace( "N2", N.xx, N.yy );
					//done
					make_path(N);
					path.done = true;
					break;
				} else {
					N.visited = true;
					//lookup neighbour
					addNode(N, N.xx+1, N.yy, targetx, targety);
					addNode(N, N.xx-1, N.yy, targetx, targety);
					addNode(N, N.xx, N.yy+1, targetx, targety);
					addNode(N, N.xx, N.yy-1, targetx, targety);
					/*addNode(N, N.xx-1, N.yy-1, targetx, targety);
					addNode(N, N.xx+1, N.yy-1, targetx, targety);
					addNode(N, N.xx-1, N.yy+1, targetx, targety);
					addNode(N, N.xx+1, N.yy+1, targetx, targety);*/
				}
			}
			
			//check if path was found
			if ( path.done ) {
				//we reached the goal
				//trace("done TT");
				
				//paths.pop();
				return true;
			} else {
				trace("can't do");
				//we couldn't get there;
				return false;
			}
		}
		
		private function addNode(ob:Object, xx:Number, yy:Number, targetx:Number, targety:Number):void {

			//name of the new node
			path.named = "node_"+yy+"_"+xx;
			//add to the unchecked neighbours, if its walkable
			
			//var myTile:* = theStage.getChildByName("tile_"+yy+"_"+xx);
			var myTile:* = theStage.getTileByName( "Tile" + yy + "_" + xx );
			//trace( "myTilePath: ", myTile );
			
			if (myTile != null) {
				if (myTile.tileType == 0 || myTyped == 1) {
					//find estimated cost to the target
					var cost:Number = Math.abs(xx-targetx)+Math.abs(yy-targety)+ob.cost;
		
					//and if its not visited yet
					if (path[path.named] == undefined || path[path.named].cost>cost) {
						//make new node
						path[path.named] = {xx:xx, yy:yy, visited:false, parentx:ob.xx, parenty:ob.yy, cost:cost};
						//add to the array
						for (var i:Number = 0; i<path.Unchecked_Neighbours.length; i++) {
							if (cost<path.Unchecked_Neighbours[i].cost) {
								path.Unchecked_Neighbours.splice(i, 0, path[path.named]);
								break;
							}
						}
			
						//didnt add it yet, too much cost, add to the end
						if ( i >= path.Unchecked_Neighbours.length ) {
							path.Unchecked_Neighbours.push( path[ path.named ] );
						}
					}
				}
			}
		}

		private function make_path(ob:Object):void {
			//create path array
			paths = [];
			//loop until no more parents
			while (ob.parentx != null) {
				//add the x and y
				paths[paths.length] = {yy:ob.yy, xx:ob.xx};
		
				//mark the tile
				//var myTile:* = theStage.getChildByName("tile_"+ob.yy+"_"+ob.xx);
				var myTile:* = theStage.getTileByName( "Tile"+ob.yy+"_"+ob.xx );
				
				//myTile.gotoAndStop(3);
				//make its parent new object
				ob = path["node_"+ob.parenty+"_"+ob.parentx];
			}
		}
		
	}

}