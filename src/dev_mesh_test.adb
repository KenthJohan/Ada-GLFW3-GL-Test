with GLFW3;
with GLFW3.Windows;
with GL.Drawings;
with Apps;
with Mesh_Handler_Basic;
with Ada.Real_Time;

procedure Dev_Mesh_Test is

   use Ada.Real_Time;

   Main_App : aliased Apps.App;
   --Main_App_Controller_Task : Apps.Controller_Task (Main_App'Access);
   --Main_App_Info_Task : Apps.Info_Task (Main_App'Access);
   Main_Mesh_Vector : Mesh_Handler_Basic.Mesh_Vector (2);

begin

   Apps.Init (Main_App);

   Main_Mesh_Vector.Append;
   Mesh_Handler_Basic.Make_Triangle (Main_Mesh_Vector.First_Element);
   Mesh_Handler_Basic.GPU_Load (Main_Mesh_Vector);

   --Main_App_Controller_Task.Start;
   --Main_App_Info_Task.Start;

   loop
      Main_App.Main_Frame_Counter := Positive'Succ (Main_App.Main_Frame_Counter);
      Main_App.Main_Time_End := Ada.Real_Time.Clock;
      Main_App.Main_Time_Span := Main_App.Main_Time_Span + (Main_App.Main_Time_End - Main_App.Main_Time_Start);
      Main_App.Main_Time_Start := Ada.Real_Time.Clock;
      GLFW3.Poll_Events;
      GL.Drawings.Clear (GL.Drawings.Color_Plane);
      GL.Drawings.Clear (GL.Drawings.Depth_Plane);
      Apps.Input_Controller (Main_App);
      Apps.Update_Camera_GL (Main_App);
      Mesh_Handler_Basic.Draw (Main_Mesh_Vector);
      GLFW3.Windows.Swap_Buffers (Main_App.Main_Window);
      exit when Apps.Window_Closing (Main_App);
      delay 0.01;
   end loop;

   --Main_App_Info_Task.Quit;
   --Main_App_Controller_Task.Quit;
   GLFW3.Windows.Destroy_Window (Main_App.Main_Window);
   GLFW3.Terminate_GLFW3;

end;
