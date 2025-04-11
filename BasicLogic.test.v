`include "BasicLogic.v" // includes the modules found in 'BasicLogic.v'
// be sure to use the grave key!, '`' not '''!
/*
    to run any verilog file you need your folder to be a 'root' in your workspace
    right-click your file, click 'Copy Relative Path', paste, check if its in the form of 'file name' and not 'folder'/'file name'
    if it is in the form of 'folder'/'file name', then you click 'File' at the top of the vscode screen, click 'open folder', and select the folder you wish to hold all your verilog files
    then repeat the step above again to see if its right, if not ask someone to help
*/
/*
    terminal method of running verilog files (write in integrated terminal)
        iverilog -o {rename}.vvp {name of test file}.test.v
        vvp {rename}.vvp
*/
/*
    easy method of running verilog files
        see the top right of of the vscode screen, click the green right facing arrow head (doesnt work with .mem files)
        if you dont have the green arrow head then you need to install the 'Verilog Testbench Runner' Extension
*/
module testbench();
    reg A, B, C; // regesters, think of them as varibles that holds the inputs for our logic
    wire F; // wires, think as them as varibles that holds the outputs from our logic

    top UUT(F, A, B, C);
    /*
        'top' here refences the name of the logic module we made in the 'BasicLogic.v file'
        'UUT' means 'Unit Under Stress'
        'F, A, B, C' is done in the same order as your logic module (varible names dont have to be the same, pass-by values(like C))
    */

    // set initial state (in finite state machine)
    initial begin // begin - end, creates a 'coding-like' environment
        $display("A B C | F"); // prints to terminal
        $display("------|--");
        /*
            for loop, 'integer i = 0' runs once, right at the start
            'i < 8', runs at the start of every iteraction, for loop runs while this comparison is true
            'i++', runs at the end of every iteraction, increments the counter 'i' by 1, can also be written as 'i += 1' or 'i = i + 1'
            integer here is short hand for a 32-bit register, ie. reg [31:0] i
        */
        for (integer i = 0; i < 8; i++) begin // begin - end, also acts like '{}' in most coding languages
            
            {A, B, C} = i[2:0];
            /*
                {A, B, C} 'vectorizes' regesters 'A', 'B', and 'C' together
                this llgically links 'A', 'B', and 'C' in the form of 'ABC' ie. {A, B, C} = 101 would set 'A' to 1, 'B' to 0, and 'C' to 1
                'i[2:0]' grabs the last(least significant) 3 bits of i (the 32 bit intager)
                this line basically breaks the 32 bit integer 'i' into 3 bits in the form of regester 'A', 'B', and 'C'
                vectorizing is important for woring around word sizes (max bits for a regester in a system)
            */
            #1; // '#' delay (for period of time), 'locks in' inputs and 'calculator' outputs, 'simulator' time
            
            $display("%b %b %b | %b", A, B, C, F);
            /*
                '%b' prints value in binary
                '%d' prints value in decimal
                '%h' prints value in hexadecimal
                */
        end
    end
endmodule