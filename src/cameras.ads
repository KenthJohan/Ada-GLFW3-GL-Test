with Maths;

package Cameras is

   use Maths;

   --type Radian is new Element;
   --type Degree is new Element;
   type Camera_RC is private;
   type Camera_CR is private;

   function Build (C : Camera_RC) return Matrix_RC_4;
   function Create return Camera_RC;
   procedure Put (C : Camera_RC);
   procedure Translate (C : in out Camera_RC; V : Vector_3);
   procedure Perspective (C : in out Camera_RC; Field_Of_View, Aspect, Near, Far : Element);

   function Build (C : Camera_CR) return Matrix_CR_4;
   function Create return Camera_CR;
   procedure Put (C : Camera_CR);
   procedure Translate (C : in out Camera_CR; V : Vector_3);
   procedure Rotate (C : in out Camera_CR; V : Quaternion);

   procedure Perspective (C : in out Camera_CR; Field_Of_View, Aspect, Near, Far : Element);

private

   type Camera_RC is record
      Projection : Matrix_RC_4;
      ViewRotation : Matrix_RC_4;
      ViewTranslation : Matrix_RC_4;
      Rotation : Quaternion;
      Translation : Vector_3;
   end record;

   type Camera_CR is record
      Projection : Matrix_CR_4;
      ViewRotation : Matrix_CR_4;
      ViewTranslation : Matrix_CR_4;
      Rotation : Quaternion;
      Translation : Vector_3;
   end record;

end;
