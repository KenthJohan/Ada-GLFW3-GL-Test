package body Chunks is








   procedure Test (Item : in out Handler) is
   begin
      Start_Append (Item);
      for I in 1..10 loop
         Item.V.Append;
      end loop;
      Stop_Append (Item);
   end Test;

end Chunks;
