with Ada.Numerics.Float_Random;
with GL.C;
with GL.Colors;

package body Vertices is

   procedure Set_Random (Item : out Color_Amount_Vector) is
      use GL.Colors;
      use Ada.Numerics.Float_Random;
      G : Generator;
   begin
      Reset (G);
      for E of Item loop
         E := Random (G);
      end loop;
   end;

   procedure Set_Random_Color (Item : out Vertex) is
   begin
      Set_Random (Item.Col);
   end;

   procedure Make_1 (V : in out Vertex_Vector; D : GLfloat; Count : Natural) is
      use type GL.C.GLfloat;
      use GL.Colors;
      T : GLfloat;
   begin
      V.Append;
      V.Last_Element.Pos := (0.0, 0.0, 0.0);
      V.Last_Element.Col := Colors_RGBA.White_Color_Amount_Vector;
      V.Append;
      V.Last_Element.Pos := (D * GLfloat (Count), 0.0, 0.0);
      V.Last_Element.Col := Colors_RGBA.White_Color_Amount_Vector;

      for I in 0 .. Count - 1 loop
         if I mod 10 = 0 then
            T := 0.4;
         elsif I mod 5 = 0 then
            T := 0.2;
         else
            T := 0.1;
         end if;
         V.Append;
         V.Last_Element.Pos := (D * GLfloat (I), -1.0 * T, 0.0);
         V.Last_Element.Col := Colors_RGBA.White_Color_Amount_Vector;
         V.Append;
         V.Last_Element.Pos := (D * GLfloat (I), 1.0 * T, 0.0);
         V.Last_Element.Col := Colors_RGBA.White_Color_Amount_Vector;
      end loop;


      V.Append;
      V.Last_Element.Pos := (0.0, 0.0, 0.0);
      V.Last_Element.Col := Colors_RGBA.White_Color_Amount_Vector;
      V.Append;
      V.Last_Element.Pos := (0.0,  D * GLfloat (Count), 0.0);
      V.Last_Element.Col := Colors_RGBA.White_Color_Amount_Vector;

      for I in 0 .. Count - 1 loop
         if I mod 10 = 0 then
            T := 0.4;
         elsif I mod 5 = 0 then
            T := 0.2;
         else
            T := 0.1;
         end if;
         V.Append;
         V.Last_Element.Pos := (-1.0 * T, D * GLfloat (I), 0.0);
         V.Last_Element.Col := Colors_RGBA.White_Color_Amount_Vector;
         V.Append;
         V.Last_Element.Pos := (1.0 * T, D * GLfloat (I), 0.0);
         V.Last_Element.Col := Colors_RGBA.White_Color_Amount_Vector;
      end loop;

   end;

end;
