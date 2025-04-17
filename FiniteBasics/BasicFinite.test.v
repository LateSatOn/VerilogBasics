`include "BasicFinite.v" // includes the logic module from 'BasicFinite.v'
// be sure to use the grave key: '`' not an apostrophe!

module testbench();

    wire launch;
    // 'launch' is an output from the FSM (comes *out* of the top module)
    reg clk, start, abort;
    // 'clk', 'start', and 'abort' are inputs (we control them here)

    top UUT(launch, clk, start, abort);
    /*
        'top' is the name of the FSM module we are testing
        'UUT' stands for Unit Under Test — a fancy way of saying "this is what we're testing"
        The order of ports matters! Match it with the order in the 'top' module
    */

    always begin
        //  This always block runs forever (infinite loop)
        // Used to generate a clock signal (square wave)

        clk = !clk;
        // Flip the clock signal every time we enter this block (0 → 1, 1 → 0)
        #1;
        // Wait 1 unit of simulation time (delays the next edge)
        
        /*
            This creates a continuous clock:
            HIGH for 1 time unit, then LOW for 1 time unit = 2-unit clock period
            The FSM responds to the *rising* edge (0 → 1)
        */
    end

    initial begin
        clk = 0; start = 0; abort = 0; // Initial values for all inputs

        $dumpfile("BasicFinite.vcd");
        // Create a VCD (Value Change Dump) file for waveforms
        // This file is created into the build folder
        $dumpvars(0, testbench);
        // Log all signal changes inside 'testbench' module
        // 0 specifies that all data should be 'dumped'


        #10;

        start = 1;
        #6;
        start = 0;
        #4;
        abort = 1;
        #10
        start = 1;
        abort = 0;
        #260;

        $finish;         // End simulation
    end

endmodule