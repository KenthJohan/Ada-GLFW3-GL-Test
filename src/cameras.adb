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

   procedure Set_Translation (Item : in out Camera; Translation : Vector_4) is
      use Projections;
   begin
      Make_Translation (Item.Translation, Translation);
   end;

   procedure Set_Perspective (Item : in out Camera; Field_Of_View : Degree; Aspect, Near, Far : Element) is
      use Projections;
   begin
      Make_Perspective (Item.Projection, Field_Of_View, Aspect, Near, Far);
   end;

   procedure Set_Rotation (Item : in out Camera; Rotation : Quaternion) is
   begin
      Convert (Rotation, Matrix_4 (Item.Rotation));
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

   procedure Translate_Relative (Item : in out Camera; Direction : Vector_4; Translation : in out Vector_4) is
   begin
      -- t + d*R -> t
      Multiply_Accumulate (Direction, Item.Rotation, Translation);
      Translation (4) := 1.0; --What to do with this direction?
      Set_Translation (Item, Translation);
   end;


end;
