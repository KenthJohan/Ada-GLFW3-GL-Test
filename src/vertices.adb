with GL.Vertex_Attributes;

package body Vertices is

   procedure Setup_Vertex_Attribute is
      use GL.Vertex_Attributes;
      VAO : constant Config := Generate;
      Pos_Loc_Index : constant Location := Use_Index (0);
      Col_Loc_Index : constant Location := Use_Index (1);
   begin
      Bind (VAO);
      Set (Pos_Loc_Index, Vector_3'Length, Float_Type, False, Bit_Unit (Vertex_Array'Component_Size), Bit_Unit (0));
      Set (Col_Loc_Index, Vector_4'Length, Float_Type, False, Bit_Unit (Vertex_Array'Component_Size), Bit_Unit (Vector_3'Size));
      Enable (Pos_Loc_Index);
      Enable (Col_Loc_Index);
   end;

end;
