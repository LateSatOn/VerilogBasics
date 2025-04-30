// =========================== TEST BENCH =========================== //
module testbench;
    wire [7:0] Result;        // wire to hold output result from the ALU
    reg [7:0] opA, opB;       // 8-bit inputs A and B (operands)
    reg [3:0] opS;            // 3-bit select signal to choose ALU operation

    top UUT(Result, opA, opB, opS); 

    initial begin
        opS = 4'd1;           // select ADD operation
        opA = 8'd2;           // operand A = 2
        opB = 8'd5;           // operand B = 5

        #1;                   // wait one unit of simulation time for values to settle

        $display("%d", Result); // print result to terminal (in decimal)
    end
endmodule

// =========================== TOP MODULE =========================== //
module top(Result, opA, opB, opS);
    output [7:0] Result;
    input [7:0] opA, opB;
    input [3:0] opS;

    // internal wires to connect submodules to the multiplexer
    wire [7:0] w_nop, w_add, w_sub, w_and, w_or, w_xor, 
               w_invert, w_shift_left, w_shift_righ;

    // instantiating each operation module
    NOP nop_inst(w_nop, opA,opB);
    ADD add_inst(w_add, opA, opB);              // addition
    SUB sub_inst(w_sub, opA, opB);              // subtraction
    AND and_inst(w_and, opA, opB);              // bitwise AND
    OR or_inst(w_or, opA, opB);                 // bitwise OR
    XOR xor_inst(w_xor, opA, opB);              // bitwise XOR
    INVERT invert_inst(w_invert, opA);          // bitwise NOT
    SHIFT_LEFT shift_left_inst(w_shift_left, opA);   // shift left
    SHIFT_RIGHT shift_right_inst(w_shift_righ, opA); // shift right

    // multiplexer chooses output based on opS
    MUX mux_inst(Result, w_nop, w_add, w_sub, w_and, w_or, w_xor, 
                 w_invert, w_shift_left, w_shift_righ, opS);
endmodule

// =========================== MULTIPLEXER =========================== //
module MUX(result, nop_wire, add_out, sub_out, and_out, or_out, xor_out, invert_out, shift_left_out, shift_right_out, opS);
    output reg [7:0] result;
    input [7:0] nop_wire, add_out, sub_out, and_out, or_out, xor_out, invert_out, shift_left_out, shift_right_out;
    input [3:0] opS;

    // selects the output operation based on opS value
    always @(*) begin
        case (opS)
            4'd0: result = nop_wire;            // NOP
            4'd1: result = add_out;         // ADD
            4'd2: result = sub_out;         // SUB
            4'd3: result = and_out;         // AND
            4'd4: result = or_out;          // OR
            4'd5: result = xor_out;         // XOR
            4'd6: result = invert_out;      // NOT
            4'd7: result = shift_left_out;  // SHIFT LEFT
            4'd8: result = shift_right_out; // SHIFT RIGHT
            default: result = nop_wire;         // fallback
        endcase
    end
endmodule

// =========================== LOGIC MODULES =========================== //
module NOP(result, opA, opB);
    output [7:0] result;
    input [7:0] opA, opB;
    assign result = 8'd0;
endmodule

module ADD(result, opA, opB);
    output [7:0] result;
    input [7:0] opA, opB;
    assign result = opA + opB; // perform addition
endmodule

module SUB(result, opA, opB);
    output [7:0] result;
    input [7:0] opA, opB;
    assign result = opA - opB; // perform subtraction
endmodule

module AND(result, opA, opB);
    output [7:0] result;
    input [7:0] opA, opB;
    assign result = opA & opB; // bitwise AND
endmodule

module OR(result, opA, opB);
    output [7:0] result;
    input [7:0] opA, opB;
    assign result = opA | opB; // bitwise OR
endmodule

module XOR(result, opA, opB);
    output [7:0] result;
    input [7:0] opA, opB;
    assign result = opA ^ opB; // bitwise XOR
endmodule

module INVERT(result, op);
    output [7:0] result;
    input [7:0] op;
    assign result = ~op; // bitwise NOT
endmodule

module SHIFT_LEFT(result, op);
    output [7:0] result;
    input [7:0] op;
    assign result = op << 1; // shift left by 1 bit
endmodule

module SHIFT_RIGHT(result, op);
    output [7:0] result;
    input [7:0] op;
    assign result = op >> 1; // shift right by 1 bit
endmodule
