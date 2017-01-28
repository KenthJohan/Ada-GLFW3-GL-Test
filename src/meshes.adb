with System;
with GL.C;
with GL.C.Complete;

package body Meshes is

   procedure Update (Item : in out Mesh) is
      use GL;
      use GL.Vertex_Array_Objects;
      use GL.Buffers;
      use GL.C;
      use GL.C.Complete;
      use System;
      use Vertex_Vectors;
      use type GL.C.GLuint;
      use type GL.C.GLsizei;
      Stride : constant GLsizei := Vertex_Array'Component_Size / Storage_Unit;
   begin
      case Item.Status is
         when Under_Construction_Status =>
            null;
         when GPU_Setup_Status =>
            Item.Vertex_Array_Name := Create_Attribute;
            Item.Buffer_Name := Generate;
            Set_Attribute_Enable (Item.Vertex_Array_Name, 0);
            Set_Attribute_Enable (Item.Vertex_Array_Name, 1);
            Set_Attribute_Memory_Layout (Item.Vertex_Array_Name, 0, Float_Vector3'Length, Float_Type, False, 0);
            Set_Attribute_Memory_Layout (Item.Vertex_Array_Name, 1, Float_Vector4'Length, Float_Type, False, Float_Vector3'Size / Storage_Unit);
            glVertexArrayAttribBinding (GLuint (Item.Vertex_Array_Name), 0, 0);
            glVertexArrayAttribBinding (GLuint (Item.Vertex_Array_Name), 1, 0);
            glVertexArrayVertexBuffer (GLuint (Item.Vertex_Array_Name), 0, GLuint (Item.Buffer_Name), 0, Stride);
            Bind (Array_Slot, Item.Buffer_Name);
            Allocate_Uninitialized_Bits (Array_Slot, Data_Size (Item.Data), Static_Usage);
            Redefine_Bits (Array_Slot, 0, Data_Size (Item.Data), Data_Address (Item.Data));
            Item.Status := GPU_Render_Status;
         when GPU_Render_Status =>
            Bind (Item.Vertex_Array_Name);
            GL.Drawings.Draw (Item.Draw_Mode, 0, Integer (Item.Data.Last));
      end case;
   end;

   procedure Update (List : in out Mesh_Vectors.Vector) is
   begin
      for E : Mesh of List loop
         Update (E);
      end loop;
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
   end;

   procedure Make_Grid_Lines (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use Vertex_Vectors;
      D : constant GLfloat := 10.0;
   begin
      --Item.Draw_Mode := GL.Drawings.Line_Strip_Mode;
      Item.Draw_Mode := GL.Drawings.Lines_Mode;
      for I in 1 .. 10 loop
         Append (Item.Data, Vertex'((0.0, 0.0, GLfloat (I)), (0.0, 0.0, 1.0, 1.0)));
         Append (Item.Data, Vertex'((D, 0.0, GLfloat (I)), (0.0, 0.0, 1.0, 1.0)));
         Append (Item.Data, Vertex'((GLfloat (I), 0.0, 0.0), (0.0, 0.0, 1.0, 1.0)));
         Append (Item.Data, Vertex'((GLfloat (I), 0.0, D), (0.0, 0.0, 1.0, 1.0)));
      end loop;
   end;


   procedure Make_Sin (Item : in out Mesh) is
      use GL;
      use GL.Buffers;
      use Vertex_Vectors;
   begin
      Item.Draw_Mode := GL.Drawings.Line_Strip_Mode;
      for I in 1 .. 40 loop
         Append (Item.Data, Vertex'((0.0, Elementary_Functions.Sin (GLfloat (I)), GLfloat (I)), (0.0, 1.0, 1.0, 1.0)));
      end loop;
   end;



end;
