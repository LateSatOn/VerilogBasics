// define states
`define IDLE         2'b00
`define WAIT_COIN    2'b01
`define COIN_IN      2'b10
`define DISPENSE     2'b11
'`
// define item price
`define ITEMPRICE   4'd12

module test (
    output reg  dispenseItem,   // output reg is used when assigned in always block
    input wire  clk,            // input wire for clock and signals
    input wire  coinIn,         // coin inserted
    input wire  cancel,         // cancel transaction
    input wire  itemSelected    // item selected
);
    reg [3:0]   totalMoney;     // total money inserted
    reg [1:0]   state;          // current state
    initial     state = `IDLE;  // initial state
    
    /*
    always @(), runs whenever a specified signal changes.
    In this case, it runs on the positive edge of clk.
    */
    always @(posedge clk) begin
        // state machine, switch statment, cast() ... endcase
        case(state)
        `IDLE: begin // reset outputs and totalMoney
            dispenseItem = 0;
            totalMoney = 0;
            
            if (itemSelected)   state = `WAIT_COIN;
            else                state = `IDLE;
        end
        `WAIT_COIN: begin // wait for coin or cancel
            if (cancel)         state = `IDLE; // Important! Handle cancel first
            else if (coinIn)    state = `COIN_IN;
            else                state = `WAIT_COIN;
        end
        `COIN_IN: begin  // coin inserted, update totalMoney
            totalMoney = totalMoney + 4'd1;
            
            if (cancel)                         state = `IDLE;
            else if (totalMoney == `ITEMPRICE)  state = `DISPENSE;
            else                                state = `WAIT_COIN;
        end
        `DISPENSE: begin // dispense item and reset
            dispenseItem    = 1;
            totalMoney      = 0;
            state = `IDLE;
        end
        endcase
    end
endmodule