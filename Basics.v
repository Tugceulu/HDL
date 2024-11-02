// no inputs and one output that output should always drive 1 (or logic high).
module top_module( output one );
    //1 bit 
    //'
    //b bit
    //number 1
    assign one = 1'b1;

endmodule
//no inputs and one output that outputs a constant 0
module top_module(
    output zero
);
    assign zero=1'b0;

endmodule

