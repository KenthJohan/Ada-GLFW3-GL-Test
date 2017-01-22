package body Generic_Matpack.Projections is

   procedure Generic_Matrix_Frustum_Conversion (Left, Right, Bottom, Top, Near, Far : Element; Result : out Perspective_Matrix_4) is
      I1 : constant Index_4 := Index_4'First;
      I2 : constant Index_4 := Index_4'Succ (Index_4'First);
      I3 : constant Index_4 := Index_4'Succ (Index_4'Succ (Index_4'First));
      I4 : constant Index_4 := Index_4'Succ (Index_4'Succ (Index_4'Succ (Index_4'First)));
   begin
      Result (I1, I1) := (Two * Near) / (Right - Left);
      Result (I2, I2) := (Two * Near) / (Top - Bottom);
      Result (I3, I3) := -((Far + Near) / (Far - Near));
      Result (I4, I3) := -((Two * Far * Near) / (Far - Near));
      Result (I3, I4) := -One;
      Result (I3, I1) := (Right + Left) / (Right - Left);
      Result (I3, I2) := (Top + Bottom) / (Top - Bottom);
   end;

   procedure Generic_Matrix_Perspective_Conversion (Field_Of_View, Aspect, Near, Far : Element; Result : in out Perspective_Matrix_4) is
      procedure Convert is new Generic_Matrix_Frustum_Conversion (Index_4, Element, Perspective_Matrix_4, One, Two, "*", "/", "-", "+", "-");
      Top : constant Element := Near * Tan (Field_Of_View / Two);
      Right : constant Element := Top * Aspect;
   begin
      Convert (-Right, Right, -Top, Top, Near, Far, Result);
   end;


   -- | 1  0  0  T1 |
   -- | 0  1  0  T2 |
   -- | 0  0  1  T3 |
   -- | 0  0  0  1  |
   -- Matrix (Column, Row)
   procedure Generic_Vector_Matrix_Translation_Conversion (Item : Translation_Vector_4; Result : out Translation_Matrix_4) is
      I1 : constant Index_4 := Index_4'First;
      I2 : constant Index_4 := Index_4'Succ (Index_4'First);
      I3 : constant Index_4 := Index_4'Succ (Index_4'Succ (Index_4'First));
      I4 : constant Index_4 := Index_4'Succ (Index_4'Succ (Index_4'Succ (Index_4'First)));
   begin
      Result (I4, I1) := Item (I1);
      Result (I4, I2) := Item (I2);
      Result (I4, I3) := Item (I3);
   end;

end;
