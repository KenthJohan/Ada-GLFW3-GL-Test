with Ada.Text_IO;
with Ada.Strings.Fixed;

package body Inputs is

   procedure Put_State (W : Window; Item : Binding_Array) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
   begin
      for I in Action loop
         Put (Head (Action'Image (I), 30));
         Put (" ");
         Put (Key_Action'Image (Keys.Get_Key (W, Item (I))));
         New_Line;
      end loop;
   end;

end;
