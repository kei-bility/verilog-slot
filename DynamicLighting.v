/* -----------------------------------------------------
 *  ダイナミック点灯用クロックを使って3進カウンタをカウントさせて、
 *  表示する桁の選択と、点灯の指定信号(どれを表示するようにするか)を送る
 *       (DynamicLighting.v)
 * ----------------------------------------------------- */
 
module DynamicLighting(dynamicClock, left, middle, right, digit, dynamicDigit);
    input dynamicClock;  // ダイナミック点灯用のクロック(Hz)
                         // 上のモジュールからもらう
    input [2:0] left, middle, right;    // 左から3つあるうちで左、真ん中、右と割り振る
    output [3:0] digit;
    output [2:0] dynamicDigit;  // 左・A真ん中、右のどれを点灯するようにするか
                                // これがパターンのデコーダに投げられる
    reg [2:0] dynamicCount;
    
    // ダイナミック点灯用の制御カウンタ
    // 00->01->10->00 ... こんな感じ
    always @(posedge dynamicClock) begin
        if (dynamicCount == 2'b10) begin
            dynamicCount <= 2'b00;  // 10になったらリセット
        end else begin
            dynamicCount <= dynamicCount + 1;   // カウントする
        end
    end
    
    // 表示桁の選択
    assign digit = (dynamicCount == 2'b00) ? 4'b0001:
                   (dynamicCount == 2'b01) ? 4'b0010:
                   (dynamicCount == 2'b10) ? 4'b0100: 4'b0000;
                   
    // 左、真ん中、右のどれを表示させるかの選択
    // あとはパターンデコーダに投げる
    assign dynamicDigit = (dynamicCount == 2'b00) ? right:
                          (dynamicCount == 2'b01) ? middle:
                          (dynamicCount == 2'b10) ? left: 3'b111;
                   
 endmodule
 