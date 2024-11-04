////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//one 3bit input
module top_module ( 
    input wire [2:0] vec,
    output wire [2:0] outv,
    output wire o2,
    output wire o1,
    output wire o0  ); // Module body starts after module declaration
    assign o0=vec[0];
    assign o1=vec[1];
    assign o2=vec[2];
    assign outv=vec[2:0];
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Declaring Vectors  
//type [upper:lower] vector_name;
//wire [7:0] w;         // 8-bit wire
//reg  [4:1] x;         // 4-bit reg
//output reg [0:0] y;   // 1-bit reg that is also an output port (this is still a vector)
//input wire [3:-2] z;  // 6-bit wire input (negative ranges are allowed)
//output [3:0] a;       // 4-bit output wire. Type is 'wire' unless specified otherwise.
//wire [0:7] b;         // 8-bit wire where b[0] is the most-significant bit.
//the least significant bit has a lower index (little-endian, e.g., [3:0]) or a higher index (big-endian, e.g., [0:3]).once a vector is declared with a particular endianness, it must always be used the same way.
//Implicit nets
wire [2:0] a, c;   // Two vectors
assign a = 3'b101;  // a = 101
assign b = a;       // b =   1  implicitly-created wire
assign c = b;       // c = 001  <-- bug
my_module i1 (d,e); // d and e are implicitly one-bit wide if not declared.
                    // This could be a bug if the port was intended to be a vector.
//Unpacked vs. Packed Arrays
reg [7:0] mem [255:0];   // 256 unpacked elements, each of which is a 8-bit packed vector of reg.
reg mem2 [28:0];         // 29 unpacked elements, each of which is a 1-bit reg.

//Accessing Vector Elements: Part-Select
w[3:0]      // Only the lower 4 bits of w
x[1]        // The lowest bit of x
x[1:1]      // ...also the lowest bit of x
z[-1:-2]    // Two lowest bits of z
b[3:0]      // Illegal. Vector part-select must match the direction of the declaration.
b[0:3]      // The *upper* 4 bits of b.
assign w[3:0] = b[0:3];    // Assign upper 4 bits of b to lower 4 bits of w. w[3]=b[0], w[2]=b[1], etc.
//a combinational circuit that splits an input half-word (16 bits, [15:0] ) into lower [7:0] and upper [15:8] bytes
`default_nettype none     // Disable implicit nets. Reduces some types of bugs.
module top_module( 
    input wire [15:0] in,
    output wire [7:0] out_hi,
    output wire [7:0] out_lo );
    assign out_hi[7:0]=in[15:8];
    assign out_lo[7:0]=in[7:0];
    
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//A 32-bit vector can be viewed as containing 4 bytes (bits [31:24], [23:16], etc.). Build a circuit that will reverse the byte ordering of the 4-byte word.
module top_module( 
    input [31:0] in,
    output [31:0] out );//
    assign out[31:24]=in[7:0];  
    assign out[23:16]=in[15:8]; 
    assign out[15:8]=in[23:16] ;  
    assign out[7:0]=in[31:24];
    // assign out[31:24] = ...;

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Bitwise vs. Logical Operators
module top_module( 
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    assign out_or_bitwise[2]=a[2]|b[2];
    assign out_or_bitwise[1]=a[1]|b[1];
    assign out_or_bitwise[0]=a[0]|b[0];
    
    assign out_or_logical=a||b;
    
    assign out_not[5]=~b[2];
    assign out_not[4]=~b[1];
    assign out_not[3]=~b[0];
    assign out_not[2]=~a[2];
    assign out_not[1]=~a[1];
    assign out_not[0]=~a[0];

endmodule
//2nd
	assign out_or_bitwise = a | b;
	assign out_or_logical = a || b;

	assign out_not[2:0] = ~a;	// Part-select on left side is o.
	assign out_not[5:3] = ~b;	//Assigning to [5:3] does not conflict with [2:0]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Build a combinational circuit with four inputs, in[3:0]
//There are 3 outputs:
//out_and: output of a 4-input AND gate.
//out_or: output of a 4-input OR gate.
//out_xor: output of a 4-input XOR gate.

module top_module( 
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    assign out_and=in[3]&in[2]&in[1]&in[0];
    assign out_or=in||in;
    assign out_xor=in[3]^in[2]^in[1]^in[0];

endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//The concatenation operator
{3'b111, 3'b000} => 6'b111000
{1'b1, 1'b0, 3'b101} => 5'b10101
{4'ha, 4'd10} => 8'b10101010  
input [15:0] in;
output [23:0] out;
assign {out[7:0], out[15:8]} = in;         // Swap two bytes. Right side and left side are both 16-bit vectors.
assign out[15:0] = {in[7:0], in[15:8]};    // This is the same thing.
assign out = {in[7:0], in[15:8]};       // This is different. The 16-bit vector on the right is extended to
                                        // match the 24-bit vector on the left, so out[23:16] are zero.
                                        // In the first two examples, out[23:16] are not assigned.
//
module top_module (
    input [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z );
    
    assign z[7:0]={e[0], f[4:0],1'b1,1'b1};
    assign y[7:0]={d[3:0], e[4:1]};
    assign x[7:0]={b[1:0], c[4:0], d[4]};
    assign w[7:0]={a[4:0], b[4:2]};
    // assign { ... } = { ... };

endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Given an 8-bit input vector [7:0], reverse its bit ordering
module top_module( 
    input [7:0] in,
    output [7:0] out
);
	assign {out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7]} = in;
endmodule
//loop example
generate
		genvar i;
		for (i=0; i<8; i = i+1) begin: my_block_name
			assign out[i] = in[8-i-1];
		end
	endgenerate
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//The concatenation operator 
{5{1'b1}}           // 5'b11111 (or 5'd31 or 5'h1f)
{2{a,b,c}}          // The same as {a,b,c,a,b,c}
{3'd5, {2{3'd6}}}   // 9'b101_110_110. It's a concatenation of 101 with
                    // the second vector, which is two copies of 3'b110.
replicating the sign bit (the most significant bit) of the smaller number to the left. For example, 
sign-extending 4'b0101 (5) to 8 bits results in 8'b00000101 (5), 
while sign-extending 4'b1101 (-3) to 8 bits results in 8'b11111101 (-3)
// a circuit that sign-extends an 8-bit number to 32 bits
  module top_module (
    input [7:0] in,
    output [31:0] out );//
    assign out={ {24{in[7]}} , in};


    // assign out = { replicate-sign-bit , the-input };

endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
module top_module (
    input a, b, c, d, e,
    output [24:0] out );//

    // The output is XNOR of two vectors created by 
    // concatenating and replicating the five inputs.
    // assign out = ~{ ... } ^ { ... };
    assign out=~{ {5{a}},{5{b}},{5{c}},{5{d}},{5{e}}} ^ { {5{a,b,c,d,e}}};
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
