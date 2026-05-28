module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter [2:0] IDLE=3'd0, DATA=3'd1, STOP=3'd2, ERROR=3'd3, DONE=3'd4;
	
    reg [3:0] count;
    reg [2:0] ps,ns;
    
    always@(posedge clk) begin
        if(reset) begin
           ps <= IDLE; 
           count <= 4'd0;
        end
        else begin
        	if(ns == DATA) begin
           	count <= count + 1; 
        	end
            else begin
               count <= 4'd0; 
            end
       		ps <= ns; 
        end
    end
    
    always@(*) begin
        case(ps)
            IDLE: if(in == 1'b0) begin
                ns = DATA;
            end
            else begin
               ns = IDLE; 
            end
            DATA: if(count == 4'd8) begin
               		ns = STOP; 
            	end
            else begin
               ns = DATA; 
            end
            STOP: if(in == 1'b1) begin
                ns = DONE;
            end
            else begin
               ns = ERROR; 
            end
            DONE: if(in == 1'b0) begin
            		ns = DATA;    
                end
            	  else begin
                    ns <= IDLE;
                  end
            ERROR: if(in == 1'b1) begin
               ns = IDLE; 
            end
            else begin
               ns = ERROR;
            end
            default: ns = IDLE;
        endcase
    end
    
    assign done = (ps==DONE);
endmodule
