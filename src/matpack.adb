with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;



package body Matpack is

   procedure Set_Diagonal (Item : out Matrix; Value_Diagonal : Float; Value_Defualt : Float := 0.0) is
   begin
      for I in Item'Range (1) loop
         for J in Item'Range (2) loop
            Item (I, J) := (if I = J then Value_Diagonal else Value_Defualt);
         end loop;
      end loop;
   end;

   procedure Make_Identity (Item : out Matrix) is
   begin
      Set_Diagonal (Item, 1.0, 0.0);
   end;




   procedure Scale (Item : in out Vector; Factor : Float) is
   begin
      for E of Item loop
         E := Factor * E;
      end loop;
   end;

   function Length2 (Item : Vector) return Float is
      Result : Float := 0.0;
   begin
      for E of Item loop
         Result := Result + (E ** 2);
      end loop;
      return Result;
   end;


   function Length (Item : Vector) return Float is
      package Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
      function Sqrt (Value : Float) return Float renames Elementary_Functions.Sqrt;
   begin
      return Sqrt (Length2 (Item));
   end;

   procedure Normalize (Item : in out Vector) is
      Factor : constant Float := Length (Item);
   begin
      Scale (Item, 1.0 / Factor);
      null;
   end;

   procedure Product_IJK (A : Matrix; B : Matrix; R : in out Matrix) is
   begin
      for I in R'Range (1) loop
         for J in R'Range (2) loop
            for K in A'Range (1) loop
               R (I, J) := R (I, J) + A (K, J) * B (I, K);
            end loop;
         end loop;
      end loop;
   end;

   procedure Product_IKJ (A : Matrix; B : Matrix; R : in out Matrix) is
   begin
      for I in R'Range (1) loop
         for K in A'Range (1) loop
            for J in R'Range (2) loop
               R (I, J) := R (I, J) + A (K, J) * B (I, K);
            end loop;
         end loop;
      end loop;
   end;

   procedure Multiply_Accumulate (Left : Matrix; Right : Vector; Result : in out Vector) is
   begin
      for J in Left'Range (1) loop
         for I in Left'Range (2) loop
            Result (J) := Result (J) + Right (I) * Left (I, J);
         end loop;
      end loop;
   end;

   procedure Multiply_Accumulate_Transpose (Left_Transpose : Matrix; Right : Vector; Result : in out Vector) is
   begin
      for J in Left_Transpose'Range (1) loop
         for I in Left_Transpose'Range (2) loop
            Result (J) := Result (J) + Right (I) * Left_Transpose (J, I);
         end loop;
      end loop;
   end;

   function "*" (A, B : Matrix) return Matrix is
      R : Matrix (A'Range (1), B'Range (2)) := (others => (others => 0.0));
   begin
      Product_IJK (A, B, R);
      return R;
   end;


   procedure Put (Item : Matrix) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      for I in Item'Range (1) loop
         for J in Item'Range (1) loop
            Put (Item (J, I), 3, 3, 0);
         end loop;
         New_Line;
      end loop;
   end;

   procedure Put (Item : Vector) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      for E of Item loop
         Put (E, 3, 3, 0);
      end loop;
   end;


   procedure Accumulate (Left : Vector; Result : in out Vector) is
   begin
      for I in Result'Range loop
         Result (I) := Result (I) + Left (I);
      end loop;
   end;

end Matpack;
