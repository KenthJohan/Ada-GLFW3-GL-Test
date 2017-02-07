with GL.C;
with GL.Math;
with System;
with GL.C.Complete;

package body Mesh_Handler_Basic is

   procedure GPU_Load (Item : in out Mesh) is
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
      glVertexArrayVertexBuffer (GLuint (Item.VAO), 0, GLuint (Item.VBO), 0, Vertices.Vertex_Array_Stride);
      --Create_New_Storage (Item.VBO, Item.Vertex_List.Data_Size / Storage_Unit, System.Null_Address, Static_Usage);
      Create_New_Storage (Item.VBO, Item.Vertex_List.Data_Size / Storage_Unit, Item.Vertex_List.Data_Address, Static_Usage);
   end;


   procedure Make_Triangle (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use type GL.C.GLfloat;
   begin
      Item.Draw_Mode := GL.Drawings.Triangles_Mode;
      Item.Vertex_List.Append;
      Item.Vertex_List.Last_Element.Pos := (0.5, -0.5, 0.0);
      Item.Vertex_List.Last_Element.Col := (1.0, 0.0, 0.0, 1.0);
      Item.Vertex_List.Append;
      Item.Vertex_List.Last_Element.Pos := (-0.5, -0.5, 0.0);
      Item.Vertex_List.Last_Element.Col := (0.0, 1.0, 0.0, 1.0);
      Item.Vertex_List.Append;
      Item.Vertex_List.Last_Element.Pos := (0.0,  0.5, 0.0);
      Item.Vertex_List.Last_Element.Col := (0.0, 0.0, 1.0, 1.0);
      Item.Main_Mesh_Status := GPU_Load_Mesh_Status;
   end;

   procedure Draw (Item : in out Mesh) is
   begin
      Item.Dummy1 := False;
      GL.Vertex_Array_Objects.Bind (Item.VAO);
      GL.Drawings.Draw (Item.Draw_Mode, 0, Integer (Item.Vertex_List.Last_Index));
   end;

   procedure Draw (Item : in out Mesh_Vector) is
   begin
      for E of Item loop
         if E.Main_Mesh_Status = Draw_Mesh_Status then
            Draw (E);
         end if;
      end loop;
   end;

   procedure GPU_Load (Item : in out Mesh_Vector) is
   begin
      for E of Item loop
         if E.Main_Mesh_Status = GPU_Load_Mesh_Status then
            GPU_Load (E);
            E.Main_Mesh_Status := Draw_Mesh_Status;
            exit;
         end if;
      end loop;
   end;

end;
