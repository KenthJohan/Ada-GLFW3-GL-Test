with GLFW3.Windows.Keys;

package Inputs is

   type Action is (Pith_Up, Pith_Down, Yaw_Left, Yaw_Right, Roll_Left, Roll_Right, Go_Forward, Go_Backward, Go_Left, Go_Right, Go_Up, Go_Down);

   type Bindings is array (GLFW3.Windows.Keys.Key) of Action;


end;
