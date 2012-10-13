package com.monsterPatties.components{
	import idv.cjcat.stardust.common.actions.Age;
	import idv.cjcat.stardust.common.actions.DeathLife;
	import idv.cjcat.stardust.common.actions.ScaleCurve;
	import idv.cjcat.stardust.common.clocks.Clock;
	import idv.cjcat.stardust.common.initializers.Life;
	import idv.cjcat.stardust.common.math.UniformRandom;
	import idv.cjcat.stardust.twoD.actions.Accelerate;
	import idv.cjcat.stardust.twoD.actions.Gravity;
	import idv.cjcat.stardust.twoD.actions.Move;
	import idv.cjcat.stardust.twoD.actions.Oriented;
	import idv.cjcat.stardust.twoD.emitters.Emitter2D;
	import idv.cjcat.stardust.twoD.fields.UniformField;
	import idv.cjcat.stardust.twoD.initializers.DisplayObjectClass;
	import idv.cjcat.stardust.twoD.initializers.Position;
	import idv.cjcat.stardust.twoD.initializers.Velocity;
	import idv.cjcat.stardust.twoD.zones.LazySectorZone;
	import idv.cjcat.stardust.twoD.zones.SinglePoint;
	
	public class SprinkleEmitter extends Emitter2D {
		
		public var point:SinglePoint;
		
		public function SprinkleEmitter(clock:Clock) {
			super(clock);
			
			//initializers
			point = new SinglePoint();
			addInitializer(new Position(point));
			addInitializer(new DisplayObjectClass(Sprinkle));
			addInitializer(new Velocity(new LazySectorZone(3, 1)));
			addInitializer(new Life(new UniformRandom(30, 5)));
			
			//actions
			var gravity:Gravity = new Gravity();
			gravity.addField(new UniformField(0, 0));
			addAction(gravity);
			addAction(new Age());
			addAction(new DeathLife(  ) );
			addAction(new Move( 2 ));
			addAction(new Oriented());
			addAction(new ScaleCurve(2, 7));		
			addAction(new Accelerate(0.025));
		}
		
	}
}