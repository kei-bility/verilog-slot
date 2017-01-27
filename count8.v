/* --------------------------------------------------- 
 *   8進カウンタ
 *   同期式，非同期リセット，カウント・イネーブル入力つき
 *   (Count8.v)
 * --------------------------------------------------　*/

module Count8(clock, reset, enable, count);
    input clock, reset;     // クロック，リセット
    input enable;           // カウント・イネーブル
    output [2:0] count;     // カウント値
    
    // 記憶機能のある信号
    reg [2:0] count;
    
    // エッジ・トリガ 非同期リセット
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            count <= 3'b000;    // リセットする
        end else if (enable) begin
            count <= count + 1;     // カウントアップする
        end
    end
endmodule

            