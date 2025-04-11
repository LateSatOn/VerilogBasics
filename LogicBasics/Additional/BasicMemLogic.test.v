`include "BasicLogic.v" // includes the modules found in 'BasicLogic.v'
/*
    here we are going to be doing an alternative method of making the testbench
    instead of setting the regesters to teh last 3 bits of our counter integer we will set them directyl from our .mem(binary memory) file
    we will then compare our result (F wire) with the result in the .mem file (least significant bits)
    this also means we dont have to print the whole table and manulally check that our logic is correct
*/

/*
    iverilog -o {rename}.vvp {name of test file}.test.v
    vvp {rename}.vvp
*/

module testbench();
    reg A, B, C;
    wire F;

    top UUT(F, A, B, C);

    reg [3:0] truthtable [15:0];
    /*
        this is creating a resster with 4 bits, 16 rows long
        this will hold all teh information from our .mem file
    */
    reg [2:0] passed; = 3'b0;
    /*
        this is creating a regester that holds the varible keeping track of how many situations passed
        regester is 3 bits long as was have a total of 16 arguments (2^3)
        '3'b0', 3 bit 0 ie. 000, can also write 'd' for decimal and 'h' for hexadecimal
    */
    initial begin
        $readmemb("C:\\Projects\\Verilog\\BasicMemLogic.test.v", truthtable);
        /*
            '$readmemb(path, regester)' read values from the .mem file into the regester
            to grab the path of your .mem file, right click the mem file in your root (verilog folder) and copy path
            then replace all '\' with '//'
            $readmemd() for decimal and &readmemh for hexadecimal
        */
        for (integer i = 0; i < 16; i++) begin
            {A,B,C} = truthtable[i][3:1];
            /*
                'i' is now going to parse through each row of the truth table
                we are then vectoprizing 'A', 'B', and 'C' to the most siginifact bits of the table (least significant is the expected output)
            */
            #1;
            if (F == truthtable[i][0]) passed++; // if current F value is equal to expected F value, then incememnt passed regester
            else $display("Row %d failed: %b", i, truthtable[i]);
        end
        $display("%d out of 16 passed", passed);
    end
endmodule