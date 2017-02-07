with System;
with GL.C;
with GL.C.Complete;
with GL.Math;
--with Ada.Text_IO;
--with System.Storage_Elements;

package body Meshes is


   procedure Setup (Item : in out Mesh) is
      use GL;
      use GL.Vertex_Array_Objects;
      use GL.Buffers;
      use GL.C;
      use GL.C.Complete;
      use GL.Math;
      use System;
      use type GL.C.GLuint;
      use type GL.C.GLsizei;
   begin
      Item.VAO := Create_Attribute;
      Item.VBO := Create_Buffer;
      Set_Attribute_Enable (Item.VAO, 0);
      Set_Attribute_Enable (Item.VAO, 1);
      Set_Attribute_Memory_Layout (Item.VAO, 0, Float_Vector3'Length, Float_Type, False, 0);
      Set_Attribute_Memory_Layout (Item.VAO, 1, Float_Vector4'Length, Float_Type, False, Float_Vector3'Size / Storage_Unit);
      glVertexArrayAttribBinding (GLuint (Item.VAO), 0, 0);
      glVertexArrayAttribBinding (GLuint (Item.VAO), 1, 0);
      glVertexArrayVertexBuffer (GLuint (Item.VAO), 0, GLuint (Item.VBO), 0, Vertex_Array_Stride);
      Create_New_Storage (Item.VBO, Item.Vertex_List.Data_Size / Storage_Unit, System.Null_Address, Static_Usage);
   end;







--     procedure Update (List : in out Mesh_Vector) is
--     begin
--        for I in List.First_Index .. List.Last_Index loop
--           if List (I).State = Setup_Mesh_State then
--              Setup (List (I));
--              List (I).State := Draw_Mesh_State;
--              exit;
--           end if;
--        end loop;
--     end;
--
--
--     procedure Draw (List : in out Mesh_Vectors.Vector) is
--     begin
--        for I in List.First_Index .. List.Last_Index loop
--           if List (I).State = Draw_Mesh_State then
--              GL.Vertex_Array_Objects.Bind (List (I).VAO);
--              GL.Drawings.Draw (List (I).Draw_Mode, 0, Integer (List (I).Vertex_List.Last_Index));
--           end if;
--        end loop;
--     end;
--
--
--
--
--
--     procedure Draw (Item : in out Mesh) is
--     begin
--        for I in Item.C.First_Index .. Item.C.Last_Index loop
--           GL.Drawings.Draw (Item.C (I).Mode, Integer (Item.C (I).First), Integer (Item.C (I).Count));
--        end loop;
--     end;
--
--     procedure Append (Item : in out Handler; V : Vertices.Vertex) is
--     begin
--        Item.V.Append (V);
--     end;
--

   procedure Update (Item : in out Mesh) is
      --use System.Storage_Elements;
      --use Ada.Text_IO;
   begin
      Item.Dummy1 := False;
      for E : Section of Item.Section_List loop
         E.State := Setup_Mesh_State;
         if E.State = Setup_Mesh_State then
            --Redefine_Storage (Item.VBO, E.Count  Storage_Unit, System.Null_Address, Static_Usage);
            exit;
         end if;
--           Put_Line ("Section First" & E.First'Img);
--           Put_Line ("Section Last" & E.Last'Img);
--           Put_Line ("Section Count" & E.Count'Img);
      end loop;
   end;


   procedure Start_Append (Item : in out Mesh) is
      use type Vertices.Vertex_Vectors.Base_Index;
   begin
      Item.Section_List.Append;
      Item.Section_List.Last_Element.First := Item.Vertex_List.Last_Index + 1;
   end;


   procedure Stop_Append (Item : in out Mesh) is
      use type Vertices.Vertex_Vectors.Base_Index;
   begin
      Item.Section_List.Last_Element.Last := Item.Vertex_List.Last_Index;
      Item.Section_List.Last_Element.Count := Item.Section_List.Last_Element.Last - Item.Section_List.Last_Element.First + 1;
      Item.Section_List.Last_Element.State := Setup_Mesh_State;
   end;

   procedure Make_Triangle (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use type GL.C.GLfloat;
   begin
      Start_Append (Item);

      Item.Vertex_List.Append;
      Item.Vertex_List.Last_Element.Pos := (0.5, -0.5, 0.0);
      Item.Vertex_List.Last_Element.Col := (1.0, 0.0, 0.0, 1.0);
      Item.Vertex_List.Append;
      Item.Vertex_List.Last_Element.Pos := (-0.5, -0.5, 0.0);
      Item.Vertex_List.Last_Element.Col := (0.0, 1.0, 0.0, 1.0);
      Item.Vertex_List.Append;
      Item.Vertex_List.Last_Element.Pos := (0.0,  0.5, 0.0);
      Item.Vertex_List.Last_Element.Col := (0.0, 0.0, 1.0, 1.0);

      Stop_Append (Item);

   end;



--
--     procedure Make_Grid_Lines (Item : in out Mesh) is
--        use GL;
--        use GL.Buffers;
--        use GL.Math;
--        D : constant GLfloat := 10.0;
--     begin
--        --Item.Draw_Mode := GL.Drawings.Line_Strip_Mode;
--        Item.Draw_Mode := GL.Drawings.Lines_Mode;
--        for I in 1 .. 10 loop
--           Item.Data.Append;
--           Item.Data.Last_Element.Pos := (0.0, 0.0, GLfloat (I));
--           Item.Data.Last_Element.Col := (0.0, 0.0, 1.0, 1.0);
--           Item.Data.Append;
--           Item.Data.Last_Element.Pos := (D, 0.0, GLfloat (I));
--           Item.Data.Last_Element.Col := (0.0, 0.0, 1.0, 1.0);
--           Item.Data.Append;
--           Item.Data.Last_Element.Pos := (GLfloat (I), 0.0, 0.0);
--           Item.Data.Last_Element.Col := (0.0, 0.0, 1.0, 1.0);
--           Item.Data.Append;
--           Item.Data.Last_Element.Pos := (GLfloat (I), 0.0, D);
--           Item.Data.Last_Element.Col := (0.0, 0.0, 1.0, 1.0);
--        end loop;
--
--        Vertices.Make_1 (Item.Data, 1.0, 50);
--     end;
--
--     procedure Make_Sin (Item : in out Mesh) is
--        use GL;
--        use GL.Buffers;
--        use GL.Math;
--     begin
--        Item.Draw_Mode := GL.Drawings.Line_Strip_Mode;
--        for I in 1 .. 40 loop
--           Item.Data.Append;
--           Item.Data.Last_Element.Pos := (0.0, Elementary_Functions.Sin (GLfloat (I)), GLfloat (I));
--           Item.Data.Last_Element.Col := (0.0, 1.0, 1.0, 1.0);
--        end loop;
--     end;
--
--


end;
