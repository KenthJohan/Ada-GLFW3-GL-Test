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

end;
