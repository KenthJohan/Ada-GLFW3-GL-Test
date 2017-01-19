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

with OpenGL_Loader_Test;
with OS_Systems;

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
      use Matpack.Quaternions;
      use GLFW3.Windows.Keys;
      use Matpack;
      Pith_Axis : constant Axis := (1.0, 0.0, 0.0);
      Yaw_Axis : constant Axis := (0.0, 1.0, 0.0);
      Amount : constant Radian := 0.1;
      Pith_Up : constant Quaternion := Convert_Axis_Angle_To_Quaterion (Pith_Axis, Amount);
      Pith_Down : constant Quaternion := Convert_Axis_Angle_To_Quaterion (Pith_Axis, -Amount);
      Yaw_Left : constant Quaternion := Convert_Axis_Angle_To_Quaterion (Yaw_Axis, Amount);
      Yaw_Right : constant Quaternion := Convert_Axis_Angle_To_Quaterion (Yaw_Axis, -Amount);
   begin

      if Get_Key (W, Key_Up) = Key_Action_Press then
         Ada.Text_IO.Put_Line ("Key_Up");
         Q := Hamilton_Product (Q, Pith_Up);
      else
         Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_Down) = Key_Action_Press then
         Ada.Text_IO.Put_Line ("Key_Down");
         Q := Hamilton_Product (Q, Pith_Down);
      else
         Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_Left) = Key_Action_Press then
         Ada.Text_IO.Put_Line ("Key_Left");
         Q := Hamilton_Product (Yaw_Left, Q);
      else
         Ada.Text_IO.Put_Line ("");
      end if;

      if Get_Key (W, Key_Right) = Key_Action_Press then
         Ada.Text_IO.Put_Line ("Key_Right");
         Q := Hamilton_Product (Yaw_Right, Q);
      else
         Ada.Text_IO.Put_Line ("");
      end if;

      Normalize (Vector (Q));

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
   begin
      Get_Rotation_Input (W, C.Rotation_Quaternion);
      Quaternion_To_Matrix_4 (C.Rotation_Quaternion, C.Rotation);
      Get_Translation_Input (W, Translation_Delta);
      --Accumulate (Translation_Delta, C.Position);
      Multiply_Accumulate_Transpose (C.Rotation, Translation_Delta, C.Position);
      Make_Translation (C.Translation, C.Position);
   end;

   procedure Update_Camera (Item : in out Camera) is
      use Matpack;
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

























   procedure Render_Loop (W : GLFW3.Window; L : GL.Uniforms.Location; C : in out Camera) is
      use GLFW3;
      use GLFW3.Windows;
      use GLFW3.Windows.Keys;
      use Ada.Text_IO;
      use GL.Buffers;
      use GL.Drawings;
      use GL.Uniforms;
      use Matpack;
      use Meshes;
      M1 : Mesh (40);
      M2 : Mesh (40);
      K : Character;
   begin
      Setup (M1);
      Make_Grid_Lines (M1);
      Setup (M2);
      Make_Triangle (M2);
      Get_Immediate (K);

      loop
         GLFW3.Poll_Events;
         GL.Buffers.Clear (Color_Plane);
         GL.Buffers.Clear (Depth_Plane);
         Get_Camera_Input (W, C);
         Update_Camera (C);
         GL.Uniforms.Modify (L, C.Result'Address);

         Draw (M1);
         Draw (M2);

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
      use GL.Programs;
      use GL.Buffers;
      use GL.Programs.Uniforms;
      C : Camera;
      W : constant Window := Setup_Window;
      P : constant Program := Setup_Program;
      L : constant GL.Uniforms.Location := Get (P, "transform");
   begin
      Matpack.Set_Diagonal (C.Translation, 1.0);
      Matpack.Set_Diagonal (C.Rotation, 1.0);
      Matpack.Set_Diagonal (C.Result, 1.0);
      C.Projection := (others => (others => 0.0));
      Matpack.Projections.Make_Perspective (C.Projection, 1.57079632679, 3.0/4.0, 0.1, 80.0);
      Set_Current (P);
      Render_Loop (W, L, C);
      Destroy_Window (W);
   end;


end;
