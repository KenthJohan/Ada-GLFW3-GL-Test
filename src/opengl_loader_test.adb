with Ada.Text_IO;
with Ada.Strings.Fixed;
with System.Address_Image;
with GLFW3.Extensions;

function OpenGL_Loader_Test (Name : String) return Address is
   use Ada.Text_IO;
   use Ada.Strings.Fixed;
   use GLFW3.Extensions;
   Return_Address : constant Address := To_Address (Get_Procedure_Address (Name));
   String_Address : constant String := Address_Image (Return_Address);
begin
   Put (Head (Name, 30));
   Put (String_Address);
   New_Line;
   return Return_Address;
end;
