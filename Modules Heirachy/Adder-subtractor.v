module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire carry;
    add16 inst1(.a(a[15:0]), .b({16{sub}}^b[15:0]), .cin(sub), .cout(carry), .sum(sum[15:0]));
    add16 inst2(.a(a[31:16]), .b({16{sub}}^b[31:16]), .cin(carry), .cout(), .sum(sum[31:16]));
endmodule
