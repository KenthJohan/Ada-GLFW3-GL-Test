with GLFW3;
--with GLFW3.Windows.Keys;

with GL.Uniforms;
with GL.Programs;
with GL.C;


with Simple_Moving_Averages;
with Simple_Debug_Systems;

with Mesh_Handler_Basic;

with Cameras;
with Inputs;


package Applications is

   type Application is record
      Check_Sum : Integer := 555;
      Dummy1 : Boolean := False;
      Main_Window : GLFW3.Window;
      Main_Debug_Queue : Simple_Debug_Systems.Debug_Message_Queue;
      Grid_Stride : GL.C.GLfloat := 1.0;
      Grid_Mesh : Mesh_Handler_Basic.Mesh;
      Main_Mesh : Mesh_Handler_Basic.Mesh;
      Main_SMA : Simple_Moving_Averages.SMA;
      Main_Camera : Cameras.Camera;
      Main_Program : GL.Programs.Program;
      Main_Transform_Location : GL.Uniforms.Location;
      Main_Time_Location : GL.Uniforms.Location;
      Main_Binding_Array : Inputs.Binding_Array;-- :=
--          (
--           Inputs.Pith_Up => Key_Up,
--           Inputs.Pith_Down => Key_Down,
--           Inputs.Yaw_Left => Key_Left,
--           Inputs.Yaw_Right => Key_Right,
--           Inputs.Roll_Left => Key_Q,
--           Inputs.Roll_Right => Key_E,
--           Inputs.Go_Forward => Key_W,
--           Inputs.Go_Backward => Key_S,
--           Inputs.Go_Left => Key_A,
--           Inputs.Go_Right => Key_D,
--           Inputs.Go_Up => Key_Space,
--           Inputs.Go_Down => Key_Left_Control,
--           Inputs.Increase_FOV => Key_P,
--           Inputs.Decrease_FOV => Key_O,
--           others => <>
--          );
   end record;



   procedure Initialize (Item : in out Application);
   function Window_Closing (Item : in out Application) return Boolean;
   procedure Swap_Buffers (Item : Application);
   procedure Poll_Events (Item : Application);
   procedure Quit (Item : in out Application);

   procedure Render_Stuff (Item : in out Application);

end Applications;
