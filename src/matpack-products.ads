package Matpack.Products is

   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index, Index) of Element;
   function Generic_CMatNxN_CMatNxN_Product_IKJ
     (Left : Matrix; Right : Matrix) return Matrix;


   -- Left^T Right + Result -> Result
   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index, Index) of Element;
      type Vector is array (Index) of Element;
   procedure Generic_CMatNxN_CMatNxN_CVecN_Transpose_Product_Accumulate
     (Left : Matrix; Right : Vector; Result : in out Vector);

   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index, Index) of Element;
      type Vector is array (Index) of Element;
   function Generic_CMatNxN_CVecN_Product (Left : Matrix; Right : Vector) return Vector;





end;
