with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;

with GL.Uniforms;
with GL.Programs;

with Interfaces;
with Interfaces.C;

with Mesh_Handler_Basic;
with Simple_Moving_Averages;
with Cameras;
with Inputs;
with GL.C;

package Apps is

   use GLFW3;
   use GLFW3.Windows;
   use GLFW3.Windows.Keys;
   use GL.C;
   use Mesh_Handler_Basic;

   type App;


   task type Info_Task (A : access App) is
      entry Pause;
      entry Resume;
      entry Quit;
   end;



   task type Controller_Task (A : access App) is
      entry Pause;
      entry Resume;
      entry Quit;
   end;


   type App is record
      Main_Window : Window := GLFW3.Windows.Null_Window;
      Check_Sum : Integer := 555;
      Dummy1 : Boolean := False;
      Grid_Stride : GLfloat := 1.0;
      Grid_Mesh : Mesh;
      Main_SMA : Simple_Moving_Averages.SMA;
      Main_Camera : Cameras.Camera;
      Main_Program : GL.Programs.Program;
      Main_Transform_Location : GL.Uniforms.Location;
      Main_Time_Location : GL.Uniforms.Location;
      Main_Binding_Array : Inputs.Binding_Array :=
        (
         Inputs.Pith_Up => Key_Up,
         Inputs.Pith_Down => Key_Down,
         Inputs.Yaw_Left => Key_Left,
         Inputs.Yaw_Right => Key_Right,
         Inputs.Roll_Left => Key_Q,
         Inputs.Roll_Right => Key_E,
         Inputs.Go_Forward => Key_W,
         Inputs.Go_Backward => Key_S,
         Inputs.Go_Left => Key_A,
         Inputs.Go_Right => Key_D,
         Inputs.Go_Up => Key_Space,
         Inputs.Go_Down => Key_Left_Control,
         Inputs.Increase_FOV => Key_P,
         Inputs.Decrease_FOV => Key_O,
         others => <>
        );
   end record;


   procedure Key_Callback (W : Window; K : Key; Scancode : Interfaces.C.int; A : Key_Action; Mods : Interfaces.C.int) with Convention => C;


   procedure Init (Item : in out App);


   function Window_Closing (Item : in out App) return Boolean;


   procedure Update_Camera_GL (Item : App);


   procedure Input_Controller (Item : in out App);


end Apps;
