with Applications.Information_Tasks;
with Applications.Inputs;


procedure Applications.Main is

   use Information_Tasks;
   use Inputs;

   A : aliased Application;
   T : Information_Task (A'Access);

begin

   Initialize (A);

   loop
      delay 0.01;
      Get_Camera_Input (A);
      Render_Stuff (A);
      Poll_Events (A);
      Swap_Buffers (A);
      exit when Window_Closing (A);
   end loop;
   Quit (A);
   delay 2.0;
   T.Quit;


end;
