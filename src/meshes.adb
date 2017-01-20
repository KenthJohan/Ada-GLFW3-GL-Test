with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Numerics.Elementary_Functions;
--with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics;

package body Meshes is

   --package Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions (GL.C.GLfloat);

   procedure Put (Item : Vector) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      for E of Item loop
         Put (Float (E), 3, 3, 0);
      end loop;
   end;

   procedure Put (Item : Vertex) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      Put (Item.Pos);
      Put (" : ");
      Put (Item.Col);
   end;

   procedure Put (Item : Vertex_Array) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      for E of Item loop
         Put (E);
         New_Line;
      end loop;
   end;

   procedure Setup (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use GL.Vertex_Attributes;
      Pos_Loc_Index : constant Location := Use_Index (0);
      Col_Loc_Index : constant Location := Use_Index (1);
   begin
      Item.VBO := Generate;
      Item.VAO := Generate;
      Bind (Item.VAO);
      Bind (Array_Slot, Item.VBO);
      Set (Pos_Loc_Index, Vector_3'Length, Float_Type, False, Bit_Unit (Vertex_Array'Component_Size), Bit_Unit (0));
      Set (Col_Loc_Index, Vector_4'Length, Float_Type, False, Bit_Unit (Vertex_Array'Component_Size), Bit_Unit (Vector_3'Size));
      Enable (Pos_Loc_Index);
      Enable (Col_Loc_Index);
   end;


   procedure Draw (Item : Mesh) is
   begin
      GL.Vertex_Attributes.Bind (Item.VAO);
      GL.Drawings.Draw (Item.Draw_Mode, 0, Integer (Item.Data.Last));
      null;
   end;


   procedure Make_Triangle (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use type GL.C.GLfloat;
      use Vertex_Vectors;
   begin
      Item.Draw_Mode := GL.Drawings.Triangles_Mode;
      Append (Item.Data, Vertex'((0.5, -0.5, 0.0), (1.0, 0.0, 0.0, 1.0)));
      Append (Item.Data, Vertex'((-0.5, -0.5, 0.0), (0.0, 1.0, 0.0, 1.0)));
      Append (Item.Data, Vertex'((0.0,  0.5, 0.0), (0.0, 0.0, 1.0, 1.0)));
      Bind (Array_Slot, Item.VBO);
      Allocate (Array_Slot, Bit_Unit (Data_Size (Item.Data)), Static_Usage);
      Redefine (Array_Slot, 0, Bit_Unit (Data_Size (Item.Data)), Data_Address (Item.Data));
--        declare
--           X : Vertex_Array (1 .. Integer (Item.Data.Length)) with Address => Item.Data'Address;
--        begin
--           Put (X);
--        end;
   end;

   procedure Make_Grid_Lines (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use GL.C;
      use Vertex_Vectors;
      D : constant GLfloat := 10.0;
   begin
      Item.Draw_Mode := GL.Drawings.Line_Strip_Mode;
      for I in 1 .. 10 loop
         Append (Item.Data, Vertex'((0.0, 0.0, GLfloat (I)), (0.0, 0.0, 1.0, 1.0)));
         Append (Item.Data, Vertex'((D, 0.0, GLfloat (I)), (0.0, 0.0, 1.0, 1.0)));
         Append (Item.Data, Vertex'((GLfloat (I), 0.0, 0.0), (0.0, 0.0, 1.0, 1.0)));
         Append (Item.Data, Vertex'((GLfloat (I), 0.0, D), (0.0, 0.0, 1.0, 1.0)));
      end loop;


      Bind (Array_Slot, Item.VBO);
      Allocate (Array_Slot, Bit_Unit (Data_Size (Item.Data)), Static_Usage);
      Redefine (Array_Slot, 0, Bit_Unit (Data_Size (Item.Data)), Data_Address (Item.Data));
   end;


   procedure Make_Sin (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use GL.C;
      use Vertex_Vectors;
      use Ada.Numerics.Elementary_Functions;
      use Ada.Numerics;
   begin
      Item.Draw_Mode := GL.Drawings.Line_Strip_Mode;
      for I in 1 .. 40 loop
         Append (Item.Data, Vertex'((0.0, GLfloat (Sin (Float (I))), GLfloat (I)), (0.0, 1.0, 1.0, 1.0)));
      end loop;

      Bind (Array_Slot, Item.VBO);
      Allocate (Array_Slot, Bit_Unit (Data_Size (Item.Data)), Static_Usage);
      Redefine (Array_Slot, 0, Bit_Unit (Data_Size (Item.Data)), Data_Address (Item.Data));
   end;

end;
