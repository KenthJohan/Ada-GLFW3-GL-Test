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

with Meshes;


with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;

with Ada.Text_IO;
with Ada.Numerics.Elementary_Functions;

with OpenGL_Loader_Test;
with OS_Systems;

with Generic_Matpack;
with Generic_Matpack.Quaternions;
with Generic_Matpack.Projections;

with Matpack;
with Matpack.Projections;
with Matpack.Quaternions;

procedure Dev is

   procedure Get_Translation_Input (W : GLFW3.Window; T : in out Matpack.Vector_4) is
      use GLFW3.Windows.Keys;
      Amount : constant Float := 0.1;
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

   procedure Get_Rotation_Input (W : GLFW3.Window; Q : in out Matpack.Quaternions.Quaternion) is
      --use Matpack.Quaternions;
      use GLFW3.Windows.Keys;
      --use Matpack;
      use type Matpack.Radian;

      function Convert is new Generic_Matpack.Quaternions.Axis_Quaternion_Conversion_Function (Matpack.Index_4, Matpack.Index_3, Float, Matpack.Quaternions.Quaternion, Matpack.Axis, 2.0, Ada.Numerics.Elementary_Functions.Sin, Ada.Numerics.Elementary_Functions.Cos);

      Pith_Axis : constant Matpack.Axis := (1.0, 0.0, 0.0);
      Yaw_Axis : constant Matpack.Axis := (0.0, 1.0, 0.0);
      Roll_Axis : constant Matpack.Axis := (0.0, 0.0, 1.0);
      Amount : constant Float := 0.1;
      Pith_Up : constant Matpack.Quaternions.Quaternion := Convert (Pith_Axis, Amount);
      Pith_Down : constant Matpack.Quaternions.Quaternion := Convert (Pith_Axis, -Amount);
      Yaw_Left : constant Matpack.Quaternions.Quaternion := Convert (Yaw_Axis, Amount);
      Yaw_Right : constant Matpack.Quaternions.Quaternion := Convert (Yaw_Axis, -Amount);
      Roll_Left : constant Matpack.Quaternions.Quaternion := Convert (Roll_Axis, Amount);
      Roll_Right : constant Matpack.Quaternions.Quaternion := Convert (Roll_Axis, -Amount);
      function "*" is new Generic_Matpack.Quaternions.Quaternion_Quaternion_Hamilton_Product (Matpack.Index_4, Float, Matpack.Quaternions.Quaternion, 0.0);

   begin

      if Get_Key (W, Key_Up) = Key_Action_Press then
         Ada.Text_IO.Put_Line ("Key_Up");
         Q := Q * Pith_Up;
      else
         Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_Down) = Key_Action_Press then
         Ada.Text_IO.Put_Line ("Key_Down");
         Q := Q * Pith_Down;
      else
         Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_Left) = Key_Action_Press then
         Ada.Text_IO.Put_Line ("Key_Left");
         Q := Yaw_Left * Q;
      else
         Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_Right) = Key_Action_Press then
         Ada.Text_IO.Put_Line ("Key_Right");
         Q := Yaw_Right * Q;
      else
         Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_Q) = Key_Action_Press then
         Ada.Text_IO.Put_Line ("Key_Q");
         Q := Q * Roll_Left;
      else
         Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_E) = Key_Action_Press then
         Ada.Text_IO.Put_Line ("Key_E");
         Q := Q * Roll_Right;
      else
         Ada.Text_IO.Put_Line ("");
      end if;

      Matpack.Normalize (Matpack.Vector (Q));

   end;


   type Camera is record
      Position : Matpack.Vector_4;
      Rotation_Quaternion : Matpack.Quaternions.Quaternion := Matpack.Quaternions.Quaternion_Unit;
      Projection : Matpack.Matrix_4;
      Rotation : Matpack.Matrix_4;
      Translation : Matpack.Matrix_4;
      Result : Matpack.Matrix_4;
   end record;

   procedure Get_Camera_Input (W : GLFW3.Window; C : in out Camera) is
      use Matpack;
      use Matpack.Quaternions;
      use Matpack.Projections;
      Translation_Delta : Vector_4 := (others => 0.0);
      procedure Mul_T is new Generic_Matpack.Matrix_T1_Vector_Product (Integer, Float, Matrix, Vector);
      procedure Convert is new Generic_Matpack.Projections.Vector_Matrix_Translation_Conversion (Matpack.Index_4, Float, Matpack.Vector_4, Matpack.Matrix_4);
      procedure Convert is new Generic_Matpack.Quaternions.Quaternion_Matrix_4_Conversion (Matpack.Index_4, Float, Matpack.Quaternions.Quaternion, Matpack.Matrix_4, 2.0);
   begin
      Get_Rotation_Input (W, C.Rotation_Quaternion);
      Convert (C.Rotation_Quaternion, C.Rotation);
      Get_Translation_Input (W, Translation_Delta);
      Mul_T (C.Rotation, Translation_Delta, C.Position);
      Matpack.Make_Identity (C.Translation);
      Convert (C.Position, C.Translation);
   end;

   procedure Update_Camera (Item : in out Camera) is
      --use Matpack;
      function "*" is new Generic_Matpack.Matrix_Matrix_Product_IKJ (Integer, Float, Matpack.Matrix, 0.0);
   begin
      Item.Result := Item.Projection * Item.Rotation * Item.Translation;
      --Item.Result := Item.Translation * Item.Projection;
      --Item.Result := Mul (Item.Translation, Item.Projection);
   end;


   function Setup_Window return GLFW3.Window is
      use GLFW3;
      use GLFW3.Windows;
      use GL.C.Initializations;
      use GL.Drawings;
      W : constant Window := Create_Window_Ada (400, 400, "Hello");
   begin
      Viewport (0, 0, 400, 400);
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

























   procedure Render_Loop (W : GLFW3.Window; C : in out Camera) is
      use GLFW3;
      use GLFW3.Windows;
      use GLFW3.Windows.Keys;
      use Ada.Text_IO;
      use GL.Buffers;
      use GL.Drawings;
      use GL.Uniforms;
      use Matpack;
      use Meshes;
      use GL.Programs.Uniforms;
      use GL.Programs;
      --use Ada.Numerics.Elementary_Functions;
      P : constant Program := Setup_Program;
      Transform_Location : constant GL.Uniforms.Location := Get (P, "transform");
      Time_Location : constant GL.Uniforms.Location := Get (P, "u_time");
      M1 : Mesh (40);
      M2 : Mesh (40);
      M3 : Mesh (40);
      K : Character;
   begin
      Set_Current (P);
      Setup (M1);
      Make_Grid_Lines (M1);
      Setup (M2);
      Make_Triangle (M2);
      Setup (M3);
      Make_Sin (M3);
      Get_Immediate (K);

      loop
         GLFW3.Poll_Events;
         GL.Buffers.Clear (Color_Plane);
         GL.Buffers.Clear (Depth_Plane);
         Get_Camera_Input (W, C);
         Update_Camera (C);
         GL.Uniforms.Modify_Matrix_4f (Transform_Location, C.Result'Address);
         GL.Uniforms.Modify_1f (Time_Location, GL.C.GLfloat (GLFW3.Clock));
         Draw (M1);
         Draw (M2);
         Draw (M3);

         GLFW3.Windows.Swap_Buffers (W);

         Matpack.Put (C.Projection);
         Ada.Text_IO.New_Line;

         Matpack.Put (C.Translation);
         Ada.Text_IO.New_Line;

         Matpack.Put (C.Result);
         delay 0.01;
         OS_Systems.Clear_Screen;


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
      use GL.Buffers;
      C : Camera;
      W : constant Window := Setup_Window;
   begin
      Matpack.Set_Diagonal (C.Translation, 1.0);
      Matpack.Set_Diagonal (C.Rotation, 1.0);
      Matpack.Set_Diagonal (C.Result, 1.0);
      C.Projection := (others => (others => 0.0));
      Matpack.Projections.Make_Perspective (C.Projection, 1.57079632679, 3.0/4.0, 0.1, 80.0);
      Render_Loop (W, C);
      Destroy_Window (W);
   end;


end;
