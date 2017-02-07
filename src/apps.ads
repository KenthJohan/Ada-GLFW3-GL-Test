with Ada.Real_Time;
--with Ada.Unchecked_Conversion;
with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;
with GL.Uniforms;
with GL.Programs;
with Cameras;
with Inputs;
with Interfaces;
with Interfaces.C;

package Apps is

   use GLFW3;
   use GLFW3.Windows;
   use GLFW3.Windows.Keys;
   use Ada.Real_Time;

   type App;


   task type Info_Task (A : access App) is
      entry Start;
      entry Quit;
   end;


   task type Controller_Task (A : access App) is
      entry Start;
      entry Quit;
   end;


   type App is record
      Main_Window : Window := GLFW3.Windows.Null_Window;
      Check_Sum : Integer := 555;
      Dummy1 : Boolean := False;
      Input_Controller_Enable_Task : Boolean;
      Main_Time_Start : Time;
      Main_Time_End : Time;
      Main_Time_Span : Time_Span := Nanoseconds (0);
      Main_Frame_Counter : Positive := 1;
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


   --function Convert is new Ada.Unchecked_Conversion (GLFW3.Window, App);


   procedure Init (Item : in out App);


   function Window_Closing (Item : in out App) return Boolean;


   procedure Update_Camera_GL (Item : App);


   procedure Input_Controller (Item : in out App);


end Apps;
