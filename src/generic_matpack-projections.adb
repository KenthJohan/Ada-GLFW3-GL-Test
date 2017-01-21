package body Generic_Matpack.Projections is

   -- | 1  0  0  T1 |
   -- | 0  1  0  T2 |
   -- | 0  0  1  T3 |
   -- | 0  0  0  1  |
   -- Matrix (Column, Row)
   procedure Vector_Matrix_Translation_Conversion (Item : Translation_Vector_4; Result : out Translation_Matrix_4) is
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
