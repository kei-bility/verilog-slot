/* ----------------------------------
 *  スロット・マシン・ゲームのトップモジュール
 *  (SlotTop.v)
 *---------------------------------- */
 
module SlotTop(/*reset*/, mainClock, switch, extsegsel, extled, led, seg, segsel);
    
    //input reset;            // リセット
    input mainClock;        // 6MHzのメインクロック
    input [2:0] switch;     // 3つあるスイッチ
    //output clock1KHz;       // ダイナミック点灯用クロック
    //output clock10Hz;       // スロット用クロック
	 
	 output [15:0] extled;
	 output [7:0] led;
	 output [7:0] seg;
	 output [1:0] segsel;
	 output [3:0] extsegsel;
    
	 // 内部信号
    wire clk1KHz, clk10Hz;
	 wire [3:0] extsegsel;
	 wire [15:0] extled;
	 wire [7:0] led;
	 wire [7:0] seg;
	 wire [1:0] segsel;
	 
	 wire [7:0] extseg;
    
    // 分周クロ・bクのインスタンス化
    DividingClock S0(mainClock,     // 6MHzの・・インクロ・bク
                     clk1KHz,       // 7セグLEDのダイナミック点灯用クロック
                     clk10Hz);      // スロット用のクロック
                     
    // スロットシステムのインスタンス化
    SlotSystem S1(clk10Hz,          // スロット用
                  clk1KHz,          // ダイナミック点灯用クロック
                  //reset,            // リセット
                  ~switch[2],       // スロットのスタートスイッチ
                  ~switch[2:0],     // 桁を止めるスイッチ
                  extsegsel,        // 
                  extseg,
                  extled[7:0]);     // feverLed
    
endmodule

