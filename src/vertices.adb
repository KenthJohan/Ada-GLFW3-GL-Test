with Ada.Numerics.Float_Random;
with GL.C;


package body Vertices is

   procedure Set_Random (Item : out Color_Amount_Vector) is
      use Ada.Numerics.Float_Random;
      G : Generator;
   begin
      Reset (G);
      for E of Item loop
         E := Color_Amount (Random (G));
      end loop;
   end;

   procedure Set_Random_Color (Item : out Vertex) is
   begin
      Set_Random (Item.Col);
   end;

   procedure Make_1 (V : in out Vertex_Vector) is
      use type GL.C.GLfloat;
   begin
      V.Append;
      V.Last_Element.Pos := (-1.0, 0.0, 0.0);
   end;

end;
