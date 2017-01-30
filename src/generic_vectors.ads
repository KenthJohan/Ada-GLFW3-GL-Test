with System;

generic
   type Element is private;
   with function "=" (Left, Right : Element) return Boolean is <>;
package Generic_Vectors is

   subtype Address is System.Address;

   type Count is new Natural;
   subtype Index is Count range 1 .. Count'Last;
   type Element_Array is array (Index range <>) of aliased Element;


   type Vector (Capacity : Count) is tagged private with
     Variable_Indexing => Get;

   type Accessor (Data: not null access Element) is private with Implicit_Dereference => Data;
   function Get (C : in out Vector; K : Index) return Accessor;

   procedure Append (Container : in out Vector);
   procedure Append (Container : in out Vector; New_Item : Element);

   function Data_Address (Container : Vector) return Address;
   function Data_Size (Container : Vector) return Natural;


   function First_Index (C : Vector) return Index;
   function First_Element (C : in out Vector) return Accessor;
   function First_Element (C : Vector) return Element;

   function Last_Index (C : Vector) return Index;
   function Last_Element (C : in out Vector) return Accessor;
   function Last_Element1 (C : Vector) return Element;

private

   type Vector (Capacity : Count) is tagged record
      Data : Element_Array (1 .. Capacity) := (others => <>);
      Last : Count := 0;
   end record;

   type Accessor (Data : not null access Element) is null record;

end;
