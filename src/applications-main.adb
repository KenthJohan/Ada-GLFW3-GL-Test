with Applications.Information_Tasks;
with Applications.Inputs;
with Applications.Creations;

with GLFW3.Windows.Keys;


procedure Applications.Main is

   use Creations;
   use Information_Tasks;
   use Inputs;

   A : aliased Application;
   T : Information_Task (A'Access);

begin

   GLFW3.Initialize;

   Initialize_Logic (A);

   Initialize_Context (A, False);


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


      Get_Camera_Input (A);


      Render_Stuff (A);
      Poll_Events (A);
      Swap_Buffers (A);
      exit when Window_Closing (A);
   end loop;


   Destroy (A);
   delay 2.0;
   T.Quit;

   GLFW3.Terminate_GLFW3;

end;
