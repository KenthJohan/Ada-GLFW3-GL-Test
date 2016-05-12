package body Maths2 is


   function "*" (Left, Right : Matrix) return Matrix is
      Result : Matrix (Left'Range (1), Right'Range (2)) := (others => (others => 0.0));
   begin
      for I in Left'Range (1) loop
         for J in Result'Range (2) loop
            for K in Result'Range loop
               Result (I, J) := Result (I, J) + Left (I, K) * Right (K, J);
            end loop;
         end loop;
      end loop;
      return Result;
   end;


end;
