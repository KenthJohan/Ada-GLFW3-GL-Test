with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;

package Inputs is

   use GLFW3;
   use GLFW3.Windows;
   use GLFW3.Windows.Keys;

   type Action is (Pith_Up, Pith_Down, Yaw_Left, Yaw_Right, Roll_Left, Roll_Right, Go_Forward, Go_Backward, Go_Left, Go_Right, Go_Up, Go_Down, Increase_FOV, Decrease_FOV);

   type Binding_Array is array (Action) of GLFW3.Windows.Keys.Key;

   Config_1 : Binding_Array :=
     (
      Pith_Up => Keys.Key_Up,
      Pith_Down => Keys.Key_Down,
      Yaw_Left => Keys.Key_Left,
      Yaw_Right => Keys.Key_Right,
      Roll_Left => Keys.Key_Q,
      Roll_Right => Keys.Key_E,
      Go_Forward => Keys.Key_W,
      Go_Backward => Keys.Key_S,
      Go_Left => Keys.Key_A,
      Go_Right => Keys.Key_D,
      Go_Up => Keys.Key_Space,
      Go_Down => Keys.Key_Left_Control,
      Increase_FOV => Keys.Key_P,
      Decrease_FOV => Keys.Key_O,
      others => <>
     );

   procedure Put_State (W : Window; Item : Binding_Array);

end;
