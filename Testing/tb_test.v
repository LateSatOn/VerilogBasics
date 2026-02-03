`include "test.v"

module tb_test;
    wire dispenseItem;
    reg clk, coinIn, cancel, itemSelected;
    
    test uut(
        .dispenseItem(dispenseItem),
        .clk(clk),
        .coinIn(coinIn),
        .cancel(cancel),
        .itemSelected(itemSelected)
    );
    
    always #1 clk = ~clk;
    
    initial begin
        $dumpfile("tb_test.vcd");
        $dumpvars(0, tb_test);

        clk = 0; coinIn = 0; cancel = 0; itemSelected = 0;
        #7 itemSelected = 1;      // Select item
        #3 coinIn = 1;         // Insert coin
        #60 $finish;
    end

endmodule