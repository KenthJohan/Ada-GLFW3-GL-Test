package body Matpack is


   function Generic_Vector_Vector_Addition (Left : Vector; Right : Vector) return Vector is
      Result : Vector (Left'Range);
   begin
      for I in Left'Range loop
         Result (I) := Left (I) + Right (I);
      end loop;
      return Result;
   end;

   function Generic_Matrix_T0_Vector_Product (Left : Matrix; Right : Vector) return Vector  is
      Result : Vector (Left'Range (1)) := (others => Zero);
   begin
      for J in Left'Range (2) loop
         for I in Left'Range (1) loop
            Result (J) := Result (J) + Left (I, J) * Right (I);
         end loop;
      end loop;
      return Result;
   end;

   function Generic_Matrix_T1_Vector_Product (Left : Matrix; Right : Vector) return Vector is
      Result : Vector (Left'Range) := (others => Zero);
   begin
      for J in Left'Range (1) loop
         for I in Left'Range (2) loop
            Result (J) := Result (J) + Left (J, I) * Right (I);
         end loop;
      end loop;
      return Result;
   end;

   procedure Generic_Matrix_T0_Vector_Product_Accumulate (Left : Matrix; Right : Vector; Result : in out Vector) is
   begin
      for J in Left'Range (2) loop
         for I in Left'Range (1) loop
            Result (J) := Result (J) + Left (I, J) * Right (I);
         end loop;
      end loop;
   end;

   procedure Generic_Matrix_T1_Vector_Product_Accumulate (Left : Matrix; Right : Vector; Result : in out Vector) is
   begin
      for J in Left'Range (1) loop
         for I in Left'Range (2) loop
            Result (J) := Result (J) + Left (J, I) * Right (I);
         end loop;
      end loop;
   end;

   procedure Generic_Matrix_Matrix_Product_Accumulate_IJK (Left : Matrix; Right : Matrix; Result : in out Matrix) is
   begin
      for I in Result'Range (1) loop
         for J in Result'Range (2) loop
            for K in Left'Range (1) loop
               Result (I, J) := Result (I, J) + Left (K, J) * Right (I, K);
            end loop;
         end loop;
      end loop;
   end;

   procedure Generic_Matrix_Matrix_Product_Accumulate_IKJ (Left : Matrix; Right : Matrix; Result : in out Matrix) is
   begin
      for I in Result'Range (1) loop
         for K in Left'Range (1) loop
            for J in Result'Range (2) loop
               Result (I, J) := Result (I, J) + Left (K, J) * Right (I, K);
            end loop;
         end loop;
      end loop;
   end;

   function Generic_Matrix_Matrix_Product_IJK (Left : Matrix; Right : Matrix) return Matrix is
      procedure Matrix_Matrix_Product_Accumulate is new Generic_Matrix_Matrix_Product_Accumulate_IKJ (Index, Element, Matrix, "*", "+");
      Result : Matrix (Right'Range (1), Left'Range (2)) := (others => (others => Zero));
   begin
      Matrix_Matrix_Product_Accumulate (Left, Right, Result);
      return Result;
   end;

   function Generic_Matrix_Matrix_Product_IKJ (Left : Matrix; Right : Matrix) return Matrix is
      procedure Matrix_Matrix_Product_Accumulate is new Generic_Matrix_Matrix_Product_Accumulate_IKJ (Index, Element, Matrix, "*", "+");
      Result : Matrix (Right'Range (1), Left'Range (2)) := (others => (others => Zero));
   begin
      Matrix_Matrix_Product_Accumulate (Left, Right, Result);
      return Result;
   end;


   function Generic_Create_Matrix_Identidy return Matrix is
      Result : Matrix;
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
      return Result;
   end;

   function Generic_Create_Matrix_Diagonal (Remaining : Element; Diagonal : Element) return Matrix is
      Result : Matrix;
   begin
      for I in Result'Range (1) loop
         for J in Result'Range (2) loop
            if I = J then
               Result (I, J) := Diagonal;
            else
               Result (I, J) := Remaining;
            end if;
         end loop;
      end loop;
      return Result;
   end;

   procedure Generic_Make_Matrix_Diagonal (Remaining : Element; Diagonal : Element; Result : out Matrix) is
   begin
      for I in Result'Range (1) loop
         for J in Result'Range (2) loop
            if I = J then
               Result (I, J) := Diagonal;
            else
               Result (I, J) := Remaining;
            end if;
         end loop;
      end loop;
   end;


   procedure Generic_Normalize (Result : in out Vector) is
      Factor : Element := Zero;
   begin
      -- Calculate vector length squared.
      for E of Result loop
         Factor := Factor + E ** 2;
      end loop;

      -- Calculate vector length.
      Factor := Sqrt (Factor);

      -- Optimization?
      Factor := One / Factor;

      -- Scale each vector components.
      for E of Result loop
         E := E * Factor;
      end loop;
   end;





end;
