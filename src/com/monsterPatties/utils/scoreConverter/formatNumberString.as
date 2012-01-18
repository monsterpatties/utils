package com.monsterPatties.utils.scoreConverter {

    /**
     * ...
     * @author Mark Paolo Cabrera
     */
    public function formatNumberString ( currentcy:Number ):String {
        var numberString:String = '';
        var remainderNum:Number;
        var divider:Number = 1000;

        while ( currentcy > 0 ) {
            remainderNum = currentcy % divider;
            currentcy = Math.floor( currentcy / divider );

            numberString = remainderNum + numberString;

            if ( currentcy > 0 ) {
                if ( remainderNum < 10 ) {
                    numberString = '00' + numberString;
                } else if ( remainderNum < 100 ) {
                    numberString = '0' + numberString;
                }

                if ( currentcy > 0 ) {
                    numberString = ',' + numberString;
                }
            }

        }

        if ( numberString == '' ) {
            numberString = '0';
        }

        return numberString;
    }

}