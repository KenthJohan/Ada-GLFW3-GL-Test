with Maths;

package Projections is

   use Maths;

   subtype Frustum_RC is Matrix_RC_4;
   subtype Frustum_CR is Matrix_CR_4;

   procedure Make_Frustum (Item : out Frustum_RC; Left, Right, Bottom, Top, Near, Far : Element);

   procedure Make_Frustum (Item : out Frustum_CR; Left, Right, Bottom, Top, Near, Far : Element);

   procedure Make_Perspective (Item : in out Frustum_CR; Field_Of_View : Radian; Aspect, Near, Far : Element);
   procedure Make_Perspective (Item : in out Frustum_CR; Field_Of_View : Degree; Aspect, Near, Far : Element);
   procedure Make_Perspective (Item : in out Frustum_RC; Field_Of_View : Radian; Aspect, Near, Far : Element);
   procedure Make_Perspective (Item : in out Frustum_RC; Field_Of_View : Degree; Aspect, Near, Far : Element);

end;
