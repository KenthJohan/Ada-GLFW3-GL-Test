with Interfaces.C;

package body OS_Systems is

   procedure Clear_Screen is
      use Interfaces.C;
      function Sys (Arg : Char_Array) return Integer with Import, Convention => C, External_Name => "system";
      Ret_Val : Integer;
   begin
      Ret_Val := Sys (To_C ("cls"));
      if Ret_Val /= 0 then
         null;
         raise Program_Error with "system failure. Ret_Val: " & Ret_Val'Img;
      end if;
   end;

end;
