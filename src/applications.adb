with Ada.Unchecked_Conversion;
with GLFW3.Windows;

with System;

with Interfaces;
with Interfaces.C;

with GL.C.Initializations;
with GL.Programs.Uniforms;

with GLFW3.Windows.Keys;

with OpenGL_Loader_Test;
with Shaders;
with GL.Drawings;




package body Applications is



   package GLFW3_Key_Callbacks is
      use GLFW3;
      use GLFW3.Windows;
      use GLFW3.Windows.Keys;
      use Interfaces.C;
      procedure  GLFW3_Key_Callback (W : Window; K : Key; Scancode : int; A : Key_Action; Mods : int) with
        Convention => C;
      P : Key_Callback_Procedure := GLFW3_Key_Callback'Access;
   end;


   procedure Key_Callback (Item_Application : in out Application; K : GLFW3.Windows.Keys.Key; A : GLFW3.Windows.Keys.Key_Action) is
      use GLFW3.Windows.Keys;
      use Mesh_Handler_Basic;
      use type GL.C.GLfloat;
   begin
      if A = Key_Action_Press then
         case K is
            when Key_Kp_Add =>
               Item_Application.Grid_Mesh.Vertex_List.Empty;
               Item_Application.Grid_Stride := Item_Application.Grid_Stride + 0.1;
               Make_Grid_Lines (Item_Application.Grid_Mesh, 100.0, Item_Application.Grid_Stride);
            when Key_Kp_Subtract =>
               Item_Application.Grid_Mesh.Vertex_List.Empty;
               Item_Application.Grid_Stride := Item_Application.Grid_Stride - 0.1;
               Make_Grid_Lines (Item_Application.Grid_Mesh, 100.0, Item_Application.Grid_Stride);
            when others =>
               null;
         end case;
      end if;
   end;



   procedure Initialize (Item : in out Application) is
      use Simple_Debug_Systems;
   begin
      Enqueue (Item.Main_Debug_Queue, 1, "Application Initializing");
      GLFW3.Initialize;
      Item.Main_Window := GLFW3.Windows.Create_Window_Ada (1024, 1024, "Hello123##");
      GLFW3.Windows.Make_Context_Current (Item.Main_Window);
      GL.C.Initializations.Initialize (OpenGL_Loader_Test'Unrestricted_Access);

      GLFW3.Windows.Set_Window_User_Pointer (Item.Main_Window, Item'Address);
      GLFW3.Windows.Keys.Set_Key_Callback_Procedure (Item.Main_Window, GLFW3_Key_Callbacks.P);

      Item.Main_Program := Shaders.Setup_Program;
      Item.Main_Transform_Location := GL.Programs.Uniforms.Get (Item.Main_Program, "transform");
      Item.Main_Time_Location := GL.Programs.Uniforms.Get (Item.Main_Program, "u_time");

      Cameras.Init (Item.Main_Camera);
      GL.Programs.Set_Current (Item.Main_Program);



      Mesh_Handler_Basic.Make_Triangle (Item.Main_Mesh);
      Mesh_Handler_Basic.Initialize (Item.Grid_Mesh);
      Mesh_Handler_Basic.Initialize (Item.Main_Mesh);
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


   procedure Swap_Buffers (Item : Application) is
   begin
      GLFW3.Windows.Swap_Buffers (Item.Main_Window);
   end;


   procedure Poll_Events (Item : Application) is
      pragma Unreferenced (Item);
   begin
      GLFW3.Poll_Events;
   end;


   procedure Quit (Item : in out Application) is
      use Simple_Debug_Systems;
   begin
      Enqueue (Item.Main_Debug_Queue, 1, "Application closing");
      GLFW3.Windows.Destroy_Window (Item.Main_Window);
      GLFW3.Terminate_GLFW3;
   end;


   procedure Render_Stuff (Item : in out Application) is
      use Mesh_Handler_Basic;
   begin
      Update (Item.Grid_Mesh);
      GL.Drawings.Clear (GL.Drawings.Color_Plane);
      GL.Drawings.Clear (GL.Drawings.Depth_Plane);
      Draw (Item.Grid_Mesh);
      Draw (Item.Main_Mesh);
   end;



   package body GLFW3_Key_Callbacks is
      procedure GLFW3_Key_Callback (W : GLFW3.Window; K : GLFW3.Windows.Keys.Key; Scancode : Interfaces.C.int; A : GLFW3.Windows.Keys.Key_Action; Mods : Interfaces.C.int) is
         pragma Unreferenced (Mods, Scancode);
         use System;
         use Mesh_Handler_Basic;
         type Application_Access is access all Application;
         function Convert is new Ada.Unchecked_Conversion (Address, Application_Access);
         Main_App : constant Application_Access := Convert (GLFW3.Windows.Get_Window_User_Pointer (W));
      begin
         Key_Callback (Main_App.all, K, A);
      end;
   end;



end Applications;
