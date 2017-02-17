with GLFW3;
with GLFW3.Windows;

with GL.Programs.Uniforms;
with GL.C;


with Simple_Moving_Averages;
with Simple_Debug_Systems;
with Simple_Meshes;
with Simple_Cameras;
with Simple_Shaders;
with Simple_File_Drop_Storage;

package Applications is

   type Application is record
      Check_Sum : Integer := 555;
      Dummy1 : Boolean := False;
      Main_Window : GLFW3.Windows.Window;
      Main_Debug_Queue : Simple_Debug_Systems.Debug_Message_Queue;
      Grid_Stride : GL.C.GLfloat := 1.0;
      Grid_Mesh : Simple_Meshes.Mesh;
      Main_Mesh : Simple_Meshes.Mesh;
      Main_SMA : Simple_Moving_Averages.SMA;
      Main_Camera : Simple_Cameras.Camera;
      Main_Program : Simple_Shaders.Program_Composition (2);
      Main_Transform_Location : GL.Programs.Uniforms.Location;
      Main_Time_Location : GL.Programs.Uniforms.Location;
      Main_Dropped_Files : Simple_File_Drop_Storage.Dropped_File_Vector;
   end record;


   procedure Dummy1;


end Applications;
