module fv_ripple_carry_adder #(parameter WIDTH = 32) (
input logic clk,
input logic arst_n,    
input logic [WIDTH-1:0] a, b, 
input logic cin,              
input logic [WIDTH-1:0] sum,
input logic cout            
);
  `include "includes.svh"
  // Here add yours ASSERTIONS, COVERAGE, ASSUMPTIONS, etc.

  logic [WIDTH:0] aux_result, aux_result_reg;

  assign aux_result = a + b + cin;

  bus_shift #(.DELAY(WIDTH), .WIDTH(WIDTH+1)) shift_result (
    .clk        (clk),
    .arst_n     (arst_n),
    .in         (aux_result),
    .out        (aux_result_reg)
  );

  `AST(RCA, eventually_test, $rose(arst_n) |-> ## WIDTH,  {cout, sum} == aux_result_reg)
  
endmodule

bind ripple_carry_adder fv_ripple_carry_adder fv_ripple_carry_adder_i(.*);

