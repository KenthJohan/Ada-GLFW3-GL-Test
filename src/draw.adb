with GL.C.Initializations;
with GL.Shaders;
with GL.Shaders.Programs;
with GL.Shaders.Programs.Files;

with GLFW3;
with GLFW3.Windows;
with GLFW3.Extensions;

with System;
with System.Address_Image;

with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Exceptions;

procedure Draw is

   procedure Initialize_OpenGL is

      use System;
      use GL.C.Initializations;

      function Loader (Name : String) return Address is
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

   begin
      Initialize (Loader'Unrestricted_Access);
   end;


   W : GLFW3.Window;


begin

   declare
      use GLFW3.Windows;
   begin
      GLFW3.Initialize;
      W := Create_Window (400, 400, "Hello");
      Make_Context_Current (W);
      Initialize_OpenGL;

      declare
         use Ada.Text_IO;
         use Ada.Exceptions;
         use GL.Shaders;
         use GL.Shaders.Programs;
         use GL.Shaders.Programs.Files;
         P : constant Program := Create;
      begin
         Attach_Checked_Source (P, Vertex_Type, "test.glfs");
      exception
         when Error : others =>
            Put_Line ("Exception:.");
            Put_Line (Exception_Information (Error));
            --Put_Line (String (Get_Compile_Log (S)));
      end;

   end;





   declare
      use GLFW3;
      use GLFW3.Windows;
   begin
      loop
         Poll_Events;
         pragma Warnings (Off);
         exit when Window_Should_Close (W) = 1;
         pragma Warnings (On);
      end loop;
      Destroy_Window (W);
   end;


end;
