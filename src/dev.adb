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
with OS_Systems;

with GL.Math;
with Maths;
with Meshes;
with Parse_Handler;
with Cameras;
with Inputs;
with GLFW3.Windows.Drops;

procedure Dev is

   Main_Window : GLFW3.Window := GLFW3.Null_Window;
   C : Cameras.Camera;



   procedure Get_Translation_Input (W : GLFW3.Window; T : in out GL.Math.Float_Vector4) is
      use GL.C;
      use type GL.C.GLfloat;
      use GLFW3.Windows.Keys;
      Amount : constant GLfloat := 0.1;
   begin
      T := (0.0, 0.0, 0.0, 0.0);
      if Get_Key (W, Key_W) = Key_Action_Press then
         T (3) := T (3) + Amount;
      end if;
      if Get_Key (W, Key_S) = Key_Action_Press then
         T (3) := T (3) - Amount;
      end if;
      if Get_Key (W, Key_Space) = Key_Action_Press then
         T (2) := T (2) - Amount;
      end if;
      if Get_Key (W, Key_Left_Control) = Key_Action_Press then
         T (2) := T (2) + Amount;
      end if;
      if Get_Key (W, Key_A) = Key_Action_Press then
         T (1) := T (1) + Amount;
      end if;
      if Get_Key (W, Key_D) = Key_Action_Press then
         T (1) := T (1) - Amount;
      end if;
   end;

   procedure Get_Rotation_Input (W : GLFW3.Window; Q : in out GL.Math.Float_Vector4) is
      use GL.Math;
      use type GL.Math.GLfloat;
      use GLFW3.Windows.Keys;
      use Maths;
      Amount : constant GLfloat := 0.01;
      Pith_Axis : constant Float_Vector3 := (1.0, 0.0, 0.0);
      Yaw_Axis : constant Float_Vector3 := (0.0, 1.0, 0.0);
      Roll_Axis : constant Float_Vector3 := (0.0, 0.0, 1.0);
      Pith_Up : constant Float_Vector4 := Convert_Axis_Angle_To_Quaternion (Pith_Axis, Amount);
      Pith_Down : constant Float_Vector4 := Convert_Axis_Angle_To_Quaternion (Pith_Axis, -Amount);
      Yaw_Left : constant Float_Vector4 := Convert_Axis_Angle_To_Quaternion (Yaw_Axis, Amount);
      Yaw_Right : constant Float_Vector4 := Convert_Axis_Angle_To_Quaternion (Yaw_Axis, -Amount);
      Roll_Left : constant Float_Vector4 := Convert_Axis_Angle_To_Quaternion (Roll_Axis, Amount);
      Roll_Right : constant Float_Vector4 := Convert_Axis_Angle_To_Quaternion (Roll_Axis, -Amount);
   begin
      if Get_Key (W, Key_Up) = Key_Action_Press then
         Q := Q * Pith_Up;
      end if;
      if Get_Key (W, Key_Down) = Key_Action_Press then
         Q := Q * Pith_Down;
      end if;
      if Get_Key (W, Key_Left) = Key_Action_Press then
         Q := Q * Yaw_Left;
      end if;
      if Get_Key (W, Key_Right) = Key_Action_Press then
         Q := Q * Yaw_Right;
      end if;
      if Get_Key (W, Key_Q) = Key_Action_Press then
         Q := Q * Roll_Left;
      end if;
      if Get_Key (W, Key_E) = Key_Action_Press then
         Q := Q * Roll_Right;
      end if;
      if Get_Key (W, Key_O) = Key_Action_Press then
         C.FOV := C.FOV + 0.001;
      end if;
      if Get_Key (W, Key_L) = Key_Action_Press then
         C.FOV := C.FOV - 0.001;
      end if;
      Normalize (Q);
   end;




   function Setup_Shader (Name : String; Stage : GL.Shaders.Shader_Stage) return GL.Shaders.Shader is
      use GL.Shaders;
      use GL.Shaders.Files;
      use Ada.Text_IO;
      Item : constant Shader := Create_Empty (Stage);
   begin
      Set_Source_File (Item, Name);
      Compile_Checked (Item);
      return Item;
   exception
      when Compile_Error =>
         Put_Line ("Compile_Error");
         Put_Line (Get_Compile_Log (Item));
         return Item;
   end;

   function Setup_Program return GL.Programs.Program is
      use GL.Shaders;
      use GL.Programs;
      use GL.Programs.Shaders;
      use GL.Shaders.Files;
      use Ada.Text_IO;
      Item : constant Program := GL.Programs.Create_Empty;
   begin
      GL.Programs.Shaders.Attach (Item, Setup_Shader ("test.glvs", Vertex_Stage));
      GL.Programs.Shaders.Attach (Item, Setup_Shader ("test.glfs", Fragment_Stage));
      GL.Programs.Link_Checked (Item);
      return Item;
   exception
      when Link_Error =>
         Put_Line ("Link_Error");
         Put_Line (GL.Programs.Get_Link_Log (Item));
         return Item;
   end;


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
      M : Meshes.Mesh_Vectors.Vector := Meshes.Mesh_Vectors.To_Vector (3);
   begin
      Cameras.Init (C);
      Set_Current (P);
      Make_Grid_Lines (M (1));
      Make_Triangle (M (2));
      Make_Sin (M (3));

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
         Update (M);
         Update (Parse_Handler.Mesh_List);
         Draw (M);
         Draw (Parse_Handler.Mesh_List);

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
   task Info_Task is
      entry Start (Arg : GLFW3.Window);
      entry Stop;
   end;

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
      GL.C.Initializations.Initialize (OpenGL_Loader_Test'Unrestricted_Access);
      GLFW3.Windows.Drops.Set_Drop_Callback (Main_Window, Parse_Handler.drop_callback'Unrestricted_Access);
      Render_Loop (Main_Window);
      Destroy_Window (Main_Window);
      Parse_Handler.Parse_Task.Quit;
      Info_Task.Stop;
   end;

   task body Info_Task is
      use GLFW3;
      use Maths;
      use Ada.Text_IO;
   begin
      loop
         select
            accept Stop;
            exit;
         else
            delay 0.1;
            Put_Line ("Info_Task");
            OS_Systems.Clear_Screen;
            Put (C.Projection_Matrix);
            New_Line;
            Put (C.Rotation_Matrix);
            New_Line;
            Put (C.Translation_Matrix);
            New_Line;
            Put (C.Result_Matrix);
            New_Line;
            Inputs.Put_State (Main_Window, Inputs.Config_1);
         end select;
      end loop;
      Put_Line ("Info_Task complete");
   end;


begin
   GLFW3.Initialize;
   Render_Task.Start;
end;
