with GLFW3;
with GLFW3.Windows;
with GL.Drawings;
with Apps;
with Mesh_Handler_Basic;
with Simple_Moving_Averages;

procedure Dev_Mesh_Test is

   Main_App : aliased Apps.App;
   Main_App_Controller_Task : Apps.Controller_Task (Main_App'Access);
   Main_App_Info_Task : Apps.Info_Task (Main_App'Access);
   Main_Mesh_Vector : Mesh_Handler_Basic.Mesh_Vector (2);

begin

   Apps.Init (Main_App);

   Main_Mesh_Vector.Append;
   Mesh_Handler_Basic.Make_Triangle (Main_Mesh_Vector.Last_Element);
   Mesh_Handler_Basic.GPU_Load (Main_Mesh_Vector);

   --Main_Mesh_Vector.Append;
   --Mesh_Handler_Basic.Make_Grid_Lines (Main_Mesh_Vector.Last_Element);
   --Mesh_Handler_Basic.GPU_Load (Main_Mesh_Vector);

   --Main_App_Controller_Task.Start;
   --Main_App_Info_Task.Start;

   loop
      Simple_Moving_Averages.Update (Main_App.Main_SMA, 10);
      GLFW3.Poll_Events;
      GL.Drawings.Clear (GL.Drawings.Color_Plane);
      GL.Drawings.Clear (GL.Drawings.Depth_Plane);

      Apps.Input_Controller (Main_App);

      Apps.Update_Camera_GL (Main_App);

      Mesh_Handler_Basic.Draw (Main_Mesh_Vector);

      Mesh_Handler_Basic.GPU_Load (Main_App.Grid_Mesh);
      Mesh_Handler_Basic.Draw (Main_App.Grid_Mesh);

      GLFW3.Windows.Swap_Buffers (Main_App.Main_Window);
      exit when Apps.Window_Closing (Main_App);
      delay 0.01;
   end loop;

   Main_App_Info_Task.Quit;
   Main_App_Controller_Task.Quit;
   GLFW3.Windows.Destroy_Window (Main_App.Main_Window);
   GLFW3.Terminate_GLFW3;

end;
