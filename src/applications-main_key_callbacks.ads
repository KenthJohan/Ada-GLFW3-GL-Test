with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;
with Interfaces;
with Interfaces.C;

package Applications.Main_Key_Callbacks is
   use GLFW3;
   use GLFW3.Windows;
   use GLFW3.Windows.Keys;
   use Interfaces.C;

   procedure Key_Callback (W : Window; K : Key; Scancode : int; A : Key_Action; Mods : int) with
     Convention => C;
end;
