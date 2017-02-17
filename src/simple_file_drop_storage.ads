with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;


package Simple_File_Drop_Storage is


   use Ada.Strings.Unbounded;

   type Dropped_File is record
      File_Name : Unbounded_String;
      Ext_Name : Unbounded_String;
   end record;

   package Dropped_File_Vectors is new Ada.Containers.Vectors (Positive, Dropped_File);
   subtype Dropped_File_Vector is Dropped_File_Vectors.Vector;



   procedure Append (Item : in out Dropped_File_Vector; File_Name : String);
   procedure Put_Lines (Item : in out Dropped_File_Vector);



end;
