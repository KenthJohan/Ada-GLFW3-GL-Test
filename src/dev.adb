with GL.C.Initializations;
with GL.Programs;
with GL.Programs.Shaders;
with GL.Shaders;
with GL.Shaders.Files;
with GL.Buffers;
with GL.Drawings;
with GL.Programs.Uniforms;
with GL.C;
with GL.Uniforms;




with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;

with Ada.Text_IO;

with OpenGL_Loader_Test;
with OS_Systems;

with Generic_Matpack.Quaternions;

with GL.Math;

with Meshes;
with Cameras;

procedure Dev is

   C : Cameras.Camera;

   procedure Get_Translation_Input (W : GLFW3.Window; T : in out GL.Math.Vector_4) is
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

   procedure Get_Rotation_Input (W : GLFW3.Window; Q : in out GL.Math.Vector_4) is
      use GL.C;
      use GL.Math;
      use GLFW3.Windows.Keys;
      use type GLfloat;
      function Convert is new Generic_Matpack.Quaternions.Axis_Quaternion_Conversion_Function (Dimension_4, Dimension_3, GLfloat, Vector_4, Vector_3, 2.0, Elementary_Functions.Sin, Elementary_Functions.Cos);
      function "*" is new Generic_Matpack.Quaternions.Quaternion_Quaternion_Hamilton_Product (Dimension_4, GLfloat, Vector_4, 0.0);
      procedure Normalize is new Generic_Matpack.Normalize (Dimension, GLfloat, Vector, 0.0, 1.0, Elementary_Functions.Sqrt);
      Amount : constant GLfloat := 0.01;
      Pith_Axis : constant Vector_3 := (1.0, 0.0, 0.0);
      Yaw_Axis : constant Vector_3 := (0.0, 1.0, 0.0);
      Roll_Axis : constant Vector_3 := (0.0, 0.0, 1.0);
      Pith_Up : constant Vector_4 := Convert (Pith_Axis, Amount);
      Pith_Down : constant Vector_4 := Convert (Pith_Axis, -Amount);
      Yaw_Left : constant Vector_4 := Convert (Yaw_Axis, Amount);
      Yaw_Right : constant Vector_4 := Convert (Yaw_Axis, -Amount);
      Roll_Left : constant Vector_4 := Convert (Roll_Axis, Amount);
      Roll_Right : constant Vector_4 := Convert (Roll_Axis, -Amount);
   begin

      if Get_Key (W, Key_Up) = Key_Action_Press then
         --Ada.Text_IO.Put_Line ("Key_Up");
         Q := Q * Pith_Up;
      else
         null;
         --Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_Down) = Key_Action_Press then
         --Ada.Text_IO.Put_Line ("Key_Down");
         Q := Q * Pith_Down;
      else
         null;
         --Ada.Text_IO.Put_Line ("");
      end if;


      if Get_Key (W, Key_Left) = Key_Action_Press then
         --Ada.Text_IO.Put_Line ("Key_Left");
         Q := Q * Yaw_Left;
      else
         null;
         --Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_Right) = Key_Action_Press then
         --Ada.Text_IO.Put_Line ("Key_Right");
         Q := Q * Yaw_Right;
      else
         null;
         --Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_Q) = Key_Action_Press then
         --Ada.Text_IO.Put_Line ("Key_Q");
         Q := Q * Roll_Left;
      else
         null;
         --Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_E) = Key_Action_Press then
         --Ada.Text_IO.Put_Line ("Key_E");
         Q := Q * Roll_Right;
      else
         null;
         --Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_O) = Key_Action_Press then
         C.FOV := C.FOV + 0.001;
      end if;

      if Get_Key (W, Key_L) = Key_Action_Press then
         C.FOV := C.FOV - 0.001;
      end if;

      Cameras.Setup_Perspective (C.FOV, 3.0/4.0, 0.1, 80.0, C);
      Normalize (Q);

   end;






   function Setup_Window return GLFW3.Window is
      use GLFW3;
      use GLFW3.Windows;
      use GL.C.Initializations;
      use GL.Drawings;
      W : constant Window := Create_Window_Ada (1024, 1024, "Hello");
   begin
      Viewport (0, 0, 1024, 1024);
      Make_Context_Current (W);
      Initialize (OpenGL_Loader_Test'Unrestricted_Access);
      return W;
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
      use GL.Buffers;
      use GL.Drawings;
      use GL.Uniforms;
      use Meshes;
      use GL.Programs.Uniforms;
      use GL.Programs;
      use GL.C;
      use GL.Math;
      use type GLfloat;
      P : constant Program := Setup_Program;
      Transform_Location : constant GL.Uniforms.Location := Get (P, "transform");
      Time_Location : constant GL.Uniforms.Location := Get (P, "u_time");
      M1 : Mesh (40);
      M2 : Mesh (40);
      M3 : Mesh (40);
   begin
      Cameras.Init (C);
      Cameras.Setup_Perspective (1.57079632679, 3.0/4.0, 0.1, 80.0, C);
      Set_Current (P);
      Setup (M1);
      Make_Grid_Lines (M1);
      Setup (M2);
      Make_Triangle (M2);
      Setup (M3);
      Make_Sin (M3);

      loop
         GLFW3.Poll_Events;
         GL.Buffers.Clear (Color_Plane);
         GL.Buffers.Clear (Depth_Plane);

         Get_Rotation_Input (W, C.Rotation);
         Get_Translation_Input (W, C.Translation_Velocity);
         Cameras.Update (C);

         GL.Uniforms.Modify_Matrix_4f (Transform_Location, C.Result_Matrix'Address);

         GL.Uniforms.Modify_1f (Time_Location, 0.0);
         Draw (M1);
         GL.Uniforms.Modify_1f (Time_Location, GL.C.GLfloat (GLFW3.Clock));
         Draw (M2);
         Draw (M3);

         GLFW3.Windows.Swap_Buffers (W);

         delay 0.01;

         pragma Warnings (Off);
         exit when GLFW3.Windows.Window_Should_Close (W) = 1;
         pragma Warnings (On);
      end loop;
   end;


















begin

   GLFW3.Initialize;


   declare
      use GLFW3;
      use GLFW3.Windows;
      use GLFW3.Windows.Keys;
      use Ada.Text_IO;
      use GL.Buffers;
      use GL.Drawings;
      use GL.Uniforms;
      use Meshes;
      use GL.Programs.Uniforms;
      use GL.Programs;
      use GL.C;
      use GL.Math;
      use type GLfloat;

      task Render_Task is
         entry Start;
      end;
      task Info_Task is
         entry Start;
         entry Stop;
      end;

      task body Render_Task is
         W : constant Window := Setup_Window;
      begin
         accept Start;
         Render_Loop (W);
         Destroy_Window (W);
         Info_Task.Stop;
      end;

      task body Info_Task is
         procedure Put is new Generic_Matpack.Put (Dimension, GLfloat, Matrix);
      begin
         accept Start;
         loop
            select
               accept Stop;
               exit;
            else

               delay 0.1;
               OS_Systems.Clear_Screen;

               Put (C.Projection_Matrix);
               Ada.Text_IO.New_Line;
               Put (C.Rotation_Matrix);
               Ada.Text_IO.New_Line;
               Put (C.Translation_Matrix);
               Ada.Text_IO.New_Line;
               Put (C.Result_Matrix);
            end select;
         end loop;
      end;

   begin
      Cameras.Init (C);
      Cameras.Setup_Perspective (1.57079632679, 3.0/4.0, 0.1, 80.0, C);
      Render_Task.Start;
      Info_Task.Start;

      null;
   end;


end;
