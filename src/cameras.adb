with Ada.Numerics;
with Ada.Numerics.Elementary_Functions;
with Ada.Text_IO;
with Ada.Float_Text_IO;


package body Cameras is

   function Convert (V : Vector; Angle : Radian) return Quaternion is
      use Ada.Numerics;
      use Ada.Numerics.Elementary_Functions;
      use type Quaternion;
      Factor : constant Float := Sin (Float (Angle));
      Q : Quaternion;
      S : Float;
   begin
      Q (1) := Cos (Float (Angle));
      Q (2) := V (1) * Factor;
      Q (3) := V (2) * Factor;
      Q (4) := V (3) * Factor;
      S := 1.0 / abs Q;
      Q := Q * S;
      return Q;
   end;

   function Convert (V : Vector; Angle : Degree) return Quaternion is
      use Ada.Numerics;
   begin
      return Convert (V, Radian (Angle * (Pi / 180.0)));
   end;

   function Cross_Product (L, R : Vector) return Vector is
   begin
      return
        (
         (L (2) * R (3) - L (3) * R (2)),
         (L (3) * R (1) - L (1) * R (3)),
         (L (1) * R (2) - L (2) * R (1))
        );
   end;
   pragma Unreferenced (Cross_Product);
   --pragma Inline (Cross_Product);

   function Product (L, R : Quaternion) return Quaternion is
      V : Quaternion;
   begin
      V (1) := (L (1) * R (1)) - (L (2) * R (2)) - (L (3) * R (3)) - (L (4) * R (4));
      V (2) := (L (1) * R (2)) + (L (2) * R (1)) + (L (3) * R (4)) - (L (4) * R (3));
      V (3) := (L (1) * R (3)) - (L (2) * R (4)) + (L (3) * R (1)) + (L (4) * R (2));
      V (4) := (L (1) * R (4)) + (L (2) * R (3)) - (L (3) * R (2)) + (L (4) * R (1));
      return V;
   end;
   pragma Inline (Product);


   procedure Frustum_RC (M : out Matrix; Left, Right, Bottom, Top, Near, Far : Float) is
   begin
      M (1, 1) := (2.0 * Near) / (Right - Left);
      M (2, 2) := (2.0 * Near) / (Top - Bottom);

      M (3, 4) := -((2.0 * Far * Near) / (Far - Near));
      M (4, 3) := -1.0;

      M (1, 3) := (Right + Left) / (Right - Left);
      M (2, 3) := (Top + Bottom) / (Top - Bottom);
      M (3, 3) := -((Far + Near) / (Far - Near));
   end;

   procedure Frustum_CR (M : out Matrix; Left, Right, Bottom, Top, Near, Far : Float) is
   begin
      M (1, 1) := (2.0 * Near) / (Right - Left);
      M (2, 2) := (2.0 * Near) / (Top - Bottom);

      M (4, 3) := -((2.0 * Far * Near) / (Far - Near));
      M (3, 4) := -1.0;

      M (3, 1) := (Right + Left) / (Right - Left);
      M (3, 2) := (Top + Bottom) / (Top - Bottom);
      M (3, 3) := -((Far + Near) / (Far - Near));
   end;

   procedure Perspective_RC (M : in out Matrix; Field_Of_View, Aspect, Near, Far : Float) is
      use Ada.Numerics;
      use Ada.Numerics.Elementary_Functions;
      Top : constant Float := Near * Tan ((Pi / 180.0) * (Field_Of_View / 2.0));
      Right : constant Float := Top * Aspect;
   begin
      Frustum_RC (M, -Right, Right, -Top, Top, Near, Far);
   end;

   procedure Perspective_CR (M : in out Matrix; Field_Of_View, Aspect, Near, Far : Float) is
      use Ada.Numerics;
      use Ada.Numerics.Elementary_Functions;
      Top : constant Float := Near * Tan ((Pi / 180.0) * (Field_Of_View / 2.0));
      Right : constant Float := Top * Aspect;
   begin
      Frustum_CR (M, -Right, Right, -Top, Top, Near, Far);
   end;

   procedure Translate_RC (M : in out Matrix; V : Vector) is
   begin
      M (1, 4) := M (1, 4) + V (1);
      M (2, 4) := M (2, 4) + V (2);
      M (3, 4) := M (3, 4) + V (3);
   end;

   procedure Translate_CR (M : in out Matrix; V : Vector) is
   begin
      M (4, 1) := M (4, 1) + V (1);
      M (4, 2) := M (4, 2) + V (2);
      M (4, 3) := M (4, 3) + V (3);
   end;

   procedure Convert (M : out Matrix; Q : Quaternion) is
   begin
      M (1, 1) := (Q (1) ** 2) + (Q (2) ** 2) - (Q (3) ** 2) - (Q (4) ** 2);
      M (2, 2) := (Q (1) ** 2) - (Q (2) ** 2) + (Q (3) ** 2) - (Q (4) ** 2);
      M (3, 3) := (Q (1) ** 2) - (Q (2) ** 2) - (Q (3) ** 2) + (Q (4) ** 2);

      M (1, 2) := (2.0 * Q (2) * Q (3)) - (2.0 * Q (1) * Q (4));
      M (2, 1) := (2.0 * Q (2) * Q (3)) + (2.0 * Q (1) * Q (4));

      M (1, 3) := (2.0 * Q (2) * Q (4)) + (2.0 * Q (1) * Q (3));
      M (3, 1) := (2.0 * Q (2) * Q (4)) - (2.0 * Q (1) * Q (3));

      M (2, 3) := (2.0 * Q (3) * Q (4)) - (2.0 * Q (1) * Q (2));
      M (3, 2) := (2.0 * Q (3) * Q (4)) + (2.0 * Q (1) * Q (2));
   end;







   procedure Frustum_RC (C : in out Camera; Left, Right, Bottom, Top, Near, Far : Float) is
   begin
      Frustum_RC (C.Projection, Left, Right, Bottom, Top, Near, Far);
   end;

   procedure Frustum_CR (C : in out Camera; Left, Right, Bottom, Top, Near, Far : Float) is
   begin
      Frustum_CR (C.Projection, Left, Right, Bottom, Top, Near, Far);
   end;




   procedure Perspective_RC (C : in out Camera; Field_Of_View, Aspect, Near, Far : Float) is
   begin
      Perspective_RC (C.Projection, Field_Of_View, Aspect, Near, Far);
   end;

   procedure Perspective_CR (C : in out Camera; Field_Of_View, Aspect, Near, Far : Float) is
   begin
      Perspective_CR (C.Projection, Field_Of_View, Aspect, Near, Far);
   end;



   procedure Translate_RC (C : in out Camera; V : Vector) is
   begin
      Translate_RC (C.ViewTranslation, V);
   end;

   procedure Translate_CR (C : in out Camera; V : Vector) is
   begin
      Translate_CR (C.ViewTranslation, V);
   end;




   procedure Rotate_RC (C : in out Camera; Q : Quaternion) is
   begin
      --C.Rotation := Product (C.Rotation, Q);
      C.Rotation := Product (Q, C.Rotation);
      Convert (C.ViewRotation, C.Rotation);
   end;

   procedure Rotate_CR (C : in out Camera; Q : Quaternion) is
   begin
      --C.Rotation := Product (C.Rotation, Q);
      C.Rotation := Product (Q, C.Rotation);
      Convert (C.ViewRotation, C.Rotation);
   end;





   function Build (C : Camera) return Matrix is
      use type Matrix;
   begin
      --return C.Projection * C.ViewRotation * C.ViewTranslation;
      --return C.Projection * C.ViewTranslation * C.ViewRotation;
      return C.ViewTranslation * C.ViewRotation * C.Projection;
   end;




   function Create_RC return Camera is
      C : Camera;
   begin
      C.Projection := (others => (others => 0.0));
      C.Projection (4, 3) := -1.0;
      C.Rotation := (1.0, 0.0, 0.0, 0.0);
      C.ViewRotation := Ada.Numerics.Real_Arrays.Unit_Matrix (4);
      C.ViewTranslation := Ada.Numerics.Real_Arrays.Unit_Matrix (4);
      Convert (C.ViewRotation, C.Rotation);
      return C;
   end;

   function Create_CR return Camera is
      C : Camera;
   begin
      C.Projection := (others => (others => 0.0));
      C.Projection (3, 4) := -1.0;
      C.Rotation := (1.0, 0.0, 0.0, 0.0);
      C.ViewRotation := Ada.Numerics.Real_Arrays.Unit_Matrix (4);
      C.ViewTranslation := Ada.Numerics.Real_Arrays.Unit_Matrix (4);
      Convert (C.ViewRotation, C.Rotation);
      return C;
   end;





   procedure Put (M : Matrix) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      for I in M'Range (1) loop
         for J in M'Range (2) loop
            Put (M (J, I), 3, 3, 0);
         end loop;
         New_Line;
      end loop;
   end;

   procedure Put_Quaternion (M : Quaternion) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      for J in M'Range loop
         Put (M (J), 3, 3, 0);
      end loop;
      New_Line;
   end;

   procedure Put (C : Camera) is
      use Ada.Text_IO;
   begin
      Put (C.Projection);
      New_Line;
      Put_Quaternion (C.Rotation);
      Put (C.ViewRotation);
      New_Line;
      Put (C.ViewTranslation);
      New_Line;
      Put (Build (C));
   end;




end;
