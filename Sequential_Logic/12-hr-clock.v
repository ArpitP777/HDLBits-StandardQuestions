module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    reg [2:0]en;
    assign en = {(ena && (mm == 8'h59) && (ss == 8'h59)), (ena && (ss == 8'h59)), (ena)};
    
    BCD1 min(.clk(clk), .ena(en[1]), .a(mm), .reset(reset));
    BCD1 sec(.clk(clk), .ena(en[0]), .a(ss), .reset(reset));
    
    always@(posedge clk) begin
        if(reset) begin
           hh <= 8'h12; 
           pm <= 0;
        end
        else if(en[2]) begin //12:59:59 -> 1:00:00
            if(hh == 8'h12) begin
               hh <= 8'h1; 
            end
            else if(hh == 8'h11) begin // pm or am
                hh[3:0] <= hh[3:0] + 4'h1;
                pm <= ~pm;
            end
            else begin
                if(hh[3:0] == 4'h9) begin
                hh[7:4] <= hh[7:4] + 1'h1;
                hh[3:0] <= 4'h0;
            end
            else begin
                hh[3:0] <= hh[3:0] + 1'h1; 
            end
            end
        end
    end
    
endmodule


module BCD1 (
	input clk,
    input ena,
    input reset,
    output reg [7:0] a
	);
    
    always@(posedge clk) begin
        
        if(reset) begin
           a <= 8'h0; 
        end
        
        else begin
            if(ena) begin
            if(a[7:4] == 4'd5 && a[3:0] == 4'd9) begin
                a <= 8'd0;
            end
            else if(a[3:0] == 4'd9) begin
                a[7:4] <= a[7:4] + 1;
                a[3:0] <= 4'd0;
            end
            else begin
                a[3:0] <= a[3:0] + 1; 
            end
        	end
        end
    end
    
endmodule

/*module BCD2 (
    input clk,
    input ena,
    output reg [7:0] a
	);
    
    always@(posedge clk) begin
        if(ena) begin
            if(a[7:4] == 4'd1 && a[3:0] == 4'd2)begin
                a[7:0] <= 8'd1;
            end
            else if(a[3:0] == 4'd9) begin
                a[7:4] <= a[7:4] + 1;
                a[3:0] <= 4'd0;
            end
            else begin
                a[3:0] <= a[3:0] + 1; 
            end
        end
    end
    
endmodule
*/