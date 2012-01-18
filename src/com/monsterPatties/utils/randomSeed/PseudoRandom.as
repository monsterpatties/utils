package com.monsterPatties.utils.randomSeed {
	
	/**
	 * Generates a pseudo random number
	 * @author Rafael Nepomuceno
	 */
	public class PseudoRandom {
		/// Random seed.
		private static var _seed:Number;
		/// Current random number sequence.
		private static var _rn:Number;
		/// Current random uint sequence.
		private static var _rnUint:uint;
		
		/**
		 * Initialize the PseudoRandom generator
		 * @param	seed - If NaN Math.random() will be use.
		 */
		public static function init ( seed:Number = NaN ):void {
			if ( isNaN( seed ) ) _seed = Math.random(); // random seed
			else _seed = Math.abs( seed ); // param seed
			
			// save the current random number for sequence
			_rn = _seed;
			_rnUint = int( _seed * 10 );
		}
		
		/**
		 * Resets the PseudoRandom seed
		 */
		public static function reset (  ):void {
			// throw an error if PseudoRandom is not initialized yet.
			if ( isNaN( _seed ) ) throw new Error( 'PseudoRandom::reset - call init first.' );	
			
			// set back the current random number sequence
			_rn = _seed;
			_rnUint = int( _seed * 10 );
		}
		
		
		
		
		
		/**
		 * Generate the next random number
		 * @return Next random number.
		 */
		public static function random (  ):Number {
			// throw an error if PseudoRandom is not initialized yet.
			if ( isNaN( _seed ) ) throw new Error( 'PseudoRandom::random - call init first.' );			
			
			// Generate next random number
			return _rn = ( _rn * 3 ) % 1;
		}
		/**
		 * Returns a random number within range.
		 * @param	min Minimum range
		 * @param	max Maximum range
		 * @return Random number
		 */
		public static function randomRange( min:Number, max:Number ):Number {
			// throw an error if PseudoRandom is not initialized yet.
			if ( isNaN( _seed ) ) throw new Error( 'PseudoRandom::randomRange - call init first.' );
			
			// swap values
            if ( min > max ) {
				var tmp:Number = max;
				max = min;
				min = tmp;
            }
			
            return random() * ( max - min + 1 ) + min;
        }
		
		
		
		
		
		/**
		 * Get the next random number
		 * @author Noel Billig (http://www.dncompute.com)
		 * @return
		 */
		public static function random2 (  ):Number {
			// throw an error if PseudoRandom is not initialized yet.
			if ( isNaN( _seed ) ) throw new Error( 'PseudoRandom::random2 - call init first.' );		
			
			_rn = ( _rn * 9301 + 49297 ) % 233280;
			return _rn / ( 233280.0 );
		}
		/**
		 * Returns a random number within range.
		 * @author Noel Billig (http://www.dncompute.com)
		 * @param	min Minimum range
		 * @param	max Maximum range
		 * @return Random number
		 */
		public static function randomRange2 ( min:Number, max:Number ):Number {
			// throw an error if PseudoRandom is not initialized yet.
			if ( isNaN( _seed ) ) throw new Error( 'PseudoRandom::randomRange2 - call init first.' );
			
			var dif:Number = max - min + 1;
			var num:Number = random2();
			return min + ( dif * num );
        }
		
		
		
		
		
		/**
		 * Rndm by Grant Skinner. Jan 15, 2008
		 * Visit www.gskinner.com/blog for documentation, updates and more free code.
		 *
		 * Incorporates implementation of the Park Miller (1988) "minimal standard" linear 
		 * congruential pseudo-random number generator by Michael Baczynski, www.polygonal.de.
		 * (seed * 16807) % 2147483647
		 * @return
		 */
		public static function random3 (  ):Number {
			// throw an error if PseudoRandom is not initialized yet.
			if ( isNaN( _seed ) ) throw new Error( 'PseudoRandom::random3 - call init first.' );
			
			return ( _rn = ( _rn * 16807 ) % 2147483647 ) / 0x7FFFFFFF + 0.000000000233;
		}
		/**
		 * Rndm by Grant Skinner. Jan 15, 2008
		 * Visit www.gskinner.com/blog for documentation, updates and more free code.
		 *
		 * Incorporates implementation of the Park Miller (1988) "minimal standard" linear 
		 * congruential pseudo-random number generator by Michael Baczynski, www.polygonal.de.
		 * (seed * 16807) % 2147483647
		 * @param	min Minimum range
		 * @param	max Maximum range
		 * @return Random number
		 */
		public static function randomRange3 ( min:Number, max:Number ):Number {
			// throw an error if PseudoRandom is not initialized yet.
			if ( isNaN( _seed ) ) throw new Error( 'PseudoRandom::randomRange3 - call init first.' );
			
			// swap values
            if ( min > max ) {
				var tmp:Number = max;
				max = min;
				min = tmp;
            }
			
            return random3() * ( max - min + 1 ) + min;
        }
		
		
		
		
		/**
		 * Generate the next random number
		 * @author Michael Baczynski, www.polygonal.de
		 * new-value = (old-value * 16807) mod (2^31 - 1)
		 */
		public static function nextUint (  ):uint {
			// throw an error if PseudoRandom is not initialized yet.
			if ( isNaN( _seed ) ) throw new Error( 'PseudoRandom::nextInt - call init first.' );		
			
			//integer version 1, for max int 2^46 - 1 or larger.
			return _rnUint = ( _rnUint * 16807 ) % 2147483647;
			
			/**
			 * integer version 2, for max int 2^31 - 1 (slowest)
			 */
			//var test:int = 16807 * (seed % 127773 >> 0) - 2836 * (seed / 127773 >> 0);
			//return seed = (test > 0 ? test : test + 2147483647);
			
			/**
			 * david g. carta's optimisation is 15% slower than integer version 1
			 */
			//var hi:uint = 16807 * (seed >> 16);
			//var lo:uint = 16807 * (seed & 0xFFFF) + ((hi & 0x7FFF) << 16) + (hi >> 15);
			//return seed = (lo > 0x7FFFFFFF ? lo - 0x7FFFFFFF : lo);
		}
		/**
		 * Returns a random number within range.
		 * @author Michael Baczynski, www.polygonal.de
		 * @param	min Minimum range
		 * @param	max Maximum range
		 * @return Random number
		 */
		public static function randomRangeUint ( min:Number, max:Number ):Number {
			// throw an error if PseudoRandom is not initialized yet.
			if ( isNaN( _seed ) ) throw new Error( 'PseudoRandom::randomRangeUint - call init first.' );
			
			min -= .4999;
			max += .4999;
			return Math.round( min + ( ( max - min ) * ( nextUint() / 2147483647 ) ) );
        }
		
		
		public function PseudoRandom ( s:SingletonEnforcer ) { }
	}

}
class SingletonEnforcer {  }