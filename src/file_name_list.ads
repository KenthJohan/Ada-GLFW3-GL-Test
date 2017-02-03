with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;


package File_Name_List is


   package Unbounded_String_Vectors is new Ada.Containers.Vectors (Positive, Ada.Strings.Unbounded.Unbounded_String, Ada.Strings.Unbounded."=");
   subtype Unbounded_String_Vector is Unbounded_String_Vectors.Vector;

   procedure Put_Info (Item : Unbounded_String_Vector);

end;
