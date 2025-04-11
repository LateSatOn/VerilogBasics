// the logic behind this module is going to be F(A,B,C) = A' + BC

// 'top' is the name of the module, ie. how you will reference this piece of logic
module top(F, A, B, C); // done in the form of 'module name(output(s), inputs(s));'
    output F; // states that the varible 'F' is going to have data set to it
    input A, B, C; // states that varible 'A', 'B', and 'C', is going to be given
    wire w0, w1; // used as 'in-between' varibles to store data between gates

    not u0 (w0, A); // not gate, invertes the 'A' input, writes to 'w0'
    and u1 (w1, B, C); // and gate, ands the 'B' and 'C' input, writes to 'w1'
    or u2 (F, w0, w1); // or gate, ors the 'w0' and 'w1' signal, writes to 'F' output
endmodule