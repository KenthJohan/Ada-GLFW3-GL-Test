with GL.C;

package Maths2 is

   type Dimension is new Integer;
   type Element is new GL.C.GLfloat;
   type Vector is array (Dimension range <>) of Element;
   type Matrix is array (Dimension range <>, Dimension range <>) of Element;


   function "*" (Left, Right : Matrix) return Matrix;


end;
