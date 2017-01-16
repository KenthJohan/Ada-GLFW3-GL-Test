package Matpack.Projections is

   procedure Make_Frustum (Item : out Matrix_4; Left, Right, Bottom, Top, Near, Far : Float);
   procedure Make_Perspective (Item : in out Matrix_4; Field_Of_View : Radian; Aspect, Near, Far : Float);
   procedure Make_Translation (Item : out Matrix; T : Vector);

end;
