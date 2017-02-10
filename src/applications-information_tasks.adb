with Ada.Real_Time;
with Ada.Text_IO;
with Simple_Debug_Systems;

package body Applications.Information_Tasks is


   task body Information_Task is
      --package Time_Span_IO is new Ada.Text_IO.Integer_IO (Duration);
      use Ada.Real_Time;
      use Ada.Text_IO;
      use Simple_Debug_Systems;
   begin
      loop
         select
            accept Pause;
            accept Resume;
         or
            accept Quit;
            exit;
         or
            delay 1.0;
            null;
         end select;
         Put ("Time span :");
         Put (Duration'Image (To_Duration (Simple_Moving_Averages.Diff (Item_Application.Main_SMA))));
         New_Line;
         Simple_Debug_Systems.Put_Lines_Dequeue (Item_Application.Main_Debug_Queue);
         Simple_Debug_Systems.Put_Lines_Dequeue;
         Simple_File_Drop_Storage.Put_Lines_Dequeue (Item_Application.Main_Dropped_Files_Queue);
--           New_Line;
--           Inputs.Put_State (A.Main_Window, A.Main_Binding_Array);
--           OS_Systems.Clear_Screen;
--           Put (A.Main_Camera.Projection_Matrix);
--           New_Line;
--           Put (A.Main_Camera.Rotation_Matrix);
--           New_Line;
--           Put (A.Main_Camera.Translation_Matrix);
--           New_Line;
--           Put (A.Main_Camera.Result_Matrix);
--           New_Line;
      end loop;
   end;

end;
