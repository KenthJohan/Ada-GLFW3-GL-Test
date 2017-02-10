with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;




package Applications.Inputs is



   type Action is (Pith_Up, Pith_Down, Yaw_Left, Yaw_Right, Roll_Left, Roll_Right, Go_Forward, Go_Backward, Go_Left, Go_Right, Go_Up, Go_Down, Increase_FOV, Decrease_FOV);

   type Binding_Array is array (Action) of GLFW3.Windows.Keys.Key;

   procedure Get_Camera_Input (A : in out Application);
   procedure Put_State (A : Application; B : Binding_Array);

end;
