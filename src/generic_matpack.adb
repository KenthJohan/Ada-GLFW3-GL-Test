with Ada.Text_IO;

package body Generic_Matpack is


   procedure Matrix_T0_Vector_Product (Left : Matrix; Right : Vector; Result : in out Vector) is
   begin
      for J in Left'Range (2) loop
         for I in Left'Range (1) loop
            Result (J) := Result (J) + Left (I, J) * Right (I);
         end loop;
      end loop;
   end;

   procedure Matrix_T1_Vector_Product (Left : Matrix; Right : Vector; Result : in out Vector) is
   begin
      for J in Result'Range loop
         for I in Right'Range loop
            Result (J) := Result (J) + Left (J, I) * Right (I);
         end loop;
      end loop;
   end;

   procedure Matrix_Matrix_Product_Accumulate_IJK (Left : Matrix; Right : Matrix; Result : in out Matrix) is
   begin
      for I in Result'Range (1) loop
         for J in Result'Range (2) loop
            for K in Left'Range (1) loop
               Result (I, J) := Result (I, J) + Left (K, J) * Right (I, K);
            end loop;
         end loop;
      end loop;
   end;

   procedure Matrix_Matrix_Product_Accumulate_IKJ (Left : Matrix; Right : Matrix; Result : in out Matrix) is
   begin
      for I in Result'Range (1) loop
         for K in Left'Range (1) loop
            for J in Result'Range (2) loop
               Result (I, J) := Result (I, J) + Left (K, J) * Right (I, K);
            end loop;
         end loop;
      end loop;
   end;

   function Matrix_Matrix_Product_IJK (Left : Matrix; Right : Matrix) return Matrix is
      procedure Matrix_Matrix_Product_Accumulate is new Matrix_Matrix_Product_Accumulate_IKJ (Index, Element, Matrix, "*", "+");
      Result : Matrix (Right'Range (1), Left'Range (2)) := (others => (others => Zero));
   begin
      Matrix_Matrix_Product_Accumulate (Left, Right, Result);
      return Result;
   end;

   function Matrix_Matrix_Product_IKJ (Left : Matrix; Right : Matrix) return Matrix is
      procedure Matrix_Matrix_Product_Accumulate is new Matrix_Matrix_Product_Accumulate_IKJ (Index, Element, Matrix, "*", "+");
      Result : Matrix (Right'Range (1), Left'Range (2)) := (others => (others => Zero));
   begin
      Matrix_Matrix_Product_Accumulate (Left, Right, Result);
      return Result;
   end;

   procedure Make_Matrix_Identity (Result : out Matrix) is
   begin
      for I in Result'Range (1) loop
         for J in Result'Range (2) loop
            if I = J then
               Result (I, J) := One;
            else
               Result (I, J) := Zero;
            end if;
         end loop;
      end loop;
   end;


   procedure Normalize (Result : in out Vector) is
      Factor : Element := Zero;
   begin
      for E of Result loop
         Factor := Factor + E ** 2;
      end loop;
      Factor := Sqrt (Factor);
      Factor := One / Factor;
      for E of Result loop
         E := E * Factor;
      end loop;
   end;


   procedure Put (Item : Matrix) is
      package IO is new Ada.Text_IO.Float_IO (Element);
      use IO;
      use Ada.Text_IO;
   begin
      for I in Item'Range (1) loop
         for J in Item'Range (1) loop
            Put (Item (J, I), 3, 3, 0);
         end loop;
         New_Line;
      end loop;
   end;

end;
