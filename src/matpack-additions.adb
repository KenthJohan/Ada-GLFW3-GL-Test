package body Matpack.Additions is


   function Generic_CVecN_CVecN_Addition (Left : Vector; Right : Vector) return Vector is
      Result : Vector;
   begin
      for I in Index loop
         Result (I) := Left (I) + Right (I);
      end loop;
      return Result;
   end;

end;
