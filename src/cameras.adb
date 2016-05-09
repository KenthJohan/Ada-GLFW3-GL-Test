with Ada.Text_IO;



package body Cameras is

   function Build (C : Camera_RC) return Matrix_RC_4 is
   begin
      --return C.Projection * C.ViewRotation * C.ViewTranslation;
      --return C.Projection * C.ViewTranslation * C.ViewRotation;
      --return C.ViewTranslation * C.ViewRotation * C.Projection;
      return C.Projection * C.ViewTranslation;
   end;

   function Create return Camera_RC is
      C : Camera_RC;
   begin
      C.Projection := (others => (others => 0.0));
      C.Rotation := Unit;
      C.ViewRotation := Unit;
      C.ViewTranslation := Unit;
      C.Translation := (others => 0.0);
      Convert (C.Rotation, Matrix_4 (C.ViewRotation));
      return C;
   end;

   procedure Translate (C : in out Camera_RC; V : Vector_3) is
   begin
      Add (C.Translation, V, C.Translation);
      Make_Translation (C.ViewTranslation, C.Translation);
   end;

   procedure Perspective (C : in out Camera_RC; Field_Of_View, Aspect, Near, Far : Element) is
   begin
      Make_Perspective (C.Projection, Field_Of_View, Aspect, Near, Far);
   end;

   procedure Put (C : Camera_RC) is
      use Ada.Text_IO;
   begin
      Put (Matrix_RC (C.Projection));
      New_Line;
      Put (Vector (C.Rotation));
      New_Line;
      Put (Matrix_RC (C.ViewRotation));
      New_Line;
      Put (Matrix_RC (C.ViewTranslation));
      New_Line;
      Put (Matrix_RC (Build (C)));
   end;










   function Build (C : Camera_CR) return Matrix_CR_4 is
   begin

      --return C.Projection * C.ViewRotation * C.ViewTranslation;
      --return C.Projection * C.ViewTranslation * C.ViewRotation;
      --return C.ViewTranslation * C.ViewRotation * C.Projection;
      return C.Projection * C.ViewRotation * C.ViewTranslation;
   end;

   function Create return Camera_CR is
      C : Camera_CR;
   begin
      C.Projection := (others => (others => 0.0));
      C.Rotation := Unit;
      C.ViewRotation := Unit;
      C.ViewTranslation := Unit;
      C.Translation := (others => 0.0);
      Convert (C.Rotation, Matrix_4 (C.ViewRotation));
      return C;
   end;

   procedure Translate (C : in out Camera_CR; V : Vector_3) is
   begin
      Add (C.Translation, V, C.Translation);
      Make_Translation (C.ViewTranslation, C.Translation);
   end;

   procedure Rotate (C : in out Camera_CR; V : Quaternion) is
   begin
      C.Rotation := Hamilton_Product (C.Rotation, V);
      Convert (C.Rotation, Matrix_4 (C.ViewRotation));
   end;

   procedure Perspective (C : in out Camera_CR; Field_Of_View, Aspect, Near, Far : Element) is
   begin
      Make_Perspective (C.Projection, Field_Of_View, Aspect, Near, Far);
   end;

   procedure Put (C : Camera_CR) is
      use Ada.Text_IO;
   begin
      Put (Matrix_CR (C.Projection));
      New_Line;
      Put (Vector (C.Rotation));
      New_Line;
      Put (Matrix_CR (C.ViewRotation));
      New_Line;
      Put (Matrix_CR (C.ViewTranslation));
      New_Line;
      Put (Matrix_CR (Build (C)));
   end;







end;
