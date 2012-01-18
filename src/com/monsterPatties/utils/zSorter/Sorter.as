package com.monsterPatties.utils.zSorter
{
    import flash.geom.Rectangle;   
    import flash.display.DisplayObject; 
    import flash.display.DisplayObjectContainer;   
 
    /**
     * @author Henry Schmieder
     * @version  0.2 20.11.2008
     *
     */
    public class Sorter
    {
        public static function sortChildren( d: DisplayObjectContainer, sortPropertyName: String ): void
        {
            var children:Array = [];
            var a: *;
            var b: *;
            var o: int;
            var i: int;
            var curChild:*;
           
            for ( i = d.numChildren; i> 0 ; i-- )
            {
                try {
                   curChild = d.getChildAt( i );
                }catch( e:Error )
                {
                }
                if ( Object( curChild ).hasOwnProperty( sortPropertyName ) ) {
					trace( "detect depth" );
                    children.push( new ChildVO( curChild, i ) );
                }   
            }
           
            var max: int = children.length - 1;
   
            for ( i = max; i> 0 ; i--)
            {
                var bFlipped: Boolean = false;
       
                for ( o = 0; o <i ; o++)
                {
                    a = d.getChildAt( ChildVO( children[ o ] ).index )[ sortPropertyName ];
                    b = d.getChildAt(ChildVO( children[ o + 1 ] ).index )[ sortPropertyName ];
                }
               
                if ( a> b ) {
                    d.swapChildrenAt( o, o + 1 );
                    bFlipped = true;
                }
            }
            if ( !bFlipped ) return;
           
        }
 
       
    }
}
 
class ChildVO
{
    public var index:int;
    public var reference:*;
   
    public function ChildVO( reference:*, index:int )
    {
        this.reference = reference;
        this.index = index; 
    }
}