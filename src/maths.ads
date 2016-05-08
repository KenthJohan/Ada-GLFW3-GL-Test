with GL.C;

package Maths is

   subtype Element is GL.C.GLfloat;

   type Vector is array (Integer range <>) of Element;
   type Matrix is array (Integer range <>, Integer range <>) of Element;
   subtype Square_Matrix is Matrix with Dynamic_Predicate => Square_Matrix'Length (1) = Square_Matrix'Length (2);

   subtype Matrix_3 is Square_Matrix (1 .. 3, 1 .. 3);
   subtype Matrix_4 is Square_Matrix (1 .. 4, 1 .. 4);
   subtype Vector_3 is Vector (1 .. 3);
   subtype Vector_4 is Vector (1 .. 4);
   subtype Quaternion is Vector_4;


   function Unit return Quaternion is (1.0, 0.0, 0.0, 0.0);
   procedure Convert (Axis : Vector_3; Angle : Element; Result : out Quaternion);
   function Convert (Axis : Vector_3; Angle : Element) return Quaternion;
   procedure Hamilton_Product (Left, Right : Quaternion; Result : out Quaternion);
   function Hamilton_Product (Left, Right : Quaternion) return Quaternion;
   procedure Convert (Item : Quaternion; Result : out Matrix_4);
   function Convert (Item : Quaternion) return Matrix_4;

   procedure Make_Unit (Item : out Square_Matrix);
   procedure Product (Left, Right : Matrix_4; I, J : Integer; Result : out Matrix_4);
   procedure Product_IJ (Left, Right : Matrix_4; Result : out Matrix_4);
   procedure Product_JI (Left, Right : Matrix_4; Result : out Matrix_4);
   function Product_IJ (Left, Right : Matrix_4) return Matrix_4;
   function Product_JI (Left, Right : Matrix_4) return Matrix_4;

   function Length2 (Item : Vector) return Element;
   function Length (Item : Vector) return Element;
   procedure Scale (Item : in out Vector; Factor : Element);
   procedure Normalize (Item : in out Vector);



   procedure Make_Frustum_RC (Item : out Matrix_4; Left, Right, Bottom, Top, Near, Far : Element);
   procedure Make_Frustum_CR (Item : out Matrix_4; Left, Right, Bottom, Top, Near, Far : Element);
   procedure Make_Perspective_CR (Item : in out Matrix_4; Field_Of_View, Aspect, Near, Far : Element);
   procedure Make_Perspective_RC (Item : in out Matrix_4; Field_Of_View, Aspect, Near, Far : Element);
   procedure Make_Translation_RC (Item : in out Matrix_4; Translation : Vector_3);
   procedure Make_Translation_CR (Item : in out Matrix_4; Translation : Vector_3);

end;
