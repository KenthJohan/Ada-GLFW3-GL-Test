--with Ada.Text_IO;

with GL.Math;
with GL.C.Complete;

with System;

with Simple_Debug_Systems;

package body Mesh_Handler_Basic is

   procedure Initialize (Item : in out Mesh) is
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
      Simple_Debug_Systems.Enqueue (1, "GPU Init Mesh Storage");
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


   procedure Initialize (Item : in out Mesh_Vector) is
   begin
      for E of Item loop
         if E.Main_Mesh_Status = Uninitialized_Mesh_Status then
            Initialize (E);
            E.Main_Mesh_Status := Contruction_Mesh_Status;
         end if;
      end loop;
      null;
   end;


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
      Item.Dummy1 := False;
      Simple_Debug_Systems.Enqueue (1, "GPU Load Mesh");
      Redefine_Storage (Item.VBO, 0, Item.Vertex_List.Data_Size / Storage_Unit, Item.Vertex_List.Data_Address);
   end;

   procedure Update (Item : in out Mesh) is
   begin
      if Item.Main_Mesh_Status = GPU_Load_Mesh_Status then
         GPU_Load (Item);
         Item.Main_Mesh_Status := Draw_Mesh_Status;
      end if;
   end;

   procedure Update (Item : in out Mesh_Vector) is
   begin
      for E of Item loop
         if E.Main_Mesh_Status = GPU_Load_Mesh_Status then
            GPU_Load (E);
            E.Main_Mesh_Status := Draw_Mesh_Status;
            exit;
         end if;
      end loop;
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










   procedure Make_Triangle (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use type GL.C.GLfloat;
   begin
      Item.Main_Mesh_Status := Contruction_Mesh_Status;
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

   procedure Make_Grid_Lines (Item : in out Mesh; Size : GL.C.GLfloat; Stride : GL.C.GLfloat) is
      use GL;
      use GL.Buffers;
      use type GL.C.GLfloat;
      use GL.C;
      Count : constant Natural := Natural (Size / Stride);
      X1 : GLfloat;
   begin
      Item.Main_Mesh_Status := Contruction_Mesh_Status;
      Item.Draw_Mode := GL.Drawings.Lines_Mode;
      for I in -Count .. Count loop
         X1 := Stride * GLfloat (I);
         Item.Vertex_List.Append;
         Item.Vertex_List.Last_Element.Pos := (X1, -Size, 0.0);
         Item.Vertex_List.Last_Element.Col := (1.0, 1.0, 1.0, 0.4);
         Item.Vertex_List.Append;
         Item.Vertex_List.Last_Element.Pos := (X1, Size, 0.0);
         Item.Vertex_List.Last_Element.Col := (1.0, 1.0, 1.0, 0.4);
         Item.Vertex_List.Append;
         Item.Vertex_List.Last_Element.Pos := (-Size, X1, 0.0);
         Item.Vertex_List.Last_Element.Col := (1.0, 1.0, 1.0, 0.4);
         Item.Vertex_List.Append;
         Item.Vertex_List.Last_Element.Pos := (Size, X1, 0.0);
         Item.Vertex_List.Last_Element.Col := (1.0, 1.0, 1.0, 0.4);
      end loop;
      Item.Main_Mesh_Status := GPU_Load_Mesh_Status;
   end;













end;
