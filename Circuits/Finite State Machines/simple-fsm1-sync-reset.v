// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  

    // Fill in state name declarations
	parameter A = 1;
    parameter B = 0;
    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin  
            present_state = B;
        end
        else begin
            // State flip-flops
            present_state = next_state;   
        end
    end
    always@(*) begin
            case (present_state)
                B: if(in) begin next_state = B;
                end
                else begin
                   next_state = A; 
                end
                A: if(in) begin next_state = A;
                end
                else begin
                   next_state = B; 
                end
            endcase
    end
    assign out = (present_state==B)?1'b1:1'b0;

endmodule
