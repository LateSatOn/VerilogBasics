module halfBitAdder(S, C, A, B); // By convention you should include your output ports
    output S, C;    // defines ports S and C as outputs
    input A, B;     // defines ports A and B as inputs

    xor u0(S, A, B);    // S = A ⊕ B
    and u1(C, A, B);    // C = AB
endmodule

module fullBitAdder(S, C_out, A, B, C_in);   //C_out refers to the output, while C_in refers to the input
    output S, C_out;
    input A, B, C_in;

    // Output S logic equation
    wire w0_0;
    xor u0_0(w0_0, A, B);   // w0_0 = A ⊕ B
    xor u1_0(S, w0_0, C_in);   // C = w0_0 ⊕ C

    // Output C_out logic equation
    wire w0_1;
    and u0_1(w0_1, A, B); // w0_1 = AB
    wire w1_1;
    and u1_1(w1_1, w0_0, C_in); // w1_1 = w0_0 * C_in
    or u2_0(C_out, w1_1, w0_1); // C_out = w1_1 + w0_1
endmodule

module MUX_2to1(Y, S, A, B);    // S is known as teh control varible
    output Y;
    input S, A, B;

    wire nS;
    not u_nS(nS, S);  // nS = S'
    
    wire w0_0;
    and u0_0(w0_0, A, nS);  // w0_0 = A + nS

    wire w0_1;
    and u0_1(w0_1, B, S);    // w0_1 = B + S

    or u1_0(Y, w0_0, w0_1); // Y = w0_0 + w0_1
endmodule