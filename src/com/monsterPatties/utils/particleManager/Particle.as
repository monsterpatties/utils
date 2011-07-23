package com.monsterPatties.utils.particleManager 
{
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author ...
	 */
	public class Particle 
	{
		/*------------------------------------------------------Constant--------------------------------------------------*/
		
		/*------------------------------------------------------Properties--------------------------------------------------*/
		//possible upgrade
		// lifeSpand, speed, damage
		
		private var _speed:Number = 0;
		private var _dx:Number = 0;
		private var _dy:Number = 0;
		private var _gravity:Number = 0.5;		
		private var _delayDuration:Number = 500;		
		private var _radius:Number = 4;
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _decay:Number = 0.99;
		
		private var _timeStamp:Number = 0;
		private var _timeDelay:Number = 0;
		private const LIFE_DURATION:Number = 5000;
		private var _killMe:Boolean;
		
		//tag com/player
		private var _com:Boolean;
		public var damage:Number;
		
		public var width:Number;
		public var height:Number;
		/*------------------------------------------------------Constructor--------------------------------------------------*/
		
		public function Particle() 
		{
			initData();
		}
		
		/*------------------------------------------------------Methods--------------------------------------------------*/
		private function initData():void 
		{
			_dx = _speed;
			_dy = _speed;
			
			_timeStamp = getTimer();
		}			
		
		public function checkLifeCycle():Boolean 
		{			
			if ( _timeStamp > 0 ) {
				_timeDelay = getTimer() - _timeStamp;
				
				if ( _timeDelay > LIFE_DURATION ) {
					_killMe = true;
					//trace( "particles: kill me" );
				}
			}
			
			return _killMe;
		}
		
		/*------------------------------------------------------Getters--------------------------------------------------*/
		public function get speed():Number { return _speed; }
		public function get dx():Number { return _dx; }
		public function get dy():Number { return _dy; }
		public function get gravity():Number { return _gravity; }
		public function get delayDuration():Number { return _delayDuration; }
		public function get radius():Number { return _radius; }
		public function get x():Number { return _x; }
		public function get y():Number { return _y; }
		public function get decay():Number { return _decay; }
		public function get com():Boolean { return _com; }
		/*------------------------------------------------------Setters--------------------------------------------------*/
		public function set speed(value:Number):void 
		{
			_speed = value;
		}		
		
		public function set dx(value:Number):void 
		{
			_dx = value;
		}	
		
		public function set dy(value:Number):void 
		{
			_dy = value;
		}		
		
		public function set gravity(value:Number):void 
		{
			_gravity = value;
		}		
		
		
		public function set delayDuration(value:Number):void 
		{
			_delayDuration = value;
		}	
		
		public function set radius(value:Number):void 
		{
			_radius = value;
		}	
		
		public function set x(value:Number):void 
		{
			_x = value;
		}		
		public function set y(value:Number):void 
		{
			_y = value;
		}	
		
		public function set decay(value:Number):void 
		{
			_decay = value;
		}				
		
		public function set com(value:Boolean):void 
		{
			_com = value;
		}
		/*------------------------------------------------------EventHandlers--------------------------------------------------*/		
	}

}