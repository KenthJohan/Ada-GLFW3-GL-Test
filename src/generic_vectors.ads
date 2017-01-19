with System;

generic
   type Index is range <>;
   type Element is private;
   with function "=" (Left, Right : Element) return Boolean is <>;
package Generic_Vectors is

   subtype Address is System.Address;

   type Element_Array is array (Integer range <>) of aliased Element;

   type Vector (Capacity : Natural) is record
      Data : Element_Array (1 .. Capacity) := (others => <>);
      Last : Natural := 0;
   end record;

   procedure Append (Container : in out Vector; New_Item : Element);
   function Data_Address (Container : Vector) return Address;
   function Data_Size (Container : Vector) return Natural;


end;
