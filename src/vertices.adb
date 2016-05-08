package body Vertices is

   procedure Setup_Vertex_Attribute is
      VAO : constant Config := Generate;
      Pos_Loc_Index : constant Location := Use_Index (0);
      Col_Loc_Index : constant Location := Use_Index (1);
   begin
      Bind (VAO);
      Set (Pos_Loc_Index, Vector_3'Length, Float_Type, False, Bit (Vertex_Array'Component_Size), Bit (0));
      Set (Col_Loc_Index, Vector_4'Length, Float_Type, False, Bit (Vertex_Array'Component_Size), Bit (Vector_3'Size));
      Enable (Pos_Loc_Index);
      Enable (Col_Loc_Index);
   end;

end;
