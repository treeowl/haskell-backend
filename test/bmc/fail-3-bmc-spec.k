/*
*/

requires "bmc.k"

module FAIL-3-BMC-SPEC
  imports BMC

  claim (<T> <k> #execute </k> <state> "x" |-> X </state> </T> #And {0 <Int X #Equals true}) #Implies (#AG(#Forall Y . #Forall _ .((<T> <k> _ </k> <state> "x" |-> Y </state> </T>) #Implies {0 <Int Y #Equals true})))  [kore]

endmodule
