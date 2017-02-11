with Ada.Strings.Fixed;

with System.Address_Image;

with GLFW3.Extensions;

with Simple_Debug_Systems;

package body Applications.OpenGL_Loader is

   function Loader (Name : String) return Address is
      use Ada.Strings.Fixed;
      use GLFW3.Extensions;
      Return_Address : constant Address := To_Address (Get_Procedure_Address (Name));
      String_Address : constant String := Address_Image (Return_Address);
   begin
      Simple_Debug_Systems.Enqueue (1, Head (Name, 30) & String_Address);
      return Return_Address;
   end;


end;
