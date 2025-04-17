module top(launch, clk, start, abort);

    output reg launch;
    // 'launch' is an OUTPUT — data is sent out from this module
    // 'reg' is used because launch's is updated sequentially (within the alway @)

    input clk, start, abort;
    // 'clk', 'start', and 'abort' are INPUTS — data comes into this module
    // 'clk' is the heartbeat of the FSM (Finite State Machine), triggers actions on its rising edge

    reg [3:0] timer;
    // 4-bit register to hold the countdown timer (values from 0 to 15(10 in this instance))

    reg [1:0] state;
    // 2-bit register to store current FSM state
    // 2 bits can represent 4 unique states (we use 3: INIT, COUNT_DOWN, FLY)

    parameter [1:0] INIT = 2'd0,
                    COUNT_DOWN = 2'd1,
                    FLY = 2'd2;
    /*
        'parameter' defines named constants
        Easier to understand states by name instead of raw numbers
        INIT         - Initial state, waiting for start
        COUNT_DOWN   - Countdown begins after start
        FLY          - Launch activated after countdown
    */

    initial state = INIT;
    // System starts in INIT state

    always @(posedge clk) begin
        // Code inside here runs on the rising edge of the clock signal (positive edge)

        case(state) // FSM behavior changes based on current 'state'
        
        INIT: begin
            launch = 0;         // Launch is OFF in INIT
            timer = 4'd10;      // Set countdown timer to 10

            if (start)          // If 'start' button is pressed
                state = COUNT_DOWN;
            else
                state = INIT;   // Explicitly restate INIT for clarity (not needed, but helpful for reading)
        end

        COUNT_DOWN: begin
            launch = 0;         // Still OFF during countdown
            timer = timer - 1;  // Decrease timer each clock cycle

            if (abort)          // Priority check: If 'abort' is triggered
                state = INIT;   // Go back to INIT
            else if (timer == 0)// If countdown finishes
                state = FLY;    // Move to launch
        end

        FLY: begin
            launch = 1;         // LAUNCH ACTIVATED
            // No state transition — stays in FLY forever unless reset externally
        end

        endcase
    end

endmodule