//Connecting Signals to Module Ports
module top_module ( input a, input b, output out );
    mod_a instance1 ( a, b, out );  
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Module pos
module top_module ( 
    input a, 
    input b, 
    input c,
    input d,
    output out1,
    output out2
);
    mod_a instance1 ( out1, out2, a, b, c, d );

endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Module name
module top_module ( 
    input a, 
    input b, 
    input c,
    input d,
    output out1,
    output out2
);
    mod_a instance2 ( .out1(out1), .out2(out2), .in1(a), .in2(b), .in3(c), .in4(d) );

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Module shift
module top_module ( input clk, input d, output q );
    wire out1,out2;
    my_dff d1 ( .clk(clk), .d(d), .q(out1));
    my_dff d2 ( .clk(clk), .d(out1), .q(out2));
    my_dff d3 ( .clk(clk), .d(out2), .q(q));
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Module shift8
module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] out1,out2,out3;
    my_dff8 d1 ( .clk(clk), .d(d), .q(out1));
    my_dff8 d2 ( .clk(clk), .d(out1), .q(out2));
    my_dff8 d3 ( .clk(clk), .d(out2), .q(out3));
    
    always @(*) begin
        case(sel)
            0:q=d;
            1:q=out1;
            2:q=out2;
            3:q=out3;
        endcase
    end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Module add
module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] cout1;
    add16 add_1( a[15:0],b[15:0],0,sum[15:0],cout1);
    add16 add_2( a[31:16],b[31:16],cout1,sum[31:16]);

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Module fadd
module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

wire cout1;
    add16 add_one ( a[15:0], b[15:0], 0, sum[15:0], cout1);
    add16 add_two ( a[31:16], b[31:16], cout1, sum[31:16]);
endmodule
module add1 ( input a, input b, input cin,   output sum, output cout );
	assign sum=a^b^cin;
    assign cout=(a&b)|(a&cin)|(b&cin);

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Module cseladd
module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0]cout1,cout2,cout3;
    wire [15:0] sum2,sum3;
    //add16 add_one ( a[15:0], b[15:0], 0, sum[15:0], cout1);
    //add16 add_two ( a[31:16], b[31:16], 0, sum[31:16], cout2);
    //add16 add_three ( a[31:16], b[31:16], 1, sum[31:16], cout3);

    add16 add_one ( .a(a[15:0]), .b(b[15:0]), .cin(0), .sum(sum[15:0]), .cout(cout1));
    add16 add_two ( .a(a[31:16]), .b(b[31:16]), .cin(0), .sum(sum2), .cout(cout2));
    add16 add_three ( .a(a[31:16]), .b(b[31:16]), .cin(1), .sum(sum3), .cout(cout3));
   
    always @(cout1,sum2,sum3) begin
        case(cout1)
            0:sum[31:16]=sum2;
            1:sum[31:16]=sum3;
        endcase
    end
endmodule


	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Module addsub
module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire cout1;
    wire [31:0] bxor;
    assign bxor={32{sub}}^b;
    add16 add_one ( .a(a[15:0]), .b(bxor[15:0]), .cin(sub), .sum(sum[15:0]), .cout(cout1));
    add16 add_two ( .a(a[31:16]), .b(bxor[31:16]), .cin(cout1), .sum(sum[31:16]));
    
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
