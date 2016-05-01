with GL.C.Initializations;
with GL.Programs;
with GL.Shaders;
with GL.Shaders.Files;
with GL.Uniforms;

with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;

with Ada.Text_IO;

with OpenGL_Loader_Test;

with Cameras;

with OS_Systems;


procedure Draw is


   function Setup_Program return GL.Programs.Program is
      use GL.Shaders;
      use GL.Programs;
      use GL.Shaders.Files;
      use Ada.Text_IO;
      Vertex_Shader : constant Shader := Create_Empty (Vertex_Stage);
      Fragment_Shader : constant Shader := Create_Empty (Fragment_Stage);
      My_Program : constant Program := Create_Empty;
   begin
      Set_Source_File (Vertex_Shader, "test.glvs");
      Set_Source_File (Fragment_Shader, "test.glfs");
      Compile (Vertex_Shader);
      Compile (Fragment_Shader);

      if Compile_Succeess (Vertex_Shader) then
         Attach (My_Program, Identity (Vertex_Shader));
         Put_Line ("Compile_Succeess (Vertex_Shader)");
      else
         Put_Line (Get_Compile_Log (Vertex_Shader));
      end if;

      if Compile_Succeess (Fragment_Shader) then
         Attach (My_Program, Identity (Fragment_Shader));
         Put_Line ("Compile_Succeess (Fragment_Shader)");
      else
         Put_Line (Get_Compile_Log (Fragment_Shader));
      end if;

      Link (My_Program);

      if Link_Succeess (My_Program) then
         Put_Line ("Link_Succeess");
      else
         Put_Line (Get_Compile_Log (My_Program));
      end if;

      return My_Program;
   end;



   procedure Render_Loop (W : GLFW3.Window; L : GL.Uniforms.Location; C : in out Cameras.Camera) is
      use GLFW3;
      use GLFW3.Windows;
      use GLFW3.Windows.Keys;
      use OS_Systems;
      use Ada.Text_IO;
      use Cameras;
      use GL.Uniforms;
   begin
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

         Modify (L, Build (C)'Address);

         pragma Warnings (Off);
         exit when Window_Should_Close (W) = 1;
         pragma Warnings (On);
      end loop;
   end;

   function Setup_Window return GLFW3.Window is
      use GLFW3;
      use GLFW3.Windows;
      use GL.C.Initializations;
      W : constant Window := Create_Window_Ada (400, 400, "Hello");
   begin
      Make_Context_Current (W);
      Initialize (OpenGL_Loader_Test'Unrestricted_Access);
      return W;
   end;


begin

   GLFW3.Initialize;

   declare
      use GLFW3;
      use GLFW3.Windows;
      use Ada.Text_IO;
      use GL.Programs;
      use GL.Uniforms;
      use Cameras;
      W : constant Window := Setup_Window;
      P : constant Program := Setup_Program;
      L : constant Location := Get (Identity (P), "transform");
      C : Camera := Create_RC;
   begin
      --Put (L);
      delay 4.0;
      Perspective_RC (C, 90.0, 3.0/4.0, 5.0, 80.0);
      Render_Loop (W, L, C);
      Destroy_Window (W);
   end;


end;
