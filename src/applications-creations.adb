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

package body Applications.Creations is

   package GLFW3_Drop_Callbacks is
      use GLFW3.Windows;
      use GLFW3.Windows.Drops;
      use Interfaces.C;
      pragma Warnings (Off);
      procedure drop_callback (W : Window; Count : int; Paths : File_Path_List) with Convention => C;
      pragma Warnings (On);
   end GLFW3_Drop_Callbacks;








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
      GLFW3.Windows.Drops.Set_Drop_Callback (Item.Main_Window, GLFW3_Drop_Callbacks.drop_callback'Access);
     -- GLFW3.Windows.Keys.Set_Key_Callback_Procedure (Item.Main_Window, GLFW3_Key_Callbacks.GLFW3_Key_Callback'Access);

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





   package body GLFW3_Drop_Callbacks is
      procedure drop_callback (W : Window; Count : int; Paths : File_Path_List) is
         use Interfaces.C.Strings;
         use Ada.Text_IO;
         use Simple_File_Drop_Storage;
         use System;
         type Application_Access is access all Application;
         function Convert is new Ada.Unchecked_Conversion (Address, Application_Access);
         Main_App : constant Application_Access := Convert (GLFW3.Windows.Get_Window_User_Pointer (W));
      begin
         Put_Line ("Count: " & Count'Img);
         for I in size_t (0) .. size_t (Count - 1) loop
            declare
               Name : constant String := Value (Paths (I));
            begin
               Enqueue (Main_App.Main_Dropped_Files_Queue, 1, Name);
            end;
         end loop;
      end;
   end GLFW3_Drop_Callbacks;

end;
