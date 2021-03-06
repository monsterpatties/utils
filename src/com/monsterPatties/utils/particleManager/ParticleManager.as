package com.monsterPatties.utils.particleManager 
{	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;	
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	
	/**
	 * ...
	 * @author ...
	 */
	public class ParticleManager extends Sprite
	{
		/*-----------------------------------------------------------Constant------------------------------------------------------*/
		
		/*-----------------------------------------------------------Properties------------------------------------------------------*/
		private var _bmd:BitmapData;
		private var _bm:Bitmap;		
		private var _particleArray:Vector.< Particle >;
		private var _blurFilter:BlurFilter;
		private var _colorTransform:ColorTransform;			
		
		private var _particleBmd:BitmapData;
		private var _rectChecker:Rectangle;		
		
		private var _bmd2:BitmapData;
		private var _bm2:Bitmap;
		private var _enemyParticleHolder:Vector.< Particle >;
		
		private var _gameWidth:Number = 0;
		private var _gameHeight:Number = 0;
		
		private var _redBmd:BitmapData;
		private var _orangeBmd:BitmapData;		
		private var _yellowBmd:BitmapData;
		private var _greenBmd:BitmapData;
		private var _blueBmd:BitmapData;
		private var _violetBmd:BitmapData;
		
		private var _rainBow:int = 0;
		
		/*-----------------------------------------------------------Constructor------------------------------------------------------*/
		
		
		public function ParticleManager( gameWidth:Number, gameHeight:Number ) 
		{
			_gameWidth = gameWidth;
			_gameHeight = gameHeight;
			
			addEventListener( Event.ADDED_TO_STAGE, init );		
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			
			prepareChecker();
			setParticleAppearance();
			setDisplay();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeDisplay();
		}
		
		/*-----------------------------------------------------------Methods------------------------------------------------------*/
		private function setDisplay():void 
		{			
			_particleArray = new Vector.< Particle >();
			_enemyParticleHolder = new Vector.< Particle >();
			//_blurFilter = new BlurFilter( 2.5, 2.5 );
			//_colorTransform = new ColorTransform( 1.1,1.1,1.1,.99 );
			
			_blurFilter = new BlurFilter( 2.5, 2.5 );
			_colorTransform = new ColorTransform( .8,.8,.8,.90 );
			
			_bmd = new BitmapData( _gameWidth,_gameHeight, true, 0 );
			_bm = new Bitmap( _bmd );
			addChild( _bm );
			
			_bmd2 = new BitmapData( _gameWidth,_gameHeight, true, 0 );
			_bm2 = new Bitmap( _bmd2 );
			addChild( _bm2 );
		}
		
		private function removeDisplay():void 
		{	
			_particleArray = null;
			_enemyParticleHolder = null;
			
			if ( _bm != null ) {
				if ( this.contains( _bm ) ) {
					_bmd.dispose();
					this.removeChild( _bm );
					_bm = null;
				}
			}	
			
			if ( _bm2 != null ) {
				if ( this.contains( _bm2 ) ) {
					_bmd2.dispose();
					this.removeChild( _bm2 );
					_bm2= null;
				}
			}			
			
			_redBmd.dispose();
			_orangeBmd.dispose();
			_yellowBmd.dispose();
			_greenBmd.dispose();
			_blueBmd.dispose();
			_violetBmd.dispose();
			_particleBmd.dispose();			
		}
		
		public function createParticles( xPos:Number, yPos:Number, particleCnt:int, com:Boolean, formation:int = 0 ):void 
		{	
			var particle:Particle;
			
			if( formation == 0 ){
				var pi:Number = 3.14;
				var calculated_1:Number = pi / 180;
				var angle:Number = 0;
				var particleCount:int = particleCnt;
				var angleDifference:Number = 360 / particleCount;						
				
				for (var i:int = 0; i < particleCount; i++) 
				{				
					particle = new Particle();
					particle.com = com;
					particle.dx = Math.cos( angle * calculated_1 ) * ( particle.radius );
					particle.dy = Math.sin( angle * calculated_1 ) * particle.radius - 1;
					particle.width = 5;
					particle.height = 5;
					angle += angleDifference;
					particle.x = xPos - 20;
					particle.y = yPos - 20;
					particle.damage = 100;
					
					if( !com ){
						_particleArray.push( particle );
					}else {
						_enemyParticleHolder.push( particle );
					}
				}		
			}else if ( formation == 1 ) {
				for (var j:int = 0; j < particleCnt; j++) 
				{				
					particle = new Particle();
					particle.color = j;
					particle.com = com;
					particle.dx = -5;
					particle.dy = 0;
					particle.width = 5;
					particle.height = 5;
					//angle += angleDifference;
					particle.x = xPos - 20;
					particle.y = yPos - ( 8 * j );
					particle.damage = 100;
					
					if( !com ){
						_particleArray.push( particle );
					}else {
						_enemyParticleHolder.push( particle );
					}
				}
			}			
		}
		
		
		public function setParticleAppearance( color:int = 3 ):void 
		{
			var particleSizeSet:Array = [ 1, 1.5, 1.8, 2.5, 3, 3.5, 4, 4.5 ];			
			var size:int = 60;
			var rect:Rectangle;
			var matrix:Matrix;
			var rndSize:int = 1;
			//red,orange,yellow,green,blue,violet - rainbow
			//var colors:Array = [ 0xFF0000, 0xFF9900, 0xE2FF22, 0x00FF00, 0x0099FF, 0x6666FF ];
			var colors:Array = [ 0x6666FF, 0x0099FF, 0x00FF00, 0xE2FF22, 0xFF9900, 0xFF0000 ];			
			var len:int = colors.length;
			var particleColor:Sprite;
			
			for (var i:int = 0; i < len; i++) 
			{
				particleColor = new Sprite();
				particleColor.graphics.beginFill( colors[ i ] );
				particleColor.graphics.drawCircle( 20,20, particleSizeSet[ 6 ] );
				particleColor.graphics.endFill();
				
				rect = particleColor.getBounds( particleColor );
				matrix = new Matrix();
				matrix.translate( -rect.x , -rect.y );
				
				switch ( i ) 
				{
					case 0:
						_redBmd = new BitmapData( size, size, true, 0 );			
						_redBmd.draw( particleColor );
					break;
					
					case 1:
						_orangeBmd = new BitmapData( size, size, true, 0 );			
						_orangeBmd.draw( particleColor );
					break;
					
					case 2:
						_yellowBmd = new BitmapData( size, size, true, 0 );			
						_yellowBmd.draw( particleColor );
					break;
					
					case 3:
						_greenBmd = new BitmapData( size, size, true, 0 );			
						_greenBmd.draw( particleColor );
					break;
					
					case 4:
						_blueBmd = new BitmapData( size, size, true, 0 );			
						_blueBmd.draw( particleColor );
					break;
					
					case 5:
						_violetBmd = new BitmapData( size, size, true, 0 );			
						_violetBmd.draw( particleColor );
					break;
					
					
					default:
					break;
				}				
			}			
			
			//_particleBmd = new BitmapData( size, size, true, 0 );			
			//_particleBmd.draw( particleColor );
		}
		
		private function prepareChecker():void 
		{
			_rectChecker =  new Rectangle( 0,0,_gameWidth,_gameHeight );
		}
		
		private function moveParticle( color:int = 0 ):void 
		{			
			//trace( "move particle ", color );
			if( _particleArray != null ){
				if( _bmd != null && !_bmd.getColorBoundsRect(0xFFFFFFFF, 0x00000000, false).isEmpty()  ){
					_bmd.lock();
					_bmd.applyFilter( _bmd, _bmd.rect, new Point( 0, 0 ) , _blurFilter );
					_bmd.colorTransform( _bmd.rect, _colorTransform );				
					//_bmd.scroll( Math.random() * 2, Math.random() * 1 );
					//_bmd.fillRect( _bmd.rect , 0 );
					_bmd.unlock();					
				}		
				
				for (var i:int = 0; i < _particleArray.length; i++) 
				{	
					var particle:Particle = _particleArray[ i ];					
					particle.x += particle.dx;
					particle.y += particle.dy;							
					particle.dx *= particle.decay;
					particle.dy *= particle.decay;
					
					
					if( color != -1 ){
						switch ( color ) 
						{
							case 0:							
								_particleBmd = _redBmd;
							break;
							
							case 1:
								_particleBmd = _orangeBmd;
							break;
							
							case 2:							
								_particleBmd = _yellowBmd;
							break;
							
							case 3:							
								_particleBmd = _greenBmd;
							break;
							
							case 4:							
								_particleBmd = _blueBmd;
							break;
							
							case 5:							
								_particleBmd = _violetBmd;
							break;
							
							
							default:						
							break;
						}
					}else{						
						switch ( particle.color ) 
						{
							case 0:							
								_particleBmd = _redBmd;
							break;
							
							case 1:
								_particleBmd = _orangeBmd;
							break;
							
							case 2:							
								_particleBmd = _yellowBmd;
							break;
							
							case 3:							
								_particleBmd = _greenBmd;
							break;
							
							case 4:							
								_particleBmd = _blueBmd;
							break;
							
							case 5:							
								_particleBmd = _violetBmd;								
							break;						
						}						
					}
					
					_bmd.copyPixels( _particleBmd , new Rectangle( 0, 0 , 60, 60 ) , new Point(  particle.x , particle.y ) , null, null , true );				
					
					if ( particle != null ) {
						if ( particle.x > _gameWidth + 50 ) {
							_particleArray.splice( i, 1 );
						}else if ( particle.x < -50 ) {
							_particleArray.splice( i, 1 );
						}
						
						if ( particle.y > _gameHeight + 50 ) {
							_particleArray.splice( i, 1 );
						}
						
						if ( particle.y < -50 ) {
							_particleArray.splice( i, 1 );
						}
					}
				
					if ( particle != null && _particleArray.length > 0 ) {
						if ( particle.checkLifeCycle() ) {
							if( _particleArray[ i ] != null   ){
								_particleArray.splice( i, 1 );
							}
						}
					}
				}			
				//trace( "particles count: ", _particleArray.length );
			}else {
				//trace( "no particles..." );
			}	
			
			//trace( "see: ",_bmd.getColorBoundsRect(0xff000000, 0x00000000, false ).isEmpty() );
			//trace( "see: ",_bmd.getColorBoundsRect(0xFFFFFFFF, 0x00000000, false).isEmpty() );
		}		
		
		
		
		private function moveEnemyParticle():void 
		{
			if( _enemyParticleHolder != null ){
				if ( _bmd2 != null && !_bmd2.getColorBoundsRect(0xFFFFFFFF, 0x00000000, false).isEmpty()  ) {					
					_bmd2.lock();
					//_bmd2.applyFilter( _bmd2, _bmd2.rect, new Point( 0, 0 ) , _blurFilter );
					//_bmd2.colorTransform( _bmd2.rect, _colorTransform );
					_bmd2.fillRect( _bmd2.rect , 0 );
					_bmd2.unlock();					
				}		
				
				for (var i:int = 0; i < _enemyParticleHolder.length; i++) 
				{	
					var particle:Particle = _enemyParticleHolder[ i ];					
					particle.x += particle.dx;
					particle.y += particle.dy;							
					particle.dx *= particle.decay;
					particle.dy *= particle.decay;
					_bmd2.copyPixels( _particleBmd , new Rectangle( 0, 0 , 60, 60 ) , new Point(  particle.x , particle.y ) , null, null , true );				
					
					if ( particle != null ) {
						if ( particle.x > _gameWidth + 50 ) {
							_enemyParticleHolder.splice( i, 1 );
						}else if ( particle.x < -50 ) {
							_enemyParticleHolder.splice( i, 1 );
						}
						
						if ( particle.y > _gameHeight + 50 ) {
							_enemyParticleHolder.splice( i, 1 );
						}
						
						if ( particle.y < -50 ) {
							_enemyParticleHolder.splice( i, 1 );
						}
					}
				
					if ( particle != null ) {
						if ( particle.checkLifeCycle() ) {
							if( _enemyParticleHolder.length > 0 ){
								if( _enemyParticleHolder[ i ] != null ){
									_enemyParticleHolder.splice( i, 1 );
								}
							}
						}
					}
				}			
				//trace( "particles count: ", _enemyParticleHolder.length );
			}else {
				//trace( "no particles..." );
			}			
		}
		
		
		public function detectCollision( target:MovieClip , tolerance:int, removeParticle:Boolean , com:Boolean ):Object 
		{			
			var obj:Object = new Object();
			obj.hit = false;
			obj.damage = 0;		
			var hitTestVector:Vector.< Particle > ;
			
			if ( !com ) {
				hitTestVector = _particleArray;
			}else {
				hitTestVector = _enemyParticleHolder;
			}
			
			if ( _particleArray != null ) {
				//var len:int = _particleArray.length;
				var len:int = hitTestVector.length;
				if ( len > 0 ){				
					for (var i:int = 0; i < len; i++) 
					{
						//var particle:Particle = _particleArray[ i ];
						var particle:Particle = hitTestVector[ i ];
						var dx:Number = (target.x + target.width / tolerance ) - (particle.x + particle.width / 2);
						var dy:Number = (target.y + target.height / tolerance ) - (particle.y + particle.height / 2);
						var dist:Number = Math.sqrt(dx * dx + dy * dy);
						
						if ( dist < ((particle.width / 2) + (target.width / 2 )) ) {
							//trace( "hit enemy ^___^..................." );
							obj.hit = true;
							obj.damage = particle.damage;
							if( removeParticle ){
								hitTestVector.splice( i, 1 );
							}
							break;
						}
						
					}		
				}
			}
			
			return obj;
		}
		
		
		private function checkParticleCollision():void 
		{
			for (var i:int = 0; i < _particleArray.length; i++) 
			{
				for (var j:int = 0; j < _enemyParticleHolder.length; j++) 
				{
					var particle:Particle = _particleArray[ i ];
					var particle2:Particle = _enemyParticleHolder[ j ];
					
					var dx:Number = ( particle2.x + particle2.width / 2 ) - (particle.x + particle.width / 2);
					var dy:Number = (particle2.y + particle2.height / 2 ) - (particle.y + particle.height / 2);
					var dist:Number = Math.sqrt(dx * dx + dy * dy);
					
					if ( dist < ((particle.width / 2) + ( particle2.width / 2 )) ) {
						//trace( "hit enemy ^___^..................." );
						if( _enemyParticleHolder[ j ] != null ){
							_enemyParticleHolder.splice( j, 1 );						
							//trace( "hit other particle7" );
						}
						//break;
					}					
				}				
			}		
		}
		
		public function moveParticles( color:int = 0 ):void 
		{
			moveParticle( color );
			moveEnemyParticle();
			checkParticleCollision();
		}
		
		public function isParticleEmpty():Boolean 
		{
			var empty:Boolean;
			if ( _particleArray.length == 0 ) {
				empty = true;
			}
			
			return empty;
		}
		/*-----------------------------------------------------------Setters------------------------------------------------------*/
		
		/*-----------------------------------------------------------Getters------------------------------------------------------*/
		
		/*-----------------------------------------------------------EventHandlers------------------------------------------------------*/
		
	}

}