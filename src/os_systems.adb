with Interfaces.C;

package body OS_Systems is

   use Interfaces.C;

   function System (Arg : char_array) return int with Import, Convention => C, External_Name => "system";

   procedure System (Arg : String) is
      R : int;
   begin
      R := System (To_C (Arg));
      if R /= 0 then
         raise Program_Error with "system failure. Ret_Val: " & R'Img;
      end if;
   end;


   procedure Clear_Screen is
   begin
      System ("cls");
   end;

end;
