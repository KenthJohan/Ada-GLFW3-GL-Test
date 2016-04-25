with GL.C.Initializations;
with GL.Shaders;
with GL.Shaders.Programs;
with GL.Shaders.Programs.Files;

with GLFW3;
with GLFW3.Windows;

with Ada.Text_IO;
with Ada.Exceptions;

with OpenGL_Loader_Test;

procedure Draw is

   W : GLFW3.Window;

begin

   declare
      use GLFW3.Windows;
      use GL.C.Initializations;
   begin
      GLFW3.Initialize;
      W := Create_Window (400, 400, "Hello");
      W := Create_Window_Ada (400, 400, "Hello");
      Make_Context_Current (W);
      Initialize (OpenGL_Loader_Test'Unrestricted_Access);

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
