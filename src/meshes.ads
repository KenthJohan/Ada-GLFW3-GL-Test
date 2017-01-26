with GL.Buffers;
with GL.Vertex_Array_Objects;
with GL.Drawings;
with GL.Math;
with Generic_Vectors;

package Meshes is

   use GL.Math;

   type Vertex is record
      Pos : Float_Vector3 := (0.0, 0.0, 0.0);
      Col : Float_Vector4 := (0.0, 0.0, 0.0, 0.0);
   end record;

   type Vertex_Array is array (Positive range <>) of Vertex;

   package Vertex_Vectors is new Generic_Vectors (Positive, Vertex);
   subtype Vertex_Vector is Vertex_Vectors.Vector;

   type Mesh (Count : Natural) is record
      Vertex_Array_Name : GL.Vertex_Array_Objects.Vertex_Array_Object := GL.Vertex_Array_Objects.Create_Attribute;
      Buffer_Name : GL.Buffers.Buffer := GL.Buffers.Generate;
      Data : Vertex_Vector (2000);
      Draw_Mode : GL.Drawings.Mode;
      Dummy : Boolean;
   end record;

   procedure Setup (Item : in out Mesh);
   procedure Draw (Item : Mesh);
   procedure Make_Grid_Lines (Item : in out Mesh);
   procedure Make_Triangle (Item : in out Mesh);
   procedure Make_Sin (Item : in out Mesh);


end;
