module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done);

    
    parameter [1:0] BYTE1=2'd0, BYTE2=2'd1, BYTE3=2'd2, DONE=2'd3;
 
    reg [1:0] ps, ns;
    
    always @(*) begin
        case(ps)
            BYTE1: if (in[3] == 1'b1) begin
                ns = BYTE2;
            end else begin
                ns = BYTE1; 
            end
            
            BYTE2: ns = BYTE3;
            
            BYTE3: ns = DONE;
            
            DONE: if (in[3] == 1'b1) begin
                ns = BYTE2; 
            end else begin
                ns = BYTE1; 
            end
            
            default: ns = BYTE1;
        endcase
    end
    

    always @(posedge clk) begin
        if (reset)
            ps <= BYTE1; 
        else
            ps <= ns;
    end
 
    assign done = (ps == DONE);

endmodule