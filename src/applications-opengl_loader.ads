with System;

package Applications.OpenGL_Loader is

   use System;

   function Loader (Name : String) return Address with
     Post => Loader'Result /= Null_Address;

end;
