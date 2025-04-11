`include "SampleLogicModels.v"  // include our models

// In regular use you should only have one testbench and one UUT in a file
module testbench(); // Half-Bit Adder Testbench

    wire S, C;  // outputs
    reg A,B;    // inputs

    halfBitAdder UUT (S, C, A, B);  // order does matter!!

    initial begin
        $display("A B | S C"); // prints to terminal
        $display("----|----");
        for (integer i = 0; i < 4; i++) begin  // loop 4 times
            {A, B} = i[1:0];    // Sets 'A' and 'B' to the two least significant  bits of 'i'
            
            #1; // one instance of time, 'locks in' values, preforms UUT logic 
            
            $display("%b %b | %b %b", A, B, S, C);  // displays calculated truth table
        end
    end
endmodule

// In regular use you should only have one testbench and one UUT in a file
module testbench(); // Full-Bit Adder Testbench

    wire S, C_out;  // outputs
    reg A, B, C_in;    // inputs

    fullBitAdder UUT (S, C_out, A, B, C_in);  // order does matter!!

    initial begin
        $display("A B C_in| S C_out"); // prints to terminal
        $display("--------|--------");
        for (integer i = 0; i < 8; i++) begin  // loop 4 times
            {A, B, C_in} = i[2:0];    // Sets 'A', 'B', and 'C' to the three least significant  bits of 'i'
            
            #1; // one instance of time, 'locks in' values, preforms UUT logic 
            
            $display("%b %b %b   | %b %b", A, B, C_in, S, C_out);  // displays calculated truth table
        end
    end
endmodule

// In regular use you should only have one testbench and one UUT in a file
module testbench(); // Multiplexer  Mux 2-1 Testbench
    
    wire Y;  // outputs
    reg S, A, B;    // inputs

    MUX_2to1 UUT (Y, S, A, B);  // order does matter!!

    initial begin
        $display("S A B | Y"); // prints to terminal
        $display("------|--");
        for (integer i = 0; i < 8; i++) begin  // loop 4 times
            {S, B, A} = i[2:0];    // Sets 'A', 'B', and 'S' to the three least significant  bits of 'i'
            
            #1; // one instance of time, 'locks in' values, preforms UUT logic 
            
            $display("%b %b %b | %b", S, A, B, Y);  // displays calculated truth table
        end
    end
endmodule

// In regular use you should only have one testbench and one UUT in a file
module testbench(); // .mem File Example Testbench

    wire F;
    reg A, B, C;

    top UUT(F, A, B, C);

    reg [3:0] truthtable [15:0];
    // 4-bit register, 16 rows
    reg [2:0] passed; = 3'b0;
    // 3-bit register to indicate amount passed situation
    // 3'b0 is shorthand for '000'

    initial begin
        $readmemb("C:\\Projects\\Verilog\\BasicMemLogic.mem", truthtable);
        //$readmemb(path, regester), read values from .mem file into register
        //$readmemd() for decimal and &readmemh for hexadecimal
       
        for (integer i = 0; i < 16; i++) begin
            {A, B, C} = truthtable[i][3:1];\
            // 'i' parses through each row of the table
            // sets 'A', 'B', and 'C' to MSB of the table, LSB stores the expected outcome

            #1;

            if (F == truthtable[i][0]) passed++;
            // if calculated F value is equal to the Expected outcome in the truth table(LSB), increment passed
            else $display("Row %d failed: %b", i, truthtable[i]);
        
        end
        
        $display("%d out of 16 passed", passed);
    end
endmodule
