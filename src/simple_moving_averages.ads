with Ada.Real_Time;

package Simple_Moving_Averages is

   use Ada.Real_Time;

   type SMA is record
      Previous : Time;
      S : Time_Span := Nanoseconds (0);
      N : Natural := 0;
   end record;

   procedure Update (Item : in out SMA);
   procedure Update (Item : in out SMA; Max : Natural);

   function Diff (Item : SMA) return Time_Span;

end;
