with GL.C.Initializations;
with GL.Programs_Overhaul;
with GL.Programs.Uniforms;

with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;

with Ada.Text_IO;
with Ada.Exceptions;

with OpenGL_Loader_Test;

with Cameras;

with OS_Systems;

procedure Draw is

   W : GLFW3.Window;

   procedure Render (Transformation_Location : GL.Programs.Uniforms.Location) is
   begin
      null;
   end;


begin

   declare
      use GLFW3.Windows;
      use GL.C.Initializations;
   begin
      GLFW3.Initialize;
      W := Create_Window_Ada (400, 400, "Hello");
      Make_Context_Current (W);
      Initialize (OpenGL_Loader_Test'Unrestricted_Access);

      declare
         use Ada.Text_IO;
         use Ada.Exceptions;
         use GL.Programs_Overhaul;
         P : constant Program := Create_Empty;
      begin
         Attach (P, "test.glfs");
      exception
         when Error : others =>
            Put_Line ("Exception others:");
            Put_Line (Exception_Information (Error));
            --Put_Line (String (Get_Compile_Log (S)));
      end;
   end;


   declare
      use GLFW3;
      use GLFW3.Windows;
      use GLFW3.Windows.Keys;
      use Ada.Text_IO;
      use Cameras;
      use OS_Systems;
      use GL.Programs.Uniforms;
      --L : Location := Get ("transformation");
      C : Camera := Create_RC;
   begin

      Perspective_RC (C, 90.0, 3.0/4.0, 5.0, 80.0);

      loop
         Poll_Events;

         delay 0.1;
         Clear_Screen;

         if Get_Key (W, Key_Up) = Key_Action_Press then
            Put_Line ("Key_Up");
            Rotate_RC (C, Convert ((1.0, 0.0, 0.0), Degree (5.0)));
         else
            New_Line;
         end if;

         if Get_Key (W, Key_Down) = Key_Action_Press then
            Put_Line ("Key_Down");
            Rotate_RC (C, Convert ((1.0, 0.0, 0.0), Degree (-5.0)));
         else
            New_Line;
         end if;

         if Get_Key (W, Key_Space) = Key_Action_Press then
            Put_Line ("Key_Space");
            Translate_RC (C, (0.0, 0.0, 0.1));
         else
            New_Line;
         end if;

         if Get_Key (W, Key_Left_Control) = Key_Action_Press then
            Put_Line ("Key_Left_Control");
            Translate_RC (C, (0.0, 0.0, -0.1));
         else
            New_Line;
         end if;

         Put (C);

         pragma Warnings (Off);
         exit when Window_Should_Close (W) = 1;
         pragma Warnings (On);

      end loop;
      Destroy_Window (W);
   end;


end;
