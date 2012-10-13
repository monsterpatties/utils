package com.monsterPatties.components 
{
	import idv.cjcat.stardust.common.actions.Age;
	import idv.cjcat.stardust.common.actions.DeathLife;
	import idv.cjcat.stardust.common.actions.ScaleCurve;
	import idv.cjcat.stardust.common.clocks.Clock;
	import idv.cjcat.stardust.common.initializers.Life;
	import idv.cjcat.stardust.common.math.UniformRandom;
	import idv.cjcat.stardust.twoD.actions.Accelerate;
	import idv.cjcat.stardust.twoD.actions.Move;
	import idv.cjcat.stardust.twoD.emitters.Emitter2D;
	import idv.cjcat.stardust.twoD.initializers.DisplayObjectClass;
	import idv.cjcat.stardust.twoD.initializers.Position;
	import idv.cjcat.stardust.twoD.initializers.Velocity;
	import idv.cjcat.stardust.twoD.zones.LazySectorZone;
	import idv.cjcat.stardust.twoD.zones.SinglePoint;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DustEmitter extends Emitter2D {	
		
		public var point:SinglePoint;		
		
		public function DustEmitter(clock:Clock) {
			super(clock);
			
			point = new SinglePoint();
			
			//initializers			
			addInitializer(new DisplayObjectClass( Dust ));			
			addInitializer(new Position(point));
			//addInitializer(new Velocity(new LazySectorZone(0.00001, 0)));			
			//addInitializer(new Velocity(new LazySectorZone(0, 0.005)));
			addInitializer(new Velocity(new LazySectorZone(0.5, 0.5)));
			addInitializer(new Life(new UniformRandom(50, 5)));		
			
			
			
			//actions
			addAction(new Age());
			addAction(new DeathLife());
			addAction(new Accelerate(0.025));			
			//addAction(new Accelerate(0.0000001));
			addAction(new Move( 2 ));
			addAction(new ScaleCurve(3, 7));
			//addAction(new ScaleCurve(15, 15));
			
			//var gravity:Gravity = new Gravity();
			//gravity.addField(new UniformField(0, 0.1  ));
			//addAction(gravity);						
			//addAction(new Oriented());
			
			
		}
		
	}

}