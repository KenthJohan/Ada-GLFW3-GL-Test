with System;
with Ada.Unchecked_Conversion;


package body Applications.Main_Key_Callbacks is
   procedure Key_Callback (W : GLFW3.Windows.Window; K : GLFW3.Windows.Keys.Key; Scancode : Interfaces.C.int; A : GLFW3.Windows.Keys.Key_Action; Mods : Interfaces.C.int) is
      pragma Unreferenced (Mods, Scancode);
      use System;
      use Simple_Meshes;
      type Application_Access is access all Application;
      function Convert is new Ada.Unchecked_Conversion (Address, Application_Access);
      --Main_App : constant Application_Access := Convert (GLFW3.Windows.Get_Window_User_Pointer (W));
      App : Application renames Convert (GLFW3.Windows.Get_Window_User_Pointer (W)).all;
   begin
      if A = Key_Action_Press then
         case K is
            when Key_Kp_Add =>
               App.Grid_Mesh.Vertex_List.Empty;
               App.Grid_Stride := App.Grid_Stride + 0.1;
               Make_Grid_Lines (App.Grid_Mesh, 100.0, App.Grid_Stride);
            when Key_Kp_Subtract =>
               App.Grid_Mesh.Vertex_List.Empty;
               App.Grid_Stride := App.Grid_Stride - 0.1;
               Make_Grid_Lines (App.Grid_Mesh, 100.0, App.Grid_Stride);
            when Key_P =>
               Simple_Shaders.Build (App.Main_Program);
            when Key_Escape =>
               GLFW3.Windows.Set_Window_Should_Close (App.Main_Window, 1);
            when others =>
               null;
         end case;
      end if;
   end;
end;
