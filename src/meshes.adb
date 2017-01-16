package body Meshes is

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
      GL.Drawings.Draw (Item.Draw_Mode, Item.First, Item.Count);
      null;
   end;


   procedure Make_Triangle (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use type GL.C.GLfloat;
   begin
      Item.Draw_Mode := GL.Drawings.Triangle_Mode;
      Item.First := 0;
      Item.Count := 3;
      Item.Data (1).Pos := (0.5, -0.5, 0.0);
      Item.Data (1).Col := (1.0, 0.0, 0.0, 1.0);
      Item.Data (2).Pos := (-0.5, -0.5, 0.0);
      Item.Data (2).Col := (0.0, 1.0, 0.0, 1.0);
      Item.Data (3).Pos := (0.0,  0.5, 0.0);
      Item.Data (3).Col := (0.0, 0.0, 1.0, 1.0);
      Bind (Array_Slot, Item.VBO);
      Allocate (Array_Slot, Bit_Unit (Item.Data'Size), Static_Usage);
      Redefine (Array_Slot, 0, Bit_Unit (Item.Data'Size), Item.Data'Address);
   end;

   procedure Make_Grid_Lines (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use type GL.C.GLfloat;
      --D : GL.C.GLfloat := 0.1;
   begin
      Item.Draw_Mode := GL.Drawings.Line_Mode;
      Item.First := 0;
      Item.Count := 4;
      Item.Data (1).Pos := (0.0, 0.0, 0.0);
      Item.Data (1).Col := (0.0, 0.0, 1.0, 1.0);
      Item.Data (2).Pos := (10000.0, 0.0, 0.0);
      Item.Data (2).Col := (0.0, 0.0, 1.0, 1.0);

      Item.Data (3).Pos := (0.0, 1.0, 0.0);
      Item.Data (3).Col := (0.0, 0.0, 1.0, 1.0);
      Item.Data (4).Pos := (10000.0, 1.0, 0.0);
      Item.Data (4).Col := (0.0, 0.0, 1.0, 1.0);

      Bind (Array_Slot, Item.VBO);
      Allocate (Array_Slot, Bit_Unit (Item.Data'Size), Static_Usage);
      Redefine (Array_Slot, 0, Bit_Unit (Item.Data'Size), Item.Data'Address);

--        for I in 1 .. 20 loop
--           declare
--              X : GL.C.GLfloat := GL.C.GLfloat (I) / 10.0;
--              Y : GL.C.GLfloat := GL.C.GLfloat (I mod 10);
--           begin
--              Item.Data (I + 0).Col := (1.0, 0.0, 0.0, 1.0);
--              Item.Data (I + 1).Col := (1.0, 0.2, 0.0, 1.0);
--              Item.Data (I + 2).Col := (1.0, 0.2, 0.0, 1.0);
--              Item.Data (I + 0).Pos := (X + D, Y + D, 0.8);
--              Item.Data (I + 1).Pos := (X + D, Y - D, 0.8);
--              Item.Data (I + 2).Pos := (X - D, Y + D, 0.8);
--           end;
--        end loop;
   end;

end;
