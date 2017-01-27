/* -----------------------------------------------------
 *  自分の桁を起動してから、隣の桁のカウンタを起動させるまでの時間待ちをする
 *  待ち合わせ時間:7クロック
 *  カウント停止状態...3'b000
 *  タイムアウト状態... 3'b111
 *       (StartDelay.v)
 * ----------------------------------------------------- */
 
module StartDelay(clock, reset, trigger, timeOut);
    input clock;        // クロック
    input reset;        // リセット
    input trigger;      // 起動信号
    output timeOut;     // タイムアウト信号
    
    reg [2:0] StartDelayCount;  // 3ビットのカウンタ
    
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            StartDelayCount <= 0;       // リセットする
        end else if (trigger) begin
            StartDelayCount <= 1;                       // 3'b001にする
        end else if (StartDelayCount) begin
            StartDelayCount <= StartDelayCount + 1;     // カウントする
        end
    end
    
    // & 演算子は全ビットが1かどうか
    // つまり3'b111のときタイムアウトのやつをアクティブに
    assign timeOut = & StartDelayCount;
    
endmodule