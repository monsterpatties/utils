package com.monsterPatties.utils.collisionKit 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author JC
	 */
	public class CollisionKit
	{		
		private static var bitmapData:BitmapData;		
		
		public function CollisionKit ():void 
		{
			
		}
		
		public function pixelCollision( obj1Bmd:BitmapData, obj1Bm:Bitmap, obj2Bmd:BitmapData, obj2Bm:Bitmap ,
												threshold1:int = 250 , threshold2:int = 250
											):Boolean 
		{			
			if ( obj1Bmd.hitTest(  new Point ( obj1Bm.x, obj1Bm.y) , threshold1, obj2Bmd, new Point ( obj2Bm.x, obj2Bm.y ), threshold2 ) ){					
					return true;
			}else {
					return false;
			}			
		}
		
		public function circleCollision( obj1:*, obj2:* ):Boolean 
		{			
			var vx:Number = obj2.x - obj1.x;
			var vy:Number = obj2.y - obj1.y;
			var hitArea:Number = ( obj1.width / 2 )  +  (  obj2.width / 2  );
			var len:Number = Math.sqrt( vx * vx + vy * vy );
			
			
			if (len < hitArea ) {	
				return true;
			}else {
				return false;
			}
		}
		
		public function circleCollisionUpward( obj1:*, obj2:*, advance:int = 0  ):Boolean 
		{			
			var vx:Number = obj2.x - obj1.x;
			var vy:Number = obj2.y - obj1.y;
			var hitArea:Number = ( obj1.width / 2 )  +  (  obj2.width / 2  );
			var len:Number = Math.sqrt( vx * vx + vy * vy );
			
			
			if (len < ( hitArea + advance ) ) {	
				return true;
			}else {
				return false;
			}
		}       
		
		public function hitTestObject( obj1:*, obj2:* ):Boolean 
		{			
			if ( obj1.hitTestObject( obj2 ) ) {
				return true;
			}else {
				return false;
			}
		}
		
		
		//for squares
		public function squareCollision (	displayObject1:DisplayObject, displayObject2:DisplayObject 	):Boolean {
			var bounds1:Rectangle;
			var bounds2:Rectangle;
			
			// get the bounds of the objects
			bounds1 = displayObject1.getBounds( displayObject1 );
			bounds2 = displayObject2.getBounds( displayObject1 );
			
			
			// check for collision horizontally
			if ( 
				!(
					( bounds1.x <= bounds2.x )
					&& ( ( bounds1.x + bounds1.width ) >= bounds2.x )
				)
				&&
				!(
					( bounds2.x <= bounds1.x )
					&& ( ( bounds2.x + bounds2.width ) >= bounds1.x )
				)
			) {
				return false;
			}
			
			
			// check for collision vertically
			if ( 
				!(
					( bounds1.y <= bounds2.y )
					&& ( ( bounds1.y + bounds1.height ) >= bounds2.y )
				)
				&&
				!(
					( bounds2.y <= bounds1.y )
					&& ( ( bounds2.y + bounds2.height ) >= bounds1.y )
				)
			) {
				return false;
			}
			
			
			return true;
			
			
		}		
		
		
		/**
		 * Checks for collision detection by drawing the two objects in two colors and looking for an intersecting color
		 * 
		 * Does not account for transformations yet
		 * 
		 * @param	displayObject1 - First display object for testing
		 * @param	displayObject2 - Second display object for testing
		 * @param	dispX - horizontal displacement to be added for the first object
		 * @param	dispY - vertical displacement to be added for the first object
		 * 
		 * @return 	Boolean
		 */
		public function colorDifferenceCollision ( 
			displayObject1:DisplayObject, displayObject2:DisplayObject, dispX:Number = 0, dispY:Number = 0
		):Boolean {
			var object1Width:Number;
			var object1Height:Number;
			var object1X:Number;
			var object1Y:Number;
			
			var object2Width:Number;
			var object2Height:Number;
			var object2X:Number;
			var object2Y:Number;
			
			var pt1:Point;
			var pt2:Point;
			var pt1A:Point;
			var pt2A:Point;
			
			var intersectingRectangle:Rectangle;
			var intersectingRectangle1:Rectangle;
			var intersectingRectangle2:Rectangle;
			var intersectingRectangle3:Rectangle;
			var colorRectangle:Rectangle;
			
			var rectX:Number;
			var rectY:Number;
			var rectWidth:Number;
			var rectHeight:Number;
			
			// var bitmapData:BitmapData;
			
			var colorTransform1:ColorTransform;
			var colorTransform2:ColorTransform;
			
			var matrix1:Matrix;
			var matrix2:Matrix;
			
			if ( bitmapData != null ) {
				bitmapData.dispose();
				bitmapData = null;
			}
			
			
			// get the x, y, width and height of the objects
			object1Width = displayObject1.width;
			object1Height = displayObject1.width;
			object1X = displayObject1.x + dispX;
			object1Y = displayObject1.y + dispY;
			
			object2Width = displayObject2.width;
			object2Height = displayObject2.width;
			object2X = displayObject2.x;
			object2Y = displayObject2.y;
			
			pt1 = new Point( 0, 0 );
			pt2 = new Point( 0, 0 );
			
			// globalize the coordinates
			pt1 = displayObject1.localToGlobal( pt1 );
			pt2 = displayObject2.localToGlobal( pt2 );
			
			pt1.x += dispX;
			pt1.y += dispY;
			
			// find the intersecting bounds of the two objects
			if ( pt1.x < pt2.x ) {
				if ( pt1.y < pt2.y ) { // lr // ok
					rectX = pt2.x;
					rectY = pt2.y;
					
					rectWidth = pt1.x + object1Width - pt2.x;
					rectHeight = pt1.y + object1Height - pt2.y;
					
					pt1A = new Point( -( pt2.x - pt1.x ), -( pt2.y - pt1.y ) );
					pt2A = new Point( 0, 0 );
				} else { // ur
					rectX = pt2.x;
					rectY = pt1.y;
					
					rectWidth = pt1.x + object1Width - pt2.x;
					rectHeight = pt2.y + object2Height - pt1.y;
					
					pt1A = new Point( -( pt2.x - pt1.x ), 0 );
					pt2A = new Point( 0, -( pt1.y - pt2.y ) );
				}
			} else {
				if ( pt1.y < pt2.y ) { // ll
					rectX = pt2.x;
					rectY = pt1.y;
					
					rectWidth = pt2.x + object2Width - pt1.x;
					rectHeight = pt1.y + object1Height - pt2.y;
					
					pt1A = new Point( 0, -( pt2.y - pt1.y ) );
					pt2A = new Point( -( pt1.x - pt2.x ), 0 );
				} else { // ul
					rectX = pt2.x;
					rectY = pt2.y;
					
					rectWidth = pt2.x + object2Width - pt1.x;
					rectHeight = pt2.y + object2Height - pt1.y;
					
					pt1A = new Point( 0, 0 );
					pt2A = new Point( -( pt1.x - pt2.x ), -( pt1.y - pt2.y ) );
				}
			}
			
			// if there is no bound intersection, return false
			if ( 
				( rectWidth <= 0 )
				|| ( rectHeight <= 0 )
			) {
				return false;
			}
			
			// create intersecting rectangle
			intersectingRectangle = new Rectangle( rectX, rectY, rectWidth, rectHeight );
			
			// create intersecting rectangles
			intersectingRectangle1 = new Rectangle( pt1A.x, pt1A.y, intersectingRectangle.width, intersectingRectangle.height );
			intersectingRectangle2 = new Rectangle( pt2A.x, pt2A.y, intersectingRectangle.width, intersectingRectangle.height );
			intersectingRectangle3 = new Rectangle( 0, 0, intersectingRectangle.width, intersectingRectangle.height );
			
			if ( 
				( intersectingRectangle.width > 1 )
				&& ( intersectingRectangle.height > 1 )
			) {
				colorTransform1 = new ColorTransform( 1, 1, 1, 1, 255, -255, -255, 1 );
				colorTransform2 = new ColorTransform( 1, 1, 1, 1, 255, 255, 255, 1 );
				
				matrix1 = new Matrix();
				matrix2 = new Matrix();
				
				matrix1.tx = pt1A.x;
				matrix1.ty = pt1A.y;
				
				matrix2.tx = pt2A.x;
				matrix2.ty = pt2A.y;
				
				//bitmapData = new BitmapData( intersectingRectangle.width, intersectingRectangle.height, true, 0xFFFFFFFF );
				bitmapData = new BitmapData( 200, 200, true, 0xFFFFFF );
				
				// draw first object with clipping based on the intersecting bounds
				// bitmapData.draw( displayObject1 );
				bitmapData.draw( displayObject1,  matrix1, colorTransform1, null, intersectingRectangle3 );
				
				// draw the second object with clipping using a difference blend mode
				// bitmapData.draw( displayObject2 );
				bitmapData.draw( displayObject2,  matrix2, colorTransform2, BlendMode.DIFFERENCE, intersectingRectangle3 );
				
				// get the color of cyan
				colorRectangle = bitmapData.getColorBoundsRect( 0xFFFFFFFF, 0xFF00FFFF, true );
				bitmapData.dispose();
				
				
				if ( 
					( colorRectangle.width > 0 )
					&& ( colorRectangle.height > 0 )
				) {
					return true;
				}
			}
			
			return false;
		}
		
		
		
		/**
		 * This method checks for collision between two circular objects
		 * 
		 * @param	displayObject1 - first display object for testing
		 * @param	displayObject2 - second display object for testing
		 * @param	dispX - horizontal displacement added to the first object
		 * @param	dispY - vertical displacement added to the first object
		 * 
		 * @return Boolean
		 */
		public function sphereCollision ( 
			displayObject1:DisplayObject, displayObject2:DisplayObject, dispX:Number = 0 , dispY:Number = 0	):Boolean {
			var object1Width:Number = displayObject1.width;
			var object1Height:Number = displayObject1.height;
			
			var object2Width:Number = displayObject2.width;
			var object2Height:Number = displayObject2.height;
			
			var pt1:Point = new Point( 0, 0 );
			var pt2:Point = new Point( 0, 0 );
			
			var radius1:Number = object1Width / 2;
			var radius2:Number = object2Width / 2;
			
			var distance:Number;
			
			if (
				( displayObject1.width != displayObject1.height )
				|| ( displayObject2.width != displayObject2.height )
			) {
				throw( new Error( 'The display objects must be spheres' ) );
			}
			
			// globalize points
			pt1 = displayObject1.localToGlobal( pt1 );
			pt2 = displayObject2.localToGlobal( pt2 );
			
			// get center points
			pt1.x += radius1;
			pt1.y += radius1;
			
			pt2.x += radius2;
			pt2.y += radius2;
			
			// add displacement stuff
			pt1.x += dispX;
			pt1.y += dispY;
			
			// get distance
			distance = Point.distance( pt1, pt2 );
			
			if ( distance > ( radius1 + radius2 ) ) {
				return false;
			} else {
				return true;
			}
		}
		
		public function randomNumbers( max:int , min:int , decimals:Boolean  ):* 
		{
			var rnd1:Number;
			var rnd2:int;
			
			if ( decimals ) {
				rnd1 = Math.floor( Math.random() * ( 1 + max - min ) ) + min;
				return rnd1;
			}else{
				rnd2 = Math.floor( Math.random() * ( 1 + max - min ) ) + min;
				return rnd2;
			}			
			
		}	
	}

}