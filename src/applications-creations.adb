with Ada.Unchecked_Conversion;
with Ada.Text_IO;
with Ada.Exceptions;

with System;

with Interfaces;
with Interfaces.C;
with Interfaces.C.Strings;

with GL.C.Initializations;
with GL.Programs.Uniforms;
with GL.Drawings;
with GL.Programs;

with GLFW3.Windows.Keys;
with GLFW3.Windows.Drops;
with GLFW3.Monitors;

with Applications.OpenGL_Loader;
with GL.Vertex_Array_Objects;


with Home_Pictures.BMP_Images;

package body Applications.Creations is







   procedure Initialize_Context (Item : in out Application; Fullscreen : Boolean) is
      use Simple_Debug_Systems;
   begin
      Enqueue (Item.Main_Debug_Queue, 1, "Application Context Initializing");

      if Fullscreen then
         Item.Main_Window := GLFW3.Windows.Create_Window_Ada (1024, 1024, "Hello123##", GLFW3.Monitors.Get_Primary_Monitor);
      else
         Item.Main_Window := GLFW3.Windows.Create_Window_Ada (1024, 1024, "Hello123##");
      end if;

      GLFW3.Windows.Make_Context_Current (Item.Main_Window);
      GL.C.Initializations.Initialize (OpenGL_Loader.Loader'Unrestricted_Access);

      GLFW3.Windows.Set_Window_User_Pointer (Item.Main_Window, Item'Address);

      Item.Main_Program.Obj := GL.Programs.Create_Empty;
      Simple_Shaders.Append (Item.Main_Program, "test.glvs");
      Simple_Shaders.Append (Item.Main_Program, "test.glfs");
      Simple_Shaders.Build (Item.Main_Program);
      Item.Main_Transform_Location := GL.Programs.Uniforms.Get (Item.Main_Program.Obj, "transform");
      Item.Main_Time_Location := GL.Programs.Uniforms.Get (Item.Main_Program.Obj, "u_time");
      GL.Programs.Set_Current (Item.Main_Program.Obj);

      Simple_Meshes.Initialize (Item.Grid_Mesh);
      Simple_Meshes.Initialize (Item.Main_Mesh);
   end;


   procedure Initialize_Logic (Item : in out Application) is
      use Simple_Debug_Systems;
   begin
      Enqueue (Item.Main_Debug_Queue, 1, "Application Logic Initializing");
      Simple_Cameras.Init (Item.Main_Camera);
      Simple_Meshes.Make_Triangle (Item.Main_Mesh);
   end;



   function Window_Closing (Item : in out Application) return Boolean is
      use Simple_Debug_Systems;
      use GLFW3.Windows;
   begin
      Item.Dummy1 := False;
      if Window_Should_Close (Item.Main_Window) = 1 then
         Enqueue (Item.Main_Debug_Queue, 1, "Window Closing");
         return True;
      else
         return False;
      end if;
   end;



   procedure Destroy (Item : in out Application) is
      use Simple_Debug_Systems;
   begin
      Simple_Shaders.Delete (Item.Main_Program);
      Enqueue (Item.Main_Debug_Queue, 1, "Destroy Window");
      GLFW3.Windows.Destroy_Window (Item.Main_Window);
   end;


   procedure Render_Stuff (Item : in out Application) is
      use Simple_Meshes;
      use GL.C;
   begin
      GL.Vertex_Array_Objects.Bind (Item.Main_Mesh.VAO);
      GL.Programs.Set_Current (Item.Main_Program.Obj);
      Update (Item.Grid_Mesh);
      GL.Programs.Uniforms.Modify_1f (Item.Main_Time_Location, GLfloat (0.0));
      Draw (Item.Grid_Mesh);
      GL.Programs.Uniforms.Modify_1f (Item.Main_Time_Location, GLfloat (GLFW3.Clock));
      Draw (Item.Main_Mesh);
   end;


end;
