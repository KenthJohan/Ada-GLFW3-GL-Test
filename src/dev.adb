with GL.C.Initializations;
with GL.Programs;
with GL.Programs.Shaders;
with GL.Shaders;
with GL.Shaders.Files;
with GL.Drawings;
with GL.Programs.Uniforms;
with GL.Uniforms;




with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;

with Ada.Text_IO;

with OpenGL_Loader_Test;
--with OS_Systems;

with GL.Math;

with Meshes;
with Parse_Handler;
with Cameras;
--with Inputs;
with GLFW3.Windows.Drops;


procedure Dev is

   Main_Window : GLFW3.Window := GLFW3.Null_Window;
   C : Cameras.Camera;




   procedure Render_Loop (W : GLFW3.Window) is
      use GLFW3;
      use GLFW3.Windows;
      use GLFW3.Windows.Keys;
      use GL.Drawings;
      use GL.Uniforms;
      use Meshes;
      use GL.Programs.Uniforms;
      use GL.Programs;
      use GL.C;
      use GL.Math;
      P : constant Program := Setup_Program;
      Transform_Location : constant GL.Uniforms.Location := Get (P, "transform");
      Time_Location : constant GL.Uniforms.Location := Get (P, "u_time");
      M : Meshes.Mesh;
   begin
      Cameras.Init (C);
      Set_Current (P);



      loop
         GLFW3.Poll_Events;
         GL.Drawings.Clear (Color_Plane);
         GL.Drawings.Clear (Depth_Plane);

         Get_Rotation_Input (W, C.Rotation);
         Get_Translation_Input (W, C.Translation_Velocity);
         Cameras.Update (C);

         GL.Uniforms.Modify_Matrix_4f (Transform_Location, C.Result_Matrix'Address);

         GL.Uniforms.Modify_1f (Time_Location, 0.0);
         --GL.Uniforms.Modify_1f (Time_Location, GL.C.GLfloat (GLFW3.Clock));






         GLFW3.Windows.Swap_Buffers (W);

         delay 0.01;

         pragma Warnings (Off);
         exit when GLFW3.Windows.Window_Should_Close (W) = 1;
         pragma Warnings (On);
      end loop;
   end;


   task Render_Task is
      entry Start;
   end;
--     task Info_Task is
--        entry Start;
--        pragma Unreferenced (Start);
--        entry Stop;
--        pragma Unreferenced (Stop);
--     end;

   task body Render_Task is
      use GLFW3;
      use GLFW3.Windows;
      use GLFW3.Windows.Keys;
      use GL.Drawings;
   begin
      accept Start;
      Main_Window := Create_Window_Ada (1024, 1024, "Hello123##");
      Viewport (0, 0, 1024, 1024);
      Make_Context_Current (Main_Window);
      Set_Key_Callback_Procedure (Main_Window, Key_Callback'Unrestricted_Access);
      GL.C.Initializations.Initialize (OpenGL_Loader_Test'Unrestricted_Access);
      GLFW3.Windows.Drops.Set_Drop_Callback (Main_Window, Parse_Handler.drop_callback'Unrestricted_Access);

      --Info_Task.Start;
      Render_Loop (Main_Window);
      Parse_Handler.Parse_Task.Quit;
      Destroy_Window (Main_Window);

      --Info_Task.Stop;
   end;

--     task body Info_Task is
--        use GLFW3;
--        use Maths;
--        use Ada.Text_IO;
--     begin
--        accept Start;
--        loop
--           select
--              accept Stop;
--              exit;
--           else
--              delay 0.1;
--              Put_Line ("Info_Task");
--              OS_Systems.Clear_Screen;
--              Put (C.Projection_Matrix);
--              New_Line;
--              Put (C.Rotation_Matrix);
--              New_Line;
--              Put (C.Translation_Matrix);
--              New_Line;
--              Put (C.Result_Matrix);
--              New_Line;
--              Inputs.Put_State (Main_Window, Inputs.Config_1);
--           end select;
--        end loop;
--        Put_Line ("Info_Task complete");
--     end;


begin
   GLFW3.Initialize;
   Render_Task.Start;
end;
