with Vertices;
with GL.Vertex_Array_Objects;
with GL.Buffers;
with GL.Drawings;
with Generic_Vectors;

package Mesh_Handler_Basic is

   type Mesh_Status is (Dormant_Mesh_Status, GPU_Load_Mesh_Status, Draw_Mesh_Status);

   type Mesh is record
      Dummy1 : Boolean := False;
      VAO : GL.Vertex_Array_Objects.Vertex_Array_Object;
      VBO : GL.Buffers.Buffer;
      Vertex_List : Vertices.Vertex_Vector (10000);
      Draw_Mode : GL.Drawings.Mode := GL.Drawings.Line_Strip_Mode;
      Main_Mesh_Status : Mesh_Status := Dormant_Mesh_Status;
   end record;

   package Mesh_Vectors is new Generic_Vectors (Mesh);
   subtype Mesh_Vector is Mesh_Vectors.Vector;


   procedure GPU_Load (Item : in out Mesh);
   procedure Make_Triangle (Item : in out Mesh);
   procedure Draw (Item : in out Mesh);

   procedure Draw (Item : in out Mesh_Vector);
   procedure GPU_Load (Item : in out Mesh_Vector);

end;
