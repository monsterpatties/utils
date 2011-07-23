package com.monsterPatties.utils.box2dWrapper 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class Box2dWrapper extends Sprite
	{
		/*------------------------------------------------------------------------------------Constant--------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------------Properties------------------------------------------------------*/
		private var _world:b2World;
		private var _gravity:b2Vec2;
		private var _wheelBodies:Array;
		private var _stepTimer:Timer;	
		private var _line:Sprite;
		private var _radius:Number;
		public var scaleFactor:Number = 20;  
		/*------------------------------------------------------------------------------------Constructor------------------------------------------------------*/
		
		public function Box2dWrapper() 
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener( Event.REMOVED_FROM_STAGE, destroy );
			initWorld();
		}
		
		private function destroy(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);			
		}
		
		/*------------------------------------------------------------------------------------Methods--------------------------------------------------------*/
		private function initWorld():void 
		{
			_gravity = new b2Vec2( 0, 10 );
			_world = new b2World( _gravity, true );						
			createWall();
			addTimer();
			createWheelBodies();
			trace( "init box2d world wrapper........!!" );			 
		}
		
		private function createWheelBodies():void 
		{
			var cnt:int = 50;
			
			for (var i:int = 0; i < cnt; i++) 
			{
				createWheelBody( Math.random() * 0.5, Math.random() * ( 640 - 20 ) + 10, Math.random() * ( 480 - 20 )+ 10 , ( Math.random() * 100 ) - 50, 0 );				
			}
		}
		
		public function createWheelBody( radius:Number = 5, startX:Number = 10, startY:Number = 10 , velocityX:Number = 0 , velocityY:Number = 0  ):void 
		{
			_radius = radius;
			if ( _wheelBodies == null ) {
				_wheelBodies = new Array();
			}
			
			if ( _line == null ) {
				_line = new Sprite();
				addChild( _line );
			}
			
			var wheelBodyDef:b2BodyDef = new b2BodyDef();
			wheelBodyDef.type = b2Body.b2_dynamicBody;
			wheelBodyDef.position.Set( startX /scaleFactor , startY / scaleFactor );
			var wheelBody:b2Body = _world.CreateBody( wheelBodyDef );			
			var lineVelocity:b2Vec2 = new b2Vec2( velocityX, velocityY );
			wheelBody.SetLinearVelocity( lineVelocity );
			
			var circleShape:b2CircleShape = new b2CircleShape(  _radius );
			var wheelFixtureDef:b2FixtureDef = new b2FixtureDef();
			wheelFixtureDef.shape = circleShape;
			//restitution for bouncyness
			//wheelFixtureDef.restitution = (Math.random() * 0.5) + 0.5
			wheelFixtureDef.restitution = 1;
			//the smoothness == 0 and roughness == 1
			wheelFixtureDef.friction = (Math.random() * 1.0);
			//how heavy is the object
			wheelFixtureDef.density = Math.random() * 20;			
			var wheelFixture:b2Fixture = wheelBody.CreateFixture( wheelFixtureDef );			
			
			_wheelBodies.push( wheelBody );
		}
		
		public function createWall():void 
		{			
			var groundBodyDef:b2BodyDef = new b2BodyDef();
			groundBodyDef.position.Set(0, stage.stageHeight /scaleFactor );
			var groundBody:b2Body = _world.CreateBody(groundBodyDef);
			var groundShape:b2PolygonShape = new b2PolygonShape();
			groundShape.SetAsBox(stage.stageWidth /scaleFactor, 1/ scaleFactor);
			var groundFixtureDef:b2FixtureDef = new b2FixtureDef();
			groundFixtureDef.shape = groundShape;
			var groundFixture:b2Fixture = groundBody.CreateFixture(groundFixtureDef);
			
			var gWall:Sprite = new Sprite();
			gWall.graphics.lineStyle(3, 0x00FF00 );
			gWall.graphics.beginFill( 0x00FF00 );
			gWall.graphics.drawRect( groundBody.GetPosition().x, groundBody.GetPosition().y * scaleFactor, 640, 1 );
			addChild( gWall );
			
			var rightWallBodyDef:b2BodyDef = new b2BodyDef();
			rightWallBodyDef.position.Set(640 /scaleFactor, 0);
			var rightWallBody:b2Body = _world.CreateBody(rightWallBodyDef);
			var rightWallShape:b2PolygonShape = new b2PolygonShape();
			rightWallShape.SetAsBox(1/scaleFactor, stage.stageHeight /scaleFactor );
			var rightWallFixtureDef:b2FixtureDef = new b2FixtureDef();
			rightWallFixtureDef.shape = rightWallShape;
			var rightWallFixture:b2Fixture = rightWallBody.CreateFixture(rightWallFixtureDef);
		 
			var rWall:Sprite = new Sprite();
			rWall.graphics.lineStyle(3, 0x00FF00 );
			rWall.graphics.beginFill( 0x00FF00 );
			rWall.graphics.drawRect( rightWallBody.GetPosition().x * scaleFactor, rightWallBody.GetPosition().y, 1, 480 );
			addChild( rWall );
			
			var leftWallBodyDef:b2BodyDef = new b2BodyDef();
			leftWallBodyDef.position.Set(0, 0);
			var leftWallBody:b2Body = _world.CreateBody(leftWallBodyDef);
			var leftWallShape:b2PolygonShape = new b2PolygonShape();
			leftWallShape.SetAsBox( 1/ scaleFactor, stage.stageHeight /scaleFactor );
			var leftWallFixtureDef:b2FixtureDef = new b2FixtureDef();
			leftWallFixtureDef.shape = leftWallShape;
			var leftWallFixture:b2Fixture = leftWallBody.CreateFixture(leftWallFixtureDef);
		 
			var lWall:Sprite = new Sprite();
			lWall.graphics.lineStyle(3, 0x00FF00 );
			lWall.graphics.beginFill( 0x00FF00 );
			lWall.graphics.drawRect( leftWallBody.GetPosition().x, leftWallBody.GetPosition().y, 1, 480 );
			addChild( lWall );
			
			var ceilingBodyDef:b2BodyDef = new b2BodyDef();
			ceilingBodyDef.position.Set(0, 0);
			var ceilingBody:b2Body = _world.CreateBody(ceilingBodyDef);
			var ceilingShape:b2PolygonShape = new b2PolygonShape();
			ceilingShape.SetAsBox(stage.stageWidth /scaleFactor, 1/scaleFactor);
			var ceilingFixtureDef:b2FixtureDef = new b2FixtureDef();
			ceilingFixtureDef.shape = ceilingShape;
			var ceilingFixture:b2Fixture = ceilingBody.CreateFixture(ceilingFixtureDef);
			
			var uWall:Sprite = new Sprite();
			uWall.graphics.lineStyle(3, 0x00FF00 );
			uWall.graphics.beginFill( 0x00FF00 );
			uWall.graphics.drawRect( ceilingBody.GetPosition().x, ceilingBody.GetPosition().y, 640, 1 );
			addChild( uWall );

		}
		
		private function addTimer():void 
		{
			_stepTimer = new Timer( 0.025 * 1000 );
			_stepTimer.addEventListener( TimerEvent.TIMER, onTick );
			_stepTimer.start();
		}
		
		/*------------------------------------------------------------------------------------Setters--------------------------------------------------------*/
		public function setGravity( x:Number, y:Number ):void 
		{
			_gravity = new b2Vec2( x, y );
		}
		/*------------------------------------------------------------------------------------Getters--------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------------EventHandlers--------------------------------------------------*/
		private function onTick(e:TimerEvent):void 
		{	
			graphics.clear();
			graphics.lineStyle(3, 0xff0000 );
			_world.Step(0.025, 10, 10);
			
			
			for each (var wheelBody:b2Body in _wheelBodies )
			{
				graphics.drawCircle(
					wheelBody.GetPosition().x * scaleFactor,wheelBody.GetPosition().y * scaleFactor, (wheelBody.GetFixtureList().GetShape() as b2CircleShape).GetRadius() * scaleFactor
				);
			}
    
		
			//for (var i:int = 0; i < _wheelBodies.length; i++) 
			//{				
				//graphics.moveTo(_wheelBodies[ i ].GetPosition().x, _wheelBodies[ i ].GetPosition().y);			
				//graphics.lineTo( _wheelBodies[ i ].GetPosition().x, _wheelBodies[ i ].GetPosition().y);
				//graphics.drawCircle(_wheelBodies[ i ].GetPosition().x, _wheelBodies[ i ].GetPosition().y, _radius );
				//trace(_wheelBodies[ 0 ].GetPosition().x, _wheelBodies[ 0 ].GetPosition().y);				
			//}
					
			//trace( "box2d wrapper world ticking........" );
		}
	}

}