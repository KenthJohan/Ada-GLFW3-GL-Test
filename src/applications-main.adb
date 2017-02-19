with Applications.Information_Tasks;
with Applications.Inputs;
with Applications.Creations;
with Applications.Main_Key_Callbacks;
with Applications.Main_Drop_Callbacks;

with GL.Drawings;
with GL.Errors;
with GL.Math;

with GLFW3.Windows.Keys;
with GLFW3.Windows.Drops;

with Simple_Text_Render;

with Ada.Exceptions;
with Ada.Unchecked_Conversion;

with Interfaces;
with Interfaces.C;

with System;



procedure Applications.Main is

   pragma Assertion_Policy (Check);

   use Creations;
   use Information_Tasks;
   use Inputs;
   use Ada.Exceptions;
   use type GLFW3.Windows.Keys.Key_Action;

   use type GL.Math.Real_Float;



   A : aliased Application;
   T : Information_Task (A'Access);
   Tex : Simple_Text_Render.Text_Render;


   procedure Init_Context is
   begin
      Initialize_Context (A, False);
      GLFW3.Windows.Keys.Set_Key_Callback_Procedure (A.Main_Window, Applications.Main_Key_Callbacks.Key_Callback'Access);
      GLFW3.Windows.Drops.Set_Drop_Callback (A.Main_Window, Applications.Main_Drop_Callbacks.drop_callback'Access);
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



   loop
      delay 0.01;

      Simple_Moving_Averages.Update (A.Main_SMA, 100);

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

      Simple_Text_Render.Render_Text (Tex, -1.0, -1.0, 0.1, 0.1, GLFW3.Clock'Img);
      Simple_Text_Render.Render_Text (Tex, -1.0, -0.9, 0.1, 0.1, Simple_Moving_Averages.Diff (A.Main_SMA)'Img);

--        if GLFW3.Windows.Keys.Get_Key (A.Main_Window, GLFW3.Windows.Keys.Key_Kp_0) = GLFW3.Windows.Keys.Key_Action_Press then
--           Simple_Text_Render.Render_Char (Tex, 0);
--        end if;
--        if GLFW3.Windows.Keys.Get_Key (A.Main_Window, GLFW3.Windows.Keys.Key_Kp_1) = GLFW3.Windows.Keys.Key_Action_Press then
--           Simple_Text_Render.Render_Char (Tex, 1);
--        end if;
--        if GLFW3.Windows.Keys.Get_Key (A.Main_Window, GLFW3.Windows.Keys.Key_Kp_2) = GLFW3.Windows.Keys.Key_Action_Press then
--           Simple_Text_Render.Render_Char (Tex, 2);
--        end if;


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
