package body Generic_Vectors is

   procedure Append (Container : in out Vector) is
   begin
      Container.Last := Container.Last + 1;
   end;

   procedure Append (Container : in out Vector; New_Item : Element) is
   begin
      Container.Last := Container.Last + 1;
      Container.Data (Container.Last) := New_Item;
   end;

   function Data_Address (Container : Vector) return Address is
   begin
      return Container.Data'Address;
   end;

   function Data_Size (Container : Vector) return Natural is
   begin
      return Container.Data'Size;
   end;

   function Get (C : in out Vector; K : Index) return Accessor is
   begin
      return Accessor'(Data => C.Data (K)'Access);
   end;

   function First_Element (C : in out Vector) return Accessor is
   begin
      return Accessor'(Data => C.Data (C.Data'First)'Access);
   end;

   function First_Element1 (C : Vector) return Element is
   begin
      return C.Data (C.Data'First);
   end;

   function First_Index (C : Vector) return Index is
   begin
      return C.Data'First;
   end;

   function Last_Element (C : in out Vector) return Accessor is
   begin
      return Accessor'(Data => C.Data (C.Last)'Access);
   end;

   function Last_Element1 (C : Vector) return Element is
   begin
      return C.Data (C.Last);
   end;

   function Last_Index (C : Vector) return Index is
   begin
      return C.Last;
   end;

end;
