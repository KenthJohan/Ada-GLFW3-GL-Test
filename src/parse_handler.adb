with GL.Math;
with GL.Drawings;

with Interfaces;
with Interfaces.C.Strings;

with Ada.Exceptions;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Ada.Text_IO;
with Vertices;
with GL.Colors;


package body Parse_Handler is

   package Unbounded_String_Vectors is new Ada.Containers.Vectors (Positive, Ada.Strings.Unbounded.Unbounded_String, Ada.Strings.Unbounded."=");

   Name_List : Unbounded_String_Vectors.Vector;

   Key_Pad_List_Current : Natural range Key_Pad_List'Range:= Key_Pad_List'First;

   procedure drop_callback (W : GLFW3.Window; Count : Interfaces.C.int; Paths : GLFW3.Windows.Drops.File_Path_List) is
      pragma Unreferenced (W);
      use Interfaces.C;
      use Interfaces.C.Strings;
      use Ada.Text_IO;
      use Ada.Strings.Unbounded;
   begin
      Put_Line ("Count: " & Count'Img);
      for I in size_t (0) .. size_t (Count - 1) loop
         declare
            Name : constant String := Value (Paths (I));
         begin
            Unbounded_String_Vectors.Append (Name_List, To_Unbounded_String (Name));
            Put_Line ("Unbounded_String_Vectors.Append");
            --Parse (Name);
            --New_Line (2);
         end;
      end loop;
      Put_Line ("Parse_Task.Start");
      Parse_Task.Start;
   exception
      when E : Constraint_Error =>
         Put_Line (Ada.Exceptions.Exception_Message (E));
   end;

   procedure Parse (File_Name : String) is
      package Mode_Text_IO is new Ada.Text_IO.Enumeration_IO (GL.Drawings.Mode);
      use Ada.Text_IO;
      use Mode_Text_IO;
      use Vertices;
      use GL.Math;
      use GL.Colors;
      M : GL.Drawings.Mode;
      F : File_Type;
      Me : Meshes.Mesh;
   begin
      Open (F, In_File, File_Name);
      while not End_Of_File (F) loop
         Put_Line ("Get");
         --Me.Data.Append;
         Get (F, M);
         --Get (F, Float_Vector (Me.Data.Last_Element.Pos));
         --Colors_RGBA.Get (F, Me.Data.Last_Element.Col);
         Skip_Line (F);
--           Put (M);
--           Put (V.Pos (1));
--           Put (V.Pos (2));
--           Put (V.Pos (3));
--           Put (V.Col (1));
--           Put (V.Col (2));
--           Put (V.Col (3));
--           Put (V.Col (4));
--           New_Line;
      end loop;
      Close (F);

      --Me.Draw_Mode := GL.Drawings.Line_Strip_Mode;
      Meshes.Mesh_Vectors.Append (Mesh_List, Me);
      Key_Pad_List (Key_Pad_List_Current) := Mesh_List.Last_Index;
      Key_Pad_List_Current := Key_Pad_List_Current + 1;
   exception
      when E : others =>
         Put_Line (Ada.Exceptions.Exception_Message (E));
   end;

   task body Parse_Task is
      use Ada.Text_IO;
      use Ada.Strings.Unbounded;
   begin
      loop
         select

            accept Start;
            Put_Line ("Parse_Task Start: accept Start");
            for E : Unbounded_String of Name_List loop
               Put ("File open: ");
               Put_Line (To_String (E));
               New_Line;
               Parse (To_String (E));
            end loop;
            Name_List.Clear;

         or

            accept Quit;
            exit;

         end select;
      end loop;
      Put_Line ("Parse_Task Quit: ");
   end;


   procedure Hide (I : Natural) is
      use Meshes;
   begin
      null;
--        if Parse_Handler.Mesh_List.Exists (Parse_Handler.Key_Pad_List (I)) then
--           if Parse_Handler.Mesh_List (Parse_Handler.Key_Pad_List (I)).State = Draw_Mesh_State then
--              Parse_Handler.Mesh_List (Parse_Handler.Key_Pad_List (I)).State := Hide_Mesh_State;
--           elsif Parse_Handler.Mesh_List (Parse_Handler.Key_Pad_List (I)).State = Hide_Mesh_State then
--              Parse_Handler.Mesh_List (Parse_Handler.Key_Pad_List (I)).State := Draw_Mesh_State;
--           end if;
--        end if;
   end;

end;
