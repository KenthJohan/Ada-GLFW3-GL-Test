with Ada.Text_IO;
with Ada.Strings.Fixed;
with Maths;


package body Inputs is

   procedure Put_State (W : Window; Item : Binding_Array) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
   begin
      for I in Action loop
         Put (Head (Action'Image (I), 30));
         Put (" ");
         Put (Key_Action'Image (Keys.Get_Key (W, Item (I))));
         New_Line;
      end loop;
   end;




   procedure Get_Translation_Input (W : Window; T : in out Float_Vector4) is
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

   procedure Get_Rotation_Input (W : Window; Q : in out Float_Vector4) is
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
      Normalize (Float_Vector (Q));
   end;


   procedure Get_Camera_Input (W : Window; C : in out Cameras.Camera) is
   begin
      if Get_Key (W, Key_O) = Key_Action_Press then
         C.FOV := C.FOV + 0.001;
      end if;
      if Get_Key (W, Key_L) = Key_Action_Press then
         C.FOV := C.FOV - 0.001;
      end if;
   end;



end;
