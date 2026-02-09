module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter LEFT=0,RIGHT=1,FALL_L=2,FALL_R=3,DIG_L=4,DIG_R=5;
    reg[2:0] state, next_state;
    
    always@(posedge clk or posedge areset) begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    //next state logic
    always@(*) begin
        case(state)
            LEFT: if(!ground) begin
                    next_state = FALL_L;
            	end
            else if(dig) begin
                    next_state = DIG_L;
            	end
                else if(bump_left)begin
                    next_state = RIGHT;
                end
            	
                else begin
                    next_state = LEFT;
                end
            
            RIGHT: 
                if(!ground) begin
                    next_state = FALL_R;
            	end
            else if(dig) begin
                    next_state = DIG_R;
                end
                else if(bump_right) begin
                    next_state = LEFT;
                end
                
                else begin
                    next_state = RIGHT;
                end
            
            FALL_L: 
                if(ground) begin
                    next_state = LEFT;
                end
                else begin
                    next_state = FALL_L;
                end
            
            FALL_R:
                if(ground) begin
                    next_state = RIGHT;
                end
                else begin
                    next_state = FALL_R;
                end
            
            DIG_L:
                if(!ground) begin
                    next_state = FALL_L;
                end
                else begin
                    next_state = DIG_L;
                end
            
            DIG_R: 
                if(!ground) begin
                    next_state = FALL_R;
                end
                else begin
                    next_state = DIG_R;
                end
        endcase
    end
    
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_L) || (state == FALL_R);
    assign digging = (state == DIG_L) || (state == DIG_R);

endmodule
