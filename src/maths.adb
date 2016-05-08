with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics;

package body Maths is

   package Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions (Element);

   procedure Hamilton_Product (Left, Right : Quaternion; Result : out Quaternion) is
      use type Element;
   begin
      Result (1) := (Left (1) * Right (1)) - (Left (2) * Right (2)) - (Left (3) * Right (3)) - (Left (4) * Right (4));
      Result (2) := (Left (1) * Right (2)) + (Left (2) * Right (1)) + (Left (3) * Right (4)) - (Left (4) * Right (3));
      Result (3) := (Left (1) * Right (3)) - (Left (2) * Right (4)) + (Left (3) * Right (1)) + (Left (4) * Right (2));
      Result (4) := (Left (1) * Right (4)) + (Left (2) * Right (3)) - (Left (3) * Right (2)) + (Left (4) * Right (1));
   end;

   function Hamilton_Product (Left, Right : Quaternion) return Quaternion is
      Result : Quaternion;
   begin
      Hamilton_Product (Left, Right, Result);
      return Result;
   end;

   function Length2 (Item : Vector) return Element is
      use type Element;
      Result : Element := 0.0;
   begin
      for E of Item loop
         Result := Result + (E ** 2);
      end loop;
      return Result;
   end;

   function Length (Item : Vector) return Element is
      use Elementary_Functions;
   begin
      return Sqrt (Length2 (Item));
   end;

   procedure Scale (Item : in out Vector; Factor : Element) is
      use type Element;
   begin
      for E of Item loop
         E := Factor * E;
      end loop;
   end;

   procedure Normalize (Item : in out Vector) is
      use type Element;
      Factor : constant Element := Length (Item);
   begin
      Scale (Item, 1.0 / Factor);
   end;

   procedure Make_Unit (Item : out Square_Matrix) is
   begin
      for I in Item'Range (1) loop
         Item (I, I) := 1.0;
      end loop;
   end;


   procedure Convert (Axis : Vector_3; Angle : Element; Result : out Quaternion) is
      use Elementary_Functions;
      use type Element;
      Factor : constant Element := Sin (Angle);
   begin
      Result (1) := Cos (Angle);
      Result (2) := Axis (1) * Factor;
      Result (3) := Axis (2) * Factor;
      Result (4) := Axis (3) * Factor;
      Scale (Result, 1.0 / Length2 (Result));
   end;

   function Convert (Axis : Vector_3; Angle : Element) return Quaternion is
      Result : Quaternion;
   begin
      Convert (Axis, Angle, Result);
      return Result;
   end;

   procedure Make_Frustum_RC (Item : out Matrix_4; Left, Right, Bottom, Top, Near, Far : Element) is
      use type Element;
   begin
      Item (1, 1) := (2.0 * Near) / (Right - Left);
      Item (2, 2) := (2.0 * Near) / (Top - Bottom);
      Item (3, 4) := -((2.0 * Far * Near) / (Far - Near));
      Item (4, 3) := -1.0;
      Item (1, 3) := (Right + Left) / (Right - Left);
      Item (2, 3) := (Top + Bottom) / (Top - Bottom);
      Item (3, 3) := -((Far + Near) / (Far - Near));
   end;

   procedure Make_Frustum_CR (Item : out Matrix_4; Left, Right, Bottom, Top, Near, Far : Element) is
      use type Element;
   begin
      Item (1, 1) := (2.0 * Near) / (Right - Left);
      Item (2, 2) := (2.0 * Near) / (Top - Bottom);
      Item (4, 3) := -((2.0 * Far * Near) / (Far - Near));
      Item (3, 4) := -1.0;
      Item (3, 1) := (Right + Left) / (Right - Left);
      Item (3, 2) := (Top + Bottom) / (Top - Bottom);
      Item (3, 3) := -((Far + Near) / (Far - Near));
   end;

   procedure Make_Perspective_CR (Item : in out Matrix_4; Field_Of_View, Aspect, Near, Far : Element) is
      use Elementary_Functions;
      use type Element;
      use Ada.Numerics;
      Top : constant Element := Near * Tan ((Pi / 180.0) * (Field_Of_View / 2.0));
      Right : constant Element := Top * Aspect;
   begin
      Make_Frustum_CR (Item, -Right, Right, -Top, Top, Near, Far);
   end;

   procedure Make_Perspective_RC (Item : in out Matrix_4; Field_Of_View, Aspect, Near, Far : Element) is
      use Elementary_Functions;
      use type Element;
      use Ada.Numerics;
      Top : constant Element := Near * Tan ((Pi / 180.0) * (Field_Of_View / 2.0));
      Right : constant Element := Top * Aspect;
   begin
      Make_Frustum_RC (Item, -Right, Right, -Top, Top, Near, Far);
   end;

   procedure Make_Translation_RC (Item : in out Matrix_4; Translation : Vector_3) is
   begin
      Item (1, 4) := Translation (1);
      Item (2, 4) := Translation (2);
      Item (3, 4) := Translation (3);
   end;

   procedure Make_Translation_CR (Item : in out Matrix_4; Translation : Vector_3) is
   begin
      Item (4, 1) := Translation (1);
      Item (4, 2) := Translation (2);
      Item (4, 3) := Translation (3);
   end;

   procedure Convert (Item : Quaternion; Result : out Matrix_4) is
      use type Element;
   begin
      Result (1, 1) := (Item (1) ** 2) + (Item (2) ** 2) - (Item (3) ** 2) - (Item (4) ** 2);
      Result (2, 2) := (Item (1) ** 2) - (Item (2) ** 2) + (Item (3) ** 2) - (Item (4) ** 2);
      Result (3, 3) := (Item (1) ** 2) - (Item (2) ** 2) - (Item (3) ** 2) + (Item (4) ** 2);
      Result (1, 2) := (2.0 * Item (2) * Item (3)) - (2.0 * Item (1) * Item (4));
      Result (2, 1) := (2.0 * Item (2) * Item (3)) + (2.0 * Item (1) * Item (4));
      Result (1, 3) := (2.0 * Item (2) * Item (4)) + (2.0 * Item (1) * Item (3));
      Result (3, 1) := (2.0 * Item (2) * Item (4)) - (2.0 * Item (1) * Item (3));
      Result (2, 3) := (2.0 * Item (3) * Item (4)) - (2.0 * Item (1) * Item (2));
      Result (3, 2) := (2.0 * Item (3) * Item (4)) + (2.0 * Item (1) * Item (2));
   end;

   function Convert (Item : Quaternion) return Matrix_4 is
      Result : Matrix_4;
   begin
      Convert (Item, Result);
      return Result;
   end;

   procedure Product (Left, Right : Matrix_4; I, J : Integer; Result : out Matrix_4) is
      use type Element;
   begin
      for K in Result'Range (1) loop
         Result (I, J) := Left (I, K) * Right (K, J);
      end loop;
   end;

   procedure Product_IJ (Left, Right : Matrix_4; Result : out Matrix_4) is
      use type Element;
   begin
      for I in Result'Range (1) loop
         for J in Result'Range (2) loop
            Product (Left, Right, I, J, Result);
         end loop;
      end loop;
   end;

   procedure Product_JI (Left, Right : Matrix_4; Result : out Matrix_4) is
      use type Element;
   begin
      for I in Result'Range (1) loop
         for J in Result'Range (2) loop
            Product (Left, Right, J, I, Result);
         end loop;
      end loop;
   end;

   function Product_IJ (Left, Right : Matrix_4) return Matrix_4 is
      Result : Matrix_4;
   begin
      Product_IJ (Left, Right, Result);
      return Result;
   end;

   function Product_JI (Left, Right : Matrix_4) return Matrix_4 is
      Result : Matrix_4;
   begin
      Product_JI (Left, Right, Result);
      return Result;
   end;

end;
