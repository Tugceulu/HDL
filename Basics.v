// no inputs and one output that output should always drive 1 (or logic high).
module top_module( output one );
    //1 bit 
    //'
    //b bit
    //number 1
    assign one = 1'b1;

endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//no inputs and one output that outputs a constant 0
module top_module(
    output zero
);
    assign zero=1'b0;

endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//a module with one input and one output that behaves like a wire
module top_module( input wire in, output wire out );
	assign out=in;
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//a module with 3 inputs and 4 outputs,a -> w, b -> x, b -> y, c -> z
module top_module( 
    input a,b,c,
    output w,x,y,z );
	assign w=a;
    assign x=b;
    assign y=b;
    assign z=c;
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//a module that implements a NOT gate
//Verilog has separate bitwise-NOT (~) and logical-NOT (!) operators, like C. Since we're working with a one-bit here, it doesn't matter which we choose
module top_module( input in, output out );
    assign out=~in;
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//a module that implements an AND gate
//Verilog has separate bitwise-AND (&) and logical-AND (&&) operators, like C. Since we're working with a one-bit here, it doesn't matter which we choose
module top_module( 
    input a, 
    input b, 
    output out );
	assign out=a&b;
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//a module that implements a NOR gate
//Verilog has separate bitwise-OR (|) and logical-OR (||) operators, like C. Since we're working with a one-bit here, it doesn't matter which we choose
module top_module( 
    input a, 
    input b, 
    output out );
    assign out=~(a|b);

endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//a module that implements an XNOR gate
module top_module( 
    input a, 
    input b, 
    output out );
    assign out=~(a^b);
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Declaring wires
`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    
    wire twowiretwo;
    wire twowireone;
    wire one_wire;
    
    assign out_n=~one_wire;
    assign out=one_wire;
    assign one_wire=twowireone|twowiretwo;
	assign twowiretwo=c&d;
    assign twowireone=a&b;
    
    
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//The 7458 is a chip with four AND gates and two OR gates
module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    
	wire wire_p2_1,wire_p2_2;
    assign p2y=wire_p2_2|wire_p2_1;
	assign wire_p2_2= p2c&p2d;
    assign wire_p2_1=p2a&p2b;
    
    wire wire_p1_1,wire_p1_2;
    assign p1y=wire_p1_1|wire_p1_2;
    assign wire_p1_2=p1f&p1e&p1d;
    assign wire_p1_1=p1a&p1b&p1c;
endmodule
