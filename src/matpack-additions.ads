package Matpack.Additions is

   generic
      type Index is range <>;
      type Element is digits <>;
      type Vector is array (Index) of Element;
   function Generic_CVecN_CVecN_Addition (Left : Vector; Right : Vector) return Vector;

end;
