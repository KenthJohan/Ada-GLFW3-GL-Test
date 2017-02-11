package Applications.Creations is

   procedure Initialize_Context (Item : in out Application; Fullscreen : Boolean);
   procedure Initialize_Logic (Item : in out Application);

   function Window_Closing (Item : in out Application) return Boolean;
   procedure Swap_Buffers (Item : Application);
   procedure Poll_Events (Item : Application);
   procedure Destroy (Item : in out Application);
   procedure Render_Stuff (Item : in out Application);

end;
