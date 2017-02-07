with GL.Buffers;
with GL.Vertex_Array_Objects;
with GL.Drawings;
with Vertices;
with Generic_Vectors;

package Meshes is

   use Vertices;



   type Mesh_State is (Setup_Mesh_State, Draw_Mesh_State, Hide_Mesh_State);

   type Section is record
      First : Vertex_Vectors.Base_Index := 0;
      Last : Vertex_Vectors.Base_Index := 0;
      Count : Vertex_Vectors.Count := 0;
      Draw_Mode : GL.Drawings.Mode := GL.Drawings.Line_Strip_Mode;
      State : Mesh_State := Setup_Mesh_State;
   end record;

   package Section_Vectors is new Generic_Vectors (Section);
   subtype Section_Vector is Section_Vectors.Vector;

   type Mesh is record
      Dummy1 : Boolean := False;
      VAO : GL.Vertex_Array_Objects.Vertex_Array_Object;
      VBO : GL.Buffers.Buffer;
      Vertex_List : Vertex_Vector (10000);
      Section_List : Section_Vector (10000);
   end record;

   package Mesh_Vectors is new Generic_Vectors (Meshes.Mesh);
   subtype Mesh_Vector is Mesh_Vectors.Vector;

   procedure Update (Item : in out Mesh);
   procedure Setup (Item : in out Mesh);

--     procedure Start_Append (Item : in out Mesh);
--     procedure Stop_Append (Item : in out Mesh);
--     procedure Append (Item : in out Mesh; V : Vertex);
--     procedure Draw (Item : in out Mesh);
--     procedure Make_Grid_Lines (Item : in out Mesh);
       procedure Make_Triangle (Item : in out Mesh);
--     procedure Make_Sin (Item : in out Mesh);


end;
