module top(S, C_out, A, B, C_in);
    output S, C_out;
    input A, B, C_in;

    // S
    wire w0_0
    xor u0_0(w0_0, A, B);   // w0_0 = A x B
    xor u1_0(S, w0_0, C_in) // S = A x B x C

    // C
    wire w0_1;
    and u0_1(w0_1, A, B);   // w0_1 = AB
    wire w1_1
    and u1_1(w1_1, w0_0, C_in); // w1_1 = C(A x B)
    or u2_0(C_out, w1_1, w0_1); // C = C(A x B) + AB

endmodule