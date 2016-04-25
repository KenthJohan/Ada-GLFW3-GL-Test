with System;
use System;

function OpenGL_Loader_Test (Name : String) return Address with
  Post => OpenGL_Loader_Test'Result /= Null_Address;
