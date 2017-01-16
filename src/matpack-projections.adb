with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics;

package body Matpack.Projections is

   procedure Make_Frustum (Item : out Matrix_4; Left, Right, Bottom, Top, Near, Far : Float) is
   begin
      Item (1, 1) := (2.0 * Near) / (Right - Left);
      Item (2, 2) := (2.0 * Near) / (Top - Bottom);
      Item (3, 3) := -((Far + Near) / (Far - Near));
      Item (4, 3) := -((2.0 * Far * Near) / (Far - Near));
      Item (3, 4) := -1.0;
      Item (3, 1) := (Right + Left) / (Right - Left);
      Item (3, 2) := (Top + Bottom) / (Top - Bottom);
   end;

   procedure Make_Perspective (Item : in out Matrix_4; Field_Of_View : Radian; Aspect, Near, Far : Float) is
      package Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions (Radian);
      use Elementary_Functions;
      use Ada.Numerics;
      Top : constant Float := Near * Float (Tan (Field_Of_View / 2.0));
      Right : constant Float := Top * Aspect;
   begin
      Make_Frustum (Item, -Right, Right, -Top, Top, Near, Far);
   end;

   -- | 1  0  0  T1 |
   -- | 0  1  0  T2 |
   -- | 0  0  1  T3 |
   -- | 0  0  0  1  |
   -- Matrix (Column, Row)
   procedure Make_Translation (Item : out Matrix; T : Vector) is
   begin
      Make_Identity (Item);
      Item (Item'First (1) + 3, Item'First (2) + 0) := T (T'First + 0); -- Row 0 and column 3
      Item (Item'First (1) + 3, Item'First (2) + 1) := T (T'First + 1); -- Row 1 and column 3
      Item (Item'First (1) + 3, Item'First (2) + 2) := T (T'First + 2); -- Row 2 and column 3
   end;



end;
