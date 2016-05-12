with GL.C.Initializations;
with GL.Programs;
with GL.Programs.Shaders;
with GL.Shaders;
with GL.Shaders.Files;
with GL.Buffers;
with GL.Drawings;
with GL.Programs.Uniforms;
with GL.C;
with GL.Uniforms;


with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;

with Ada.Text_IO;

with OpenGL_Loader_Test;
with Vertices;
with Cameras;
with OS_Systems;
with Maths;

procedure Draw is

   function Setup_Window return GLFW3.Window is
      use GLFW3;
      use GLFW3.Windows;
      use GL.C.Initializations;
      use GL.Drawings;
      W : constant Window := Create_Window_Ada (400, 400, "Hello");
   begin
      Viewport (0, 0, 400, 400);
      Make_Context_Current (W);
      Initialize (OpenGL_Loader_Test'Unrestricted_Access);
      return W;
   end;


   function Setup_Shader (Name : String; Stage : GL.Shaders.Shader_Stage) return GL.Shaders.Shader is
      use GL.Shaders;
      use GL.Shaders.Files;
      use Ada.Text_IO;
      Item : constant Shader := Create_Empty (Stage);
   begin
      Set_Source_File (Item, Name);
      Compile_Checked (Item);
      return Item;
   exception
      when Compile_Error =>
         Put_Line ("Compile_Error");
         Put_Line (Get_Compile_Log (Item));
         return Item;
   end;

   function Setup_Program return GL.Programs.Program is
      use GL.Shaders;
      use GL.Programs;
      use GL.Programs.Shaders;
      use GL.Shaders.Files;
      use Ada.Text_IO;
      Item : constant Program := Create_Empty;
   begin
      Attach (Item, Setup_Shader ("test.glvs", Vertex_Stage));
      Attach (Item, Setup_Shader ("test.glfs", Fragment_Stage));
      Link_Checked (Item);
      return Item;
   exception
      when Link_Error =>
         Put_Line ("Link_Error");
         Put_Line (Get_Link_Log (Item));
         return Item;
   end;



   procedure Get_Translation_Input (W : GLFW3.Window; Translation : in out Maths.Vector_4) is
      use GLFW3.Windows.Keys;
      use Cameras;
      use type Maths.Element;
      use Maths;
      Amount : constant Element := 0.1;
   begin
      Translation := (0.0, 0.0, 0.0, 0.0);
      if Get_Key (W, Key_W) = Key_Action_Press then
         Translation (3) := Translation (3) + Amount;
      end if;
      if Get_Key (W, Key_S) = Key_Action_Press then
         Translation (3) := Translation (3) - Amount;
      end if;
      if Get_Key (W, Key_Space) = Key_Action_Press then
         Translation (2) := Translation (2) - Amount;
      end if;
      if Get_Key (W, Key_Left_Control) = Key_Action_Press then
         Translation (2) := Translation (2) + Amount;
      end if;
      if Get_Key (W, Key_A) = Key_Action_Press then
         Translation (1) := Translation (1) + Amount;
      end if;
      if Get_Key (W, Key_D) = Key_Action_Press then
         Translation (1) := Translation (1) - Amount;
      end if;
   end;



   procedure Get_Rotation_Input (W : GLFW3.Window; Q : in out Maths.Quaternion) is
      use GLFW3.Windows.Keys;
      use Cameras;
      use Maths;
      Pith_Axis : constant Axis := (1.0, 0.0, 0.0);
      Yaw_Axis : constant Axis := (0.0, 1.0, 0.0);
      Amount : constant Degree := 1.0;
      Pith_Up : constant Quaternion := Convert (Pith_Axis, Amount);
      Pith_Down : constant Quaternion := Convert (Pith_Axis, -Amount);
      Yaw_Left : constant Quaternion := Convert (Yaw_Axis, Amount);
      Yaw_Right : constant Quaternion := Convert (Yaw_Axis, -Amount);
   begin

      if Get_Key (W, Key_Up) = Key_Action_Press then
         Q := Hamilton_Product (Q, Pith_Up);
      end if;

      if Get_Key (W, Key_Down) = Key_Action_Press then
         Q := Hamilton_Product (Q, Pith_Down);
      end if;

      if Get_Key (W, Key_Left) = Key_Action_Press then
         Q := Hamilton_Product (Yaw_Left, Q);
      end if;

      if Get_Key (W, Key_Right) = Key_Action_Press then
         Q := Hamilton_Product (Yaw_Right, Q);
      end if;

      Normalize (Q);

   end;

















   procedure Render_Loop (W : GLFW3.Window; L : GL.Uniforms.Location; C : in out Cameras.Camera) is
      use GLFW3;
      use GLFW3.Windows;
      use GLFW3.Windows.Keys;
      use Ada.Text_IO;
      use GL.Buffers;
      use GL.Drawings;
      use Cameras;
      use GL.Uniforms;
      use Maths;
      Translation_Delta : Vector_4;
      Translation : Vector_4 := Zero;
      Q : Quaternion := Unit;
   begin
      loop
         Poll_Events;
         Clear (Color_Plane);
         Clear (Depth_Plane);
         Get_Translation_Input (W, Translation_Delta);
         Translate_Relative (C, Translation_Delta, Translation);
         Get_Rotation_Input (W, Q);
         Set_Rotation (C, Q);
         Modify (L, Build (C)'Address);
         Draw (Triangle_Mode, 0, 3);
         Swap_Buffers (W);

         delay 0.01;
         OS_Systems.Clear_Screen;
         Put (Vector (Q));
         New_Line;
         Put (C);


         pragma Warnings (Off);
         exit when Window_Should_Close (W) = 1;
         pragma Warnings (On);
      end loop;
   end;

   procedure Setup_Vertices is
      use GL.Buffers;
      use type GL.C.GLfloat;
      use Vertices;
      B : constant Buffer := Generate;
      V : Vertex_Array (1 .. 3);
   begin
      V (1).Pos := (0.5, -0.5, 0.0);
      V (1).Col := (1.0, 0.0, 0.0, 1.0);
      V (2).Pos := (-0.5, -0.5, 0.0);
      V (2).Col := (0.0, 1.0, 0.0, 1.0);
      V (3).Pos := (0.0,  0.5, 0.0);
      V (3).Col := (0.0, 0.0, 1.0, 1.0);
      Bind (Array_Slot, B);
      Allocate (Array_Slot, Bit (V'Size), Static_Usage);
      Redefine (Array_Slot, 0, Bit (V'Size), V'Address);
   end;

begin

   GLFW3.Initialize;

   declare
      use GLFW3;
      use GLFW3.Windows;
      use GL.Programs;
      use GL.Buffers;
      use GL.Programs.Uniforms;
      use Vertices;
      use Cameras;
      use type Maths.Element;
      C : Camera := Create;
      W : constant Window := Setup_Window;
      P : constant Program := Setup_Program;
      L : constant GL.Uniforms.Location := Get (P, "transform");
   begin
      Set_Perspective (C, 90.0, 3.0/4.0, 0.1, 80.0);
      Setup_Vertices;
      Setup_Vertex_Attribute;
      Set_Current (P);
      Render_Loop (W, L, C);
      Destroy_Window (W);
   end;


end;
