with Ada.Containers.Synchronized_Queue_Interfaces;
with Ada.Containers.Unbounded_Priority_Queues;
with Ada.Strings.Unbounded;

package Simple_Debug_Systems is

   type Debug_Message_Queue is limited private;
   type Debug_Message is private;

   procedure Enqueue (Item : in out Debug_Message_Queue; Priority : Natural; Message_String : String);
   procedure Enqueue (Priority : Natural; Message_String : String);
   procedure Put_Lines_Dequeue (Item : in out Debug_Message_Queue);
   procedure Put_Lines_Dequeue;

private


   type Debug_Message is record
      Priority : Natural;
      Content  : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   function Get_Priority (Element : Debug_Message) return Natural;
   function Before (Left, Right : Natural) return Boolean;

   package Debug_Message_Queues is new Ada.Containers.Synchronized_Queue_Interfaces (Debug_Message);
   package Debug_Message_Queues_Priority_Queues is new Ada.Containers.Unbounded_Priority_Queues (Debug_Message_Queues, Natural);

   type Debug_Message_Queue is record
      Q : Debug_Message_Queues_Priority_Queues.Queue;
   end record;

   Global_Debug_Message_Queue : Debug_Message_Queue;

end;
