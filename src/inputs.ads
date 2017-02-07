with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;

with Interfaces;
with Interfaces.C;
with GL.Math;
with Cameras;


package Inputs is

   use GLFW3;
   use GLFW3.Windows;
   use GLFW3.Windows.Keys;
   use Interfaces.C;
   use GL.Math;

   type Action is (Pith_Up, Pith_Down, Yaw_Left, Yaw_Right, Roll_Left, Roll_Right, Go_Forward, Go_Backward, Go_Left, Go_Right, Go_Up, Go_Down, Increase_FOV, Decrease_FOV);

   type Binding_Array is array (Action) of GLFW3.Windows.Keys.Key;

   procedure Put_State (W : Window; Item : Binding_Array);



   procedure Get_Rotation_Input (W : GLFW3.Window; Q : in out Float_Vector4);
   procedure Get_Translation_Input (W : Window; T : in out Float_Vector4);
   procedure Get_Camera_Input (W : Window; C : in out Cameras.Camera);




end;
