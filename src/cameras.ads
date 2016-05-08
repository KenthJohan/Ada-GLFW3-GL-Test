with Ada.Numerics.Real_Arrays;

package Cameras is

   type Radian is new Float;
   type Degree is new Float;

   subtype Matrix is Ada.Numerics.Real_Arrays.Real_Matrix (1 .. 4, 1 .. 4);
   subtype Vector is Ada.Numerics.Real_Arrays.Real_Vector (1 .. 3);
   subtype Quaternion is Ada.Numerics.Real_Arrays.Real_Vector (1 .. 4);

   type Camera is private;

   procedure Translate_RC (C : in out Camera; V : Vector);
   procedure Translate_CR (C : in out Camera; V : Vector);

   procedure Frustum_RC (C : in out Camera; Left, Right, Bottom, Top, Near, Far : Float);
   procedure Frustum_CR (C : in out Camera; Left, Right, Bottom, Top, Near, Far : Float);

   procedure Perspective_RC (C : in out Camera; Field_Of_View, Aspect, Near, Far : Float);
   procedure Perspective_CR (C : in out Camera; Field_Of_View, Aspect, Near, Far : Float);

   function Convert (V : Vector; Angle : Degree) return Quaternion;
   function Convert (V : Vector; Angle : Radian) return Quaternion;

   procedure Rotate_RC (C : in out Camera; Q : Quaternion);
   procedure Rotate_CR (C : in out Camera; Q : Quaternion);

   --procedure Rotate_RC (C : in out Camera; V : Vector; Angle : Radian);
   --procedure Rotate_CR (C : in out Camera; V : Vector; Angle : Radian);

   --procedure Rotate_RC (C : in out Camera; V : Vector; Angle : Degree);
   --procedure Rotate_CR (C : in out Camera; V : Vector; Angle : Degree);

   function Build (C : Camera) return Matrix;
   function Create_RC return Camera;
   function Create_CR return Camera;

   procedure Put (C : Camera);
   procedure Put (M : Matrix);
   procedure Put_Quaternion (M : Quaternion);

private

   type Camera is record
      Projection : Matrix;
      ViewRotation : Matrix;
      ViewTranslation : Matrix;
      Rotation : Quaternion;
   end record;

end;
