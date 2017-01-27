/* -----------------------------------------------------
 *  StartStopSequencer
 *  3状態を用意して、対応するカウンタの動作制御をする
 *  STOP:リセットした後とかゲームの終わり
 *  WAIT:ゲームが始まってカウンタの動作を始めるまで
 *  RUN:カウンタが動作中
 * ----------------------------------------------------- */
 
 // 3状態の定数
`define STOP 2'b00
`define WAIT 2'b01
`define RUN  2'b10
 
module StartStopSequencer(clock, reset, start, run, stop, running);
    input clock;        // クロック
    input reset;        // リセット
    input start;        // ゲーム開始
    input run;          // 桁起・ｮ
    input stop;         // 桁ストップ
    output running;     // これが結局8進カウンタへのenable信号にいくrun状態を表す信号
    
    
    wire clock, reset;
    wire start, run, stop;  // スタートスイッチからの信号をstartとrunに接続
    wire running;   
    reg [1:0] currState;    // 2ビットで表した現在の状態(S/W/R)
    
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            currState <= `STOP;
        end else if ((currState == `STOP) && start) begin
            if (~run) begin     // 桁が起動してない
                currState <= `WAIT;
            end else begin      // 桁が動いてる
                currState <= `RUN;
            end
        end else if ((currState == `WAIT) && run) begin
            currState <= `RUN;      // 動作状態にする
        end else if ((currState == `RUN) && `STOP) begin
            currState <= `STOP;     // ストップ状態にする
        end
    end
    
    assign running = (currState == `RUN);
endmodule

