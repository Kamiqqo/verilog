module tst_furry;

reg signed [15:0] aa [0:16];
reg fl = 0;

initial begin
    aa[0]  <=   5847;
    aa[1]  <=  -2891;
    aa[2]  <=  21843;
    aa[3]  <= -15472;
    aa[4]  <=  -4561;
    aa[5]  <=  13245;
    aa[6]  <=   2571;
    aa[7]  <= -20218;
    aa[8]  <=   7663;
    aa[9]  <= -10143;
    aa[10] <= -16844;
    aa[11] <=  15561;
    aa[12] <=  -2318;
    aa[13] <=   5623;
    aa[14] <=  20428;
    aa[15] <= -13015;
    aa[16] <=   8912;
end

    reg clk;
    reg reset = 0;
    reg start_signal = 0;
    wire finish_signal;
    wire end_flag;
    wire signed [15:0] dc_offset;
    integer count = 0;
    integer count2 = 0;
    reg signed [15:0] test_signal;
    
    furry furryy(
        .clk(clk),
        .reset(reset),
        .signal_in(test_signal),
        .start_signal(start_signal),
        .finish_signal(finish_signal),
        .end_flag(end_flag)
    );
    
    reg flag_count = 0;
    
    initial
        begin
            clk = 0;
        end
    always #5 clk = ~clk;
    always@(posedge clk)  begin #315; fl <= 1; end
    always@(posedge clk)
        begin
            if(finish_signal) start_signal = 0;
            if(start_signal)
                begin
                    test_signal = aa[count];
                    count2 <= count2 + 1;
                    flag_count <= 0;
                end
            if(finish_signal != 1 && fl == 1) 
                begin
                    start_signal = 1;
                end
            if(end_flag && ~flag_count)
                begin
                    count = count + 1;
                    flag_count <= 1;
                end
            if(count2 > 56) reset <= 1;
        end
endmodule
