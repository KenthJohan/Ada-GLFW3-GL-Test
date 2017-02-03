with System;


generic
   type Element is private;
package Generic_Vectors is

   subtype Address is System.Address;

   type Base_Index is new Integer;
   subtype Count is Base_Index range 0 .. Base_Index'Last;
   subtype Index is Base_Index range 1 .. Base_Index'Last;
   type Element_Array is array (Index range <>) of aliased Element;


   type Vector (Capacity : Count) is tagged private with
     Variable_Indexing => Get;

   type Accessor (Generic_Vectors_Element : not null access Element) is private with Implicit_Dereference => Generic_Vectors_Element;
   function Get (C : in out Vector; K : Index) return Accessor;

   procedure Append (Container : in out Vector);
   procedure Append (Container : in out Vector; New_Item : Element);

   function Data_Address (Container : Vector) return Address;
   function Data_Size (Container : Vector) return Natural;


   No_Index : constant Base_Index := Index'Pred (Index'First);
   function Exists (Container : Vector; K : Base_Index) return Boolean;

   function First_Index (C : Vector) return Base_Index;
   function First_Element (C : in out Vector) return Accessor;
   function First_Element1 (C : Vector) return Element;

   function Last_Index (C : Vector) return Base_Index;
   function Last_Element (C : in out Vector) return Accessor;
   function Last_Element1 (C : Vector) return Element;

private

   type Vector (Capacity : Count) is tagged record
      Data : Element_Array (1 .. Capacity) := (others => <>);
      Last : Base_Index := 0;
   end record;

   type Accessor (Generic_Vectors_Element : not null access Element) is null record;

end;
