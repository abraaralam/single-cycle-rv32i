`timescale 1ns / 1ps

module top_tb();

    logic clk;
    logic reset;

    top uut (
        .clk(clk),
        .reset(reset)
    );

    // 10ns period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        
        #10;
        reset = 0;

        // 110ns
        #109;

        $stop;
    end

endmodule
