package com.surnia.socialStar.utils.currencyConverter{
	
	/**
	 * Contains functions to convert numbers to appropriate 
	 * string currency or values for dispalay.
	 * 
	 * @author hedrick david
	 * 
	 */	
	
	public class CurrencyConverter{
		public function CurrencyConverter(){
			
		}
		
		/**
		 * 
		 * Converts a given value to a desired string currency output.
		 * 
		 * @param amount - the amount to be converted
		 * @param prefix - the prefix to be used. Can be currency or name.
		 * @return String - the string result for display to a textField, etc.
		 * 
		 */		
		
		public static function convertCurrency (amount:Number, prefix:String = "$"):String {
			var prefixName:String = prefix
			var convertedAmount:String;
			if (amount <1000){
				convertedAmount = prefixName + amount;
			} else if (amount <1000000){
				convertedAmount = prefixName+ Math.round(amount / 1000) + " K";
			} else if (amount <1000000000){
				convertedAmount = prefixName+ Math.round(amount / 1000000) + " M";
			} else if (amount <1000000000000){
				convertedAmount = prefixName + Math.round(amount / 1000000000) + " B";
			} else convertedAmount = prefixName+ Math.round(amount / 1000000000000) + " T";
			return convertedAmount;
		}
		
		/**
		 * 
		 * Convert the amount given to a numeric value. Ex. 12345 ==> 12,345
		 * 
		 * @param amount - the value to be converted to a numeric number
		 * @return String - the converted output amountin string.
		 * 
		 */
		
		public static function numericAmount(amount:Number):String{
			var convertedAmount:String = String(amount);
			var conctArray:Array  = [];
			var adjustedString:String = "";
			var ctr:int = 1;
			var intCtr:int = 1;
			var genCtr:int = 1;
			if (convertedAmount.length > 3){
				for (var x:int = convertedAmount.length; x>=1; x--){
					
					var amt:Number = genCtr % 3;
					intCtr++;
					genCtr++;
					if (x == 1){
						conctArray[ctr] = convertedAmount.slice(x-1, intCtr);
					} else if (amt == 0 && x != 0){
						conctArray[ctr] = convertedAmount.slice(x-1, x+2);
						ctr++;
						intCtr = 0;
					} 
					
				}
				ctr = conctArray.length - 1;
				for (x = conctArray.length-1; x>=1; x--){
					if (x != 1){
						adjustedString += conctArray[ctr] + ",";
						ctr--;
					} else {
						adjustedString += conctArray[ctr];
					}
				}
				return adjustedString;
			} else {
				return convertedAmount;
			}
		}
	}
}