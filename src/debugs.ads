with Ada.Strings.Unbounded;

package Debugs is

   use Ada.Strings.Unbounded;

   type Queue_Element is record
      Priority : Natural;
      Content  : Unbounded_String;
   end record;

   procedure Enqueue (Priority : Natural; Item : String);

   procedure Put_Lines;


end Debugs;
