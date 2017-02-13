with Applications.Information_Tasks;
with Applications.Inputs;
with Applications.Creations;

with GLFW3.Windows.Keys;

with Simple_Text_Render;

with Ada.Exceptions;
with GL.Drawings;
with GL.Errors;

procedure Applications.Main is

   pragma Assertion_Policy (Check);

   use Creations;
   use Information_Tasks;
   use Inputs;
   use Ada.Exceptions;


   A : aliased Application;
   T : Information_Task (A'Access);

   Tex : Simple_Text_Render.Text_Render;

begin

   GLFW3.Initialize;

   Initialize_Logic (A);

   Initialize_Context (A, False);


   Simple_Text_Render.Load_Texture (Tex);


   loop
      delay 0.01;
      declare
         use GLFW3.Windows.Keys;
      begin
         if Get_Key (A.Main_Window, Key_F12) = Key_Action_Press then
            Destroy (A);
            Initialize_Context (A, True);
         end if;
         if Get_Key (A.Main_Window, Key_F11) = Key_Action_Press then
            Destroy (A);
            Initialize_Context (A, False);
         end if;
      end;
      GL.Drawings.Clear (GL.Drawings.Color_Plane);
      GL.Drawings.Clear (GL.Drawings.Depth_Plane);
      Get_Camera_Input (A);
      Simple_Text_Render.Render (Tex);
      Render_Stuff (A);
      GLFW3.Poll_Events;
      GLFW3.Windows.Swap_Buffers (A.Main_Window);
      exit when Window_Closing (A);
   end loop;


   Destroy (A);
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
