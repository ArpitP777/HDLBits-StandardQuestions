// this one is an absolute banger

module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    
    parameter A=0,B=1,C=2,D=3,E=4,F=5;
    reg[2:0] ps,ns;
    
    always@(posedge clk) begin
        if(reset)
            ps <= A;
        else 
            ps <= ns;
    end
    
    always@(*) begin
        case(ps)
            A: begin
                if(s[1] == 1)
                    ns = B;
                else
                    ns = A;
            end
            B: begin
                if(s == 3'b000)
                    ns = A;
                else if(s[2] == 1)
                    ns = D;
                else
                    ns = B;
            end
            C: begin
                if(s == 3'b000)
                    ns = A;
                else if(s[2] == 1)
                    ns = D;
                else
                    ns = C;
            end
            D: begin
                if(s[2] == 0)
                    ns = C;
                else if(s[3] == 1)
                    ns = F;
                else
                    ns = D;
            end
            E: begin
                if(s[3] == 1)
                    ns = F;
                else if(s[2] == 0)
                    ns = C;
                else
                    ns = E;
            end
            F: begin
                if(s[3] == 0)
                    ns = E;
                else
                    ns = F;
            end
            default: ns = A;
        endcase
    end
    
    assign fr3 = (ps==A);
    assign fr2 = (ps==B) || (ps==C) || (ps==A);
    assign fr1 = (ps==A) || (ps==B) || (ps==C) || (ps==D) || (ps==E);
    assign dfr = (ps==E) || (ps==C) || (ps==A);

endmodule
