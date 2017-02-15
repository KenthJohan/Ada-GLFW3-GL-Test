with Ada.Text_IO;
with Ada.Strings.Fixed;

with Maths;

with GL.Math;

with Simple_Cameras;

package body Applications.Inputs is

   procedure Put_State (A : Application; B : Binding_Array) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use GLFW3.Windows.Keys;
   begin
      for I in Action loop
         Put (Head (Action'Image (I), 30));
         Put (" ");
         Put (Key_Action'Image (Get_Key (A.Main_Window, B (I))));
         New_Line;
      end loop;
   end;


   procedure Get_Translation_Input (W : GLFW3.Windows.Window; T : in out GL.Math.Real_Float_Vector4) is
      use GLFW3;
      use GLFW3.Windows;
      use GL.Math;
      use GLFW3.Windows.Keys;
      use type GL.Math.Real_Float;
      Amount : constant Real_Float := 0.1;
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

   procedure Get_Rotation_Input (W : GLFW3.Windows.Window; Q : in out GL.Math.Real_Float_Vector4) is
      use Maths;
      use GL.Math;
      use GLFW3.Windows.Keys;
      use type GL.Math.Real_Float;
      Amount : constant Real_Float := 0.01;
      Pith_Axis : constant Real_Float_Vector3 := (1.0, 0.0, 0.0);
      Yaw_Axis : constant Real_Float_Vector3 := (0.0, 1.0, 0.0);
      Roll_Axis : constant Real_Float_Vector3 := (0.0, 0.0, 1.0);
      Pith_Up : constant Real_Float_Vector4 := Convert_Axis_Angle_To_Quaternion (Pith_Axis, Amount);
      Pith_Down : constant Real_Float_Vector4 := Convert_Axis_Angle_To_Quaternion (Pith_Axis, -Amount);
      Yaw_Left : constant Real_Float_Vector4 := Convert_Axis_Angle_To_Quaternion (Yaw_Axis, Amount);
      Yaw_Right : constant Real_Float_Vector4 := Convert_Axis_Angle_To_Quaternion (Yaw_Axis, -Amount);
      Roll_Left : constant Real_Float_Vector4 := Convert_Axis_Angle_To_Quaternion (Roll_Axis, Amount);
      Roll_Right : constant Real_Float_Vector4 := Convert_Axis_Angle_To_Quaternion (Roll_Axis, -Amount);
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
      Normalize (Real_Float_Vector (Q));
   end;


   procedure Get_Camera_Input (A : in out Application) is
      use type GL.Math.Real_Float;
      use Simple_Cameras;
      use GLFW3.Windows.Keys;
   begin
      if Get_Key (A.Main_Window, Key_O) = Key_Action_Press then
         A.Main_Camera.FOV := A.Main_Camera.FOV + 0.001;
      end if;
      if Get_Key (A.Main_Window, Key_L) = Key_Action_Press then
         A.Main_Camera.FOV := A.Main_Camera.FOV - 0.001;
      end if;
      Get_Rotation_Input (A.Main_Window, A.Main_Camera.Rotation);
      Get_Translation_Input (A.Main_Window, A.Main_Camera.Translation_Velocity);
      Update (A.Main_Camera);
      GL.Programs.Uniforms.Modify_Matrix_4f (A.Main_Transform_Location, A.Main_Camera.Result_Matrix'Address);
      GL.Programs.Uniforms.Modify_1f (A.Main_Time_Location, 0.0);
   end;

end;
