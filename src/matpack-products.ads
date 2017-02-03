package Matpack.Products is

   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index, Index) of Element;
   function Generic_Constrained_Square_Matrix_Matrix_Product_IKJ
     (Left : Matrix; Right : Matrix) return Matrix;

   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index, Index) of Element;
      type Vector is array (Index) of Element;
   function Generic_Constrained_Square_Matrix_Vector_Product
     (Left : Matrix; Right : Vector) return Vector;


   -- Left^T Right + Result -> Result
   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index, Index) of Element;
      type Vector is array (Index) of Element;
   procedure Generic_Constrianed_Square_Matrix_Vector_Transpose_Product_Accumulate
     (Left : Matrix; Right : Vector; Result : in out Vector);







end;
