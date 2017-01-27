/* ----------------------------------------------------------------
 *  分周クロックをつくる
 *  6MHzの発信機の信号を分周して、1kHzのダイナミック表示用クロックと10Hzのゲーム用
 *  クロック信号を生成
 *  (DividingClock.v)
 * ---------------------------------------------------------------- */
 
module DividingClock(clock6MHz, clock1KHz, clock10Hz);

    input clock6MHz;        // 元の6MHzクロック
    output clock1KHz;       // ダイナミック点灯用のクロック
    output clock10Hz;       // ゲーム用のクロック
    
    wire clock100KHz, clock10KHz;
    
    clkdiv10 C1(clock6MHz, clock100KHz);
    clkdiv10 C2(clock100KHz, clock10KHz);
    clkdiv10 C3(clock10KHz, clock1KHz);
    clkdiv10 C4(clock1KHz, clock100Hz);
    clkdiv10 C5(clock100Hz, clock10Hz);
    
endmodule

module clkdiv10(originalClock, dividedClock);
    input originalClock;
    output dividedClock;
    
    reg [2:0] count;
    reg dividedClock;
    
    always @(posedge originalClock) begin
        if (count == 3'b100) begin
            count <= 3'b000;
        end else begin
            count <= count + 1;
        end
    end
    
    always @(posedge count[2]) begin
        dividedClock <= ~dividedClock;
    end
endmodule

