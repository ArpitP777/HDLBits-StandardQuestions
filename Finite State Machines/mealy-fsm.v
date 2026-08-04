module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    localparam [1:0] s1 = 2'd0;
    localparam [1:0] s2 = 2'd1;
    localparam [1:0] s3 = 2'd2;
    reg [1:0] ps,ns;
    
    always@(posedge clk or negedge aresetn) begin
        if(!aresetn) begin
           ps <= s1; 
        end
        else begin
           ps <= ns; 
        end
    end

    always@(*) begin
        z = 1'b0;
        case(ps)
            s1: begin
                if(x == 1'b1) begin
                   ns = s2; 
                end
                else begin
                   ns = s1; 
                end
            end
            s2:begin
                if(x == 1'b0) begin
               ns = s3; 
                end
            	else begin
               		ns = s2; 
            	end
            end
            s3: begin
                if(x == 1'b1) begin
                   ns = s2;
                   z = 1'b1;
                end
                else begin
                    ns = s1;
                end
            end
            default: ns = s1;
        endcase
    end
    
endmodule
