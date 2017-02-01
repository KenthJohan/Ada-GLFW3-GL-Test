with GL.Math;
with Generic_Vectors;
with GL.Colors;

package Vertices is

   use GL.Math;
   use GL.Colors.Colors_RGBA;

   type Vertex is record
      Pos : Float_Vector3 := (0.0, 0.0, 0.0);
      Col : Color_Amount_Vector := (0.0, 0.0, 0.0, 0.0);
   end record;

   type Vertex_Array is array (Positive range <>) of Vertex;

   package Vertex_Vectors is new Generic_Vectors (Vertex);
   subtype Vertex_Vector is Vertex_Vectors.Vector;

   procedure Set_Random_Color (Item : out Vertex);

   procedure Make_1 (V : in out Vertex_Vector; D : GLfloat; Count : Natural);

   procedure Translate (V : in out Vertex_Vector; T : Float_Vector3);
   procedure Transform (V : in out Vertex_Vector; T : Float_Matrix3);

end;
