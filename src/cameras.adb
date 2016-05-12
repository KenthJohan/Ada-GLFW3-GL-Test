with Ada.Text_IO;
with Projections;

package body Cameras is

   function Build (Item : Camera) return Transformation is
   begin
      return Item.Projection * Item.Rotation * Item.Translation;
   end;

   function Create return Camera is
      Result : Camera;
   begin
      Result.Projection := (others => (others => 0.0));
      Result.Rotation := Unit;
      Result.Translation := Unit;
      return Result;
   end;

   procedure Set_Translation (Item : in out Camera; V : Vector_4) is
      use Projections;
   begin
      Make_Translation (Item.Translation, Vector_3 (V (1 .. 3)));
   end;

   procedure Set_Perspective (Item : in out Camera; Field_Of_View : Degree; Aspect, Near, Far : Element) is
      use Projections;
   begin
      Make_Perspective (Item.Projection, Field_Of_View, Aspect, Near, Far);
   end;

   procedure Set_Rotation (Item : in out Camera; V : Quaternion) is
   begin
      Convert (V, Matrix_4 (Item.Rotation));
   end;

   procedure Put (Item : Camera) is
      use Ada.Text_IO;
   begin
      Put_Line ("Projection");
      Put (Matrix_CR (Item.Projection));
      New_Line;
      Put_Line ("Rotation");
      Put (Matrix_CR (Item.Rotation));
      New_Line;
      Put_Line ("Translation");
      Put (Matrix_CR (Item.Translation));
      New_Line;
      Put_Line ("Result");
      Put (Matrix_CR (Build (Item)));
   end;



   function Get_Forward (Item : in out Camera) return Vector_3 is
      Result : Vector_3;
   begin
      Result (1) := Item.Rotation (1, 3);
      Result (2) := Item.Rotation (2, 3);
      Result (3) := Item.Rotation (3, 3);
      return Result;
   end;

   function Get_Up (Item : in out Camera) return Vector_3 is
      Result : Vector_3;
   begin
      Result (1) := Item.Rotation (1, 2);
      Result (2) := Item.Rotation (2, 2);
      Result (3) := Item.Rotation (3, 2);
      return Result;
   end;

   function Get_Right (Item : in out Camera) return Vector_3 is
      Result : Vector_3;
   begin
      Result (1) := Item.Rotation (1, 1);
      Result (2) := Item.Rotation (2, 1);
      Result (3) := Item.Rotation (3, 1);
      return Result;
   end;

   function Get_Rotation (Item : in out Camera) return Transformation is
   begin
      return Item.Rotation;
   end;


   procedure Translate_Relative (Item : Camera; Direction : Vector_4; Translation : out Vector_4) is
   begin
      Multiply_Accumulate (Direction, Item.Rotation, Translation);
   end;


end;
