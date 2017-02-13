with GL.C;
with GL.Math;
with System;
with GL.C.Complete;
with GL.Drawings;
with GL.Programs;

package body Simple_Text_Render is



   procedure Load_Texture (Item : in out Text_Render) is
      use GL.Math;
      use GL.Buffers;
      use GL.Vertex_Array_Objects;
      use GL.Textures;
      use GL.C.Complete;
      use GL.C;
      use System;
      use type GL.C.GLint;
      use type GL.Math.Real_Float;
      type Vertex_Array1 is array (Integer range <>) of Real_Float_Vector4;
      type Bitmap is array (Integer range <>, Integer range <>) of GL.C.GLubyte;
      Bitmap_Data : Bitmap (1 .. 100, 1 .. 100) := (others => (others => 200));
      Bitmap_Data2 : Bitmap (1 .. 10, 1 .. 10);
      Vertex_Data : Vertex_Array1 (1 .. 6) := (others => (others => 0.0));
      X : constant Real_Float := 0.0;
      Y : constant Real_Float := 0.0;
      W : constant Real_Float := 1.0;
      H : constant Real_Float := 1.0;
   begin
      Bitmap_Data2 :=
        (
         (255, 255, 255, 255, 255, 255, 255, 255, 255, 255),
         (255, 255, 255, 255, 255, 255, 255, 255, 255, 255),
         (255, 255, 255, 255, 255, 255, 255, 255, 255, 255),
         (255, 255, 255, 255, 255, 255, 255, 255, 255, 255),
         (255, 255, 255, 255, 255, 255, 255, 255, 255, 255),
         (255, 255, 255, 255, 255, 255, 255, 255, 255, 255),
         (255, 255, 255, 255, 255, 255, 255, 255, 255, 255),
         (255, 255, 255, 255, 255, 255, 255, 255, 255, 255),
         (255, 255, 255, 255, 255, 255, 255, 255, 255, 255),
         (50, 255, 255, 255, 255, 255, 255, 255, 255, 255)
        );
--        for X in Bitmap_Data'Range (1) loop
--           for Y in Bitmap_Data'Range (2) loop
--              if abs (X - Y) > 5 then
--                 Bitmap_Data (X, Y) := 0;
--              end if;
--           end loop;
--        end loop;
      Vertex_Data (1) := (X,     Y + H, 0.0, 0.0);
      Vertex_Data (2) := (X,     Y,     0.0, 1.0);
      Vertex_Data (3) := (X + W, Y,     1.0, 1.0);
      Vertex_Data (4) := (X,     Y + H, 0.0, 0.0);
      Vertex_Data (5) := (X + W, Y,     1.0, 1.0);
      Vertex_Data (6) := (X + W, Y + H, 1.0, 0.0);

      --Shader list need to be empty for this to works.
      --Empty the list does not feel like a good solution.
      Item.P.Shader_List.Empty;
      Item.P.Obj := GL.Programs.Create_Empty;
      Simple_Shaders.Append (Item.P, "text.glvs");
      Simple_Shaders.Append (Item.P, "text.glfs");
      Simple_Shaders.Build (Item.P);

      --glActiveTexture (GL_TEXTURE0);
      --glEnable (GL_BLEND);
      --GL.Textures.Set_Unpack_Pixel_Alignment (1);


      Item.T := Create (Texture_2D_Texture_Target);

      Set_Parameter (Item.T, Texture_Wrap_S, Repeat_Param);
      Set_Parameter (Item.T, Texture_Wrap_T, Repeat_Param);
      Set_Parameter (Item.T, Texture_Mag_Filter, Nearest_Param);
      Set_Parameter (Item.T, Texture_Min_Filter, Nearest_Param);
      Allocate (Item.T, RGBA2_Internal_Pixel_Format, 10, 10);
      --Load (Item.T, 0, 0, 100, 100, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data'Address);
      Load (Item.T, 0, 0, 10, 10, RGB_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data2'Address);
      --Load (Item.T, 0, 20, 10, 10, RGBA_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data2'Address);
      --Load (Texture_2D_Texture_Target, 100, 100, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data'Address);
      --Load (Item.T, 0, 0, 100, 100, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data'Address);
      --Load (Item.T, 0, 0, 50, 50, Red_Pixel_Format, Unsigned_Byte_Pixel_Type, Bitmap_Data'Address);


      Item.VBO := GL.Buffers.Create_Buffer;
      Item.VAO := GL.Vertex_Array_Objects.Generate_Attribute;
      Create_New_Storage (Item.VBO, Vertex_Data'Size / Storage_Unit, Vertex_Data'Address, Dynamic_Usage);
      Set_Attribute_Enable (Item.VAO, 0);
      Set_Attribute_Memory_Layout (Item.VAO, 0, Real_Float_Vector4'Length, Float_Type, False, 0);
      glVertexArrayAttribBinding (GLuint (Item.VAO), 0, 0);
      glVertexArrayVertexBuffer (GLuint (Item.VAO), 0, GLuint (Item.VBO), 0, Vertex_Array1'Component_Size / Storage_Unit);
   end;

   -- Program object is invalid if the application is restarted.
   procedure Render (Item : in out Text_Render) is
      use GL.Textures;
   begin
      Bind (Texture_2D_Texture_Target, Item.T);
      GL.Programs.Set_Current (Item.P.Obj);
      GL.Vertex_Array_Objects.Bind (Item.VAO);
      GL.Drawings.Draw (GL.Drawings.Triangles_Mode, 0, 6);
      null;
   end;


end;
