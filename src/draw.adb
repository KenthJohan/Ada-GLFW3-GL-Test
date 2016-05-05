with GL.C.Initializations;
with GL.Programs;
with GL.Programs.Vertex_Attributes;
with GL.Programs.Shaders;
with GL.Programs.Uniforms;
with GL.Shaders;
with GL.Shaders.Files;
with GL.Uniforms;
with GL.Vertex_Attributes;
with GL.Buffers;

with GLFW3;
with GLFW3.Windows;
with GLFW3.Windows.Keys;

with Ada.Text_IO;

with OpenGL_Loader_Test;

with Cameras;

with OS_Systems;


procedure Draw is

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



   procedure Render_Loop (W : GLFW3.Window; L : GL.Uniforms.Location; C : in out Cameras.Camera) is
      use GLFW3;
      use GLFW3.Windows;
      use GLFW3.Windows.Keys;
      use OS_Systems;
      use Ada.Text_IO;
      use Cameras;
      use GL.Uniforms;
   begin
      loop
         Poll_Events;

         delay 0.1;
         Clear_Screen;

         if Get_Key (W, Key_Up) = Key_Action_Press then
            Put_Line ("Key_Up");
            Rotate_RC (C, Convert ((1.0, 0.0, 0.0), Degree (5.0)));
         else
            New_Line;
         end if;

         if Get_Key (W, Key_Down) = Key_Action_Press then
            Put_Line ("Key_Down");
            Rotate_RC (C, Convert ((1.0, 0.0, 0.0), Degree (-5.0)));
         else
            New_Line;
         end if;

         if Get_Key (W, Key_Space) = Key_Action_Press then
            Put_Line ("Key_Space");
            Translate_RC (C, (0.0, 0.0, 0.1));
         else
            New_Line;
         end if;

         if Get_Key (W, Key_Left_Control) = Key_Action_Press then
            Put_Line ("Key_Left_Control");
            Translate_RC (C, (0.0, 0.0, -0.1));
         else
            New_Line;
         end if;

         Put (C);

         Modify (L, Build (C)'Address);

         pragma Warnings (Off);
         exit when Window_Should_Close (W) = 1;
         pragma Warnings (On);
      end loop;
   end;

   function Setup_Window return GLFW3.Window is
      use GLFW3;
      use GLFW3.Windows;
      use GL.C.Initializations;
      W : constant Window := Create_Window_Ada (400, 400, "Hello");
   begin
      Make_Context_Current (W);
      Initialize (OpenGL_Loader_Test'Unrestricted_Access);
      return W;
   end;


   procedure Setup_Vertices (Item : GL.Buffers.Buffer) is
      use GL.Vertex_Attributes;
      use GL.Buffers;
      type Vector is array (Integer range <>) of Float;
      subtype Vector_3 is Vector (1 .. 3);
      subtype Vector_4 is Vector (1 .. 4);
      type Vertex is record
         A : Vector_3;
         C : Vector_4;
      end record;
      type Vertex_Array is array (Integer range <>) of Vertex;
      Cube : Vertex_Array (1 .. 36);
   begin
      Cube (1).A := (-1.0,-1.0,-1.0);
      Cube (2).A := (-1.0,-1.0, 1.0);
      Cube (3).A := (-1.0, 1.0, 1.0);
      Cube (4).A := (1.0, 1.0,-1.0);
      Cube (5).A := (-1.0,-1.0,-1.0);
      Cube (6).A := (-1.0, 1.0,-1.0);
      Cube (7).A := (1.0,-1.0, 1.0);
      Cube (8).A := (-1.0,-1.0,-1.0);
      Cube (9).A := (1.0,-1.0,-1.0);
      Cube (10).A := (1.0, 1.0,-1.0);
      Cube (11).A := (1.0,-1.0,-1.0);
      Cube (12).A := (-1.0,-1.0,-1.0);
      Cube (13).A := (-1.0,-1.0,-1.0);
      Cube (14).A := (-1.0, 1.0, 1.0);
      Cube (15).A := (-1.0, 1.0,-1.0);
      Cube (16).A := (1.0,-1.0, 1.0);
      Cube (17).A := (-1.0,-1.0, 1.0);
      Cube (18).A := (-1.0,-1.0,-1.0);
      Cube (19).A := (-1.0, 1.0, 1.0);
      Cube (20).A := (-1.0,-1.0, 1.0);
      Cube (21).A := (1.0,-1.0, 1.0);
      Cube (22).A := (1.0, 1.0, 1.0);
      Cube (23).A := (1.0,-1.0,-1.0);
      Cube (24).A := (1.0, 1.0,-1.0);
      Cube (25).A := (1.0,-1.0,-1.0);
      Cube (26).A := (1.0, 1.0, 1.0);
      Cube (27).A := (1.0,-1.0, 1.0);
      Cube (28).A := (1.0, 1.0, 1.0);
      Cube (29).A := (1.0, 1.0,-1.0);
      Cube (30).A := (-1.0, 1.0,-1.0);
      Cube (31).A := (1.0, 1.0, 1.0);
      Cube (32).A := (-1.0, 1.0,-1.0);
      Cube (33).A := (-1.0, 1.0, 1.0);
      Cube (34).A := (1.0, 1.0, 1.0);
      Cube (35).A := (-1.0, 1.0, 1.0);
      Cube (36).A := (1.0,-1.0, 1.0);

   end;


begin

   GLFW3.Initialize;

   declare
      use GLFW3;
      use GLFW3.Windows;
      use Ada.Text_IO;
      use GL.Programs;
      use GL.Programs.Uniforms;
      use GL.Uniforms;
      use GL.Vertex_Attributes;
      use GL.Programs.Vertex_Attributes;
      use Cameras;
      W : constant Window := Setup_Window;
      P : constant Program := Setup_Program;
      UL : constant GL.Uniforms.Location := Get (P, "transform");
      VL : constant GL.Vertex_Attributes.Location := Get (P, "position");
      C : Camera := Create_RC;
      CC : Character;
   begin
      Put_Line_Fancy (UL);
      Put_Line_Fancy (VL);
      Get_Immediate (CC);
      Perspective_RC (C, 90.0, 3.0/4.0, 5.0, 80.0);
      Render_Loop (W, UL, C);
      Destroy_Window (W);
   end;


end;
