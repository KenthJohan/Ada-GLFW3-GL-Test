with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics;
with Ada.Text_IO;
with Ada.Float_Text_IO;

package body Maths is

   procedure Hamilton_Product (Left, Right : Quaternion; Result : out Quaternion) is
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







   procedure Convert (Revolve : Axis; Angle : Radian; Result : out Quaternion) is
      package Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions (Radian);
      use Elementary_Functions;
      Factor : constant Element := Element (Sin (Angle));
   begin
      Result (1) := Element (Cos (Angle));
      Result (2) := Revolve (1) * Factor;
      Result (3) := Revolve (2) * Factor;
      Result (4) := Revolve (3) * Factor;
      Scale (Vector (Result), 1.0 / Length (Result));
   end;

   function Convert (Revolve : Axis; Angle : Radian) return Quaternion is
      Result : Quaternion;
   begin
      Convert (Revolve, Angle, Result);
      return Result;
   end;

   function Convert (Revolve : Axis; Angle : Degree) return Quaternion is
      A : constant Radian := Convert (Angle);
   begin
      return Convert (Revolve, A);
   end;



   function Convert (Angle : Radian) return Degree is
      use Ada.Numerics;
   begin
      return Degree (Angle) * (180.0 / Pi);
   end;

   function Convert (Angle : Degree) return Radian is
      use Ada.Numerics;
   begin
      return Radian (Angle) * (Pi / 180.0);
   end;










   procedure Make_Translation (Item : in out Matrix_RC_4; Translation : Vector_3) is
   begin
      Item (1, 4) := Translation (1);
      Item (2, 4) := Translation (2);
      Item (3, 4) := Translation (3);
   end;

   procedure Make_Translation (Item : in out Matrix_CR_4; Translation : Vector_3) is
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

   procedure Put (Item : Matrix_CR) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      for I in Item'Range (1) loop
         for J in Item'Range (2) loop
            Put (Float (Item (J, I)), 3, 3, 0);
         end loop;
         New_Line;
      end loop;
   end;

   procedure Put (Item : Matrix_RC) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      for I in Item'Range (1) loop
         for J in Item'Range (2) loop
            Put (Float (Item (I, J)), 3, 3, 0);
         end loop;
         New_Line;
      end loop;
   end;

   procedure Put (Item : Vector) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      for J in Item'Range loop
         Put (Float (Item (J)), 3, 3, 0);
      end loop;
      New_Line;
   end;

end;
