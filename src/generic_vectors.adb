package body Generic_Vectors is

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


end;
