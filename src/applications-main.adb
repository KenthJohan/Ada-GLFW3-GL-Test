with Applications.Information_Tasks;
with Applications.Inputs;
with Applications.Creations;
with Applications.Main_Key_Callbacks;

with GLFW3.Windows.Keys;

with Simple_Text_Render;

with Ada.Exceptions;
with GL.Drawings;
with GL.Errors;
with Interfaces;
with Interfaces.C;
with System;
with Ada.Unchecked_Conversion;

procedure Applications.Main is

   pragma Assertion_Policy (Check);

   use Creations;
   use Information_Tasks;
   use Inputs;
   use Ada.Exceptions;

   procedure GLFW3_Key_Callback (W : GLFW3.Windows.Window; K : GLFW3.Windows.Keys.Key; Scancode : Interfaces.C.int; A : GLFW3.Windows.Keys.Key_Action; Mods : Interfaces.C.int) with
     Convention => C;
   procedure GLFW3_Key_Callback (W : GLFW3.Windows.Window; K : GLFW3.Windows.Keys.Key; Scancode : Interfaces.C.int; A : GLFW3.Windows.Keys.Key_Action; Mods : Interfaces.C.int) is
   begin
      null;
   end;

   procedure Init (A : Application);
   procedure Init (A : Application) is
      use GLFW3.Windows.Keys;
   begin
      null;
      --Set_Key_Callback_Procedure (A.Main_Window, GLFW3_Key_Callbacks.GLFW3_Key_Callback'Access);
   end;

   A : aliased Application;
   T : Information_Task (A'Access);
   Tex : Simple_Text_Render.Text_Render;


   procedure Init_Context is

   begin
      Initialize_Context (A, False);

      Simple_Text_Render.Load_Texture (Tex);
   end;

   procedure Destroy_Context is
   begin
      Destroy (A);
   end;


begin

   GLFW3.Initialize;
   Initialize_Logic (A);
   Init_Context;

   GLFW3.Windows.Keys.Set_Key_Callback_Procedure (A.Main_Window, Applications.Main_Key_Callbacks.Key_Callback'Access);

   loop
      delay 0.01;
      declare
         use GLFW3.Windows.Keys;
      begin
         if Get_Key (A.Main_Window, Key_F12) = Key_Action_Press then
            Destroy_Context;
            Init_Context;
         end if;
         if Get_Key (A.Main_Window, Key_F11) = Key_Action_Press then
            Destroy_Context;
            Init_Context;
         end if;
      end;

      GL.Drawings.Clear (GL.Drawings.Color_Plane);
      GL.Drawings.Clear (GL.Drawings.Depth_Plane);
      Get_Camera_Input (A);
      Simple_Text_Render.Render (A.Main_Window, Tex);
      Render_Stuff (A);
      GLFW3.Poll_Events;
      GLFW3.Windows.Swap_Buffers (A.Main_Window);
      exit when Window_Closing (A);
   end loop;


   Destroy_Context;
   delay 2.0;
   T.Quit;
   GLFW3.Terminate_GLFW3;

exception
   when E : others =>
      Simple_Debug_Systems.Enqueue (1, "Error count: " & GL.Errors.Error_Vector.Length'Img);
      for Er of GL.Errors.Error_Vector loop
         Simple_Debug_Systems.Enqueue (1, Er'Img);
      end loop;
      Simple_Debug_Systems.Enqueue (1, Exception_Message (E));
end;
