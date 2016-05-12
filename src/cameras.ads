with Maths;

package Cameras is

   use Maths;

   type Camera is private;
   subtype Transformation is Matrix_CR_4;

   function Create return Camera;
   function Build (Item : Camera) return Transformation;
   procedure Put (Item : Camera);

   procedure Set_Perspective (Item : in out Camera; Field_Of_View : Degree; Aspect, Near, Far : Element);
   procedure Set_Rotation (Item : in out Camera; Rotation : Quaternion);

   procedure Set_Translation (Item : in out Camera; Translation : Vector_4);
   procedure Translate_Relative (Item : in out Camera; Direction : Vector_4; Translation : in out Vector_4);



private

   type Camera is record
      Projection : Transformation;
      Rotation : Transformation;
      Translation : Transformation;
   end record;

end;
