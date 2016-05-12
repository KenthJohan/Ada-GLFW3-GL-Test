with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics;

package body Projections is

   procedure Make_Frustum (Item : out Frustum_RC; Left, Right, Bottom, Top, Near, Far : Element) is
   begin
      Item (1, 1) := (2.0 * Near) / (Right - Left);
      Item (2, 2) := (2.0 * Near) / (Top - Bottom);
      Item (3, 4) := -((2.0 * Far * Near) / (Far - Near));
      Item (4, 3) := -1.0;
      Item (1, 3) := (Right + Left) / (Right - Left);
      Item (2, 3) := (Top + Bottom) / (Top - Bottom);
      Item (3, 3) := -((Far + Near) / (Far - Near));
   end;

   procedure Make_Frustum (Item : out Frustum_CR; Left, Right, Bottom, Top, Near, Far : Element) is
   begin
      Item (1, 1) := (2.0 * Near) / (Right - Left);
      Item (2, 2) := (2.0 * Near) / (Top - Bottom);
      Item (4, 3) := -((2.0 * Far * Near) / (Far - Near));
      Item (3, 4) := -1.0;
      Item (3, 1) := (Right + Left) / (Right - Left);
      Item (3, 2) := (Top + Bottom) / (Top - Bottom);
      Item (3, 3) := -((Far + Near) / (Far - Near));
   end;




   procedure Make_Perspective (Item : in out Frustum_CR; Field_Of_View : Radian; Aspect, Near, Far : Element) is
      package Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions (Radian);
      use Elementary_Functions;
      use Ada.Numerics;
      Top : constant Element := Near * Element (Tan (Field_Of_View / 2.0));
      Right : constant Element := Top * Aspect;
   begin
      Make_Frustum (Item, -Right, Right, -Top, Top, Near, Far);
   end;

   procedure Make_Perspective (Item : in out Frustum_RC; Field_Of_View : Radian; Aspect, Near, Far : Element) is
      package Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions (Radian);
      use Elementary_Functions;
      use Ada.Numerics;
      Top : constant Element := Near * Element (Tan (Field_Of_View / 2.0));
      Right : constant Element := Top * Aspect;
   begin
      Make_Frustum (Item, -Right, Right, -Top, Top, Near, Far);
   end;


   procedure Make_Perspective (Item : in out Frustum_CR; Field_Of_View : Degree; Aspect, Near, Far : Element) is
      Angle : constant Radian := Convert (Field_Of_View);
   begin
      Make_Perspective (Item, Angle, Aspect, Near, Far);
   end;

   procedure Make_Perspective (Item : in out Frustum_RC; Field_Of_View : Degree; Aspect, Near, Far : Element) is
      Angle : constant Radian := Convert (Field_Of_View);
   begin
      Make_Perspective (Item, Angle, Aspect, Near, Far);
   end;




end;
