with Maths;

package Cameras is

   use Maths;

   type Camera is private;

   subtype Transformation is Matrix_CR_4;

   function Create return Camera;
   function Build (Item : Camera) return Transformation;
   procedure Put (Item : Camera);
   procedure Set_Translation (Item : in out Camera; V : Vector_4);
   procedure Set_Perspective (Item : in out Camera; Field_Of_View : Degree; Aspect, Near, Far : Element);
   procedure Set_Rotation (Item : in out Camera; V : Quaternion);

   function Get_Forward (Item : in out Camera) return Vector_3;
   function Get_Up (Item : in out Camera) return Vector_3;
   function Get_Right (Item : in out Camera) return Vector_3;

   function Get_Rotation (Item : in out Camera) return Transformation;
   procedure Translate_Relative (Item : Camera; Direction : Vector_4; Translation : out Vector_4);

private


   type Camera is record
      Projection : Transformation;
      Rotation : Transformation;
      Translation : Transformation;
   end record;

end;
