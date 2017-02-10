package Applications.Information_Tasks is

   task type Information_Task (Item_Application : access Application) is
      entry Pause;
      entry Resume;
      entry Quit;
   end;

end;
