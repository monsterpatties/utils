package com.monsterPatties.utils.deepCopy
{
    import flash.utils.ByteArray;

    /**
     * 
     * All static class which defines a single static method which 
     * provides a mechanism for creating a Deep Copy of a reference 
     * object to a new memory address
     * 
     * @see flash.utils.ByteArray;
     * 
     */
    public final class DeepCopy
    {
        /**
         * 
         * Creates a deep copy (clone) of a reference object to a new 
         * memory address
         *
         * @param   reference object in which to clone
         * @return  a clone of the original reference object
         * 
         */
        public static function clone(reference:*) : Object
        {
            var clone:ByteArray = new ByteArray();
            clone.writeObject( reference );
            clone.position = 0;

            return clone.readObject();
        }
    }
}