package body Simple_Moving_Averages is

   procedure Update (Item : in out SMA) is
      T : constant Time := Clock;
   begin
      Item.S := Item.S + T - Item.Previous;
      Item.Previous := T;
      Item.N := Natural'Succ (Item.N);
   end;

   procedure Update (Item : in out SMA; Max : Natural) is
   begin
      if Item.N >= Max then
         Item.S := Nanoseconds (0);
         Item.N := 0;
      end if;
      Update (Item);
   end;

   function Diff (Item : SMA) return Duration is
   begin
      if Item.N = 0 then
         return To_Duration (Nanoseconds (0));
      else
         return To_Duration (Item.S / Item.N);
      end if;
   end;

end;
