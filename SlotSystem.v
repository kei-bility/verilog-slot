/* -------------------------------------------------------------
 *  スロット・マシン本体、パターン・デコーダ、LEDエフェクト、ダイナミック点灯、のモジュール
 *  4つをインスタンス化してスロット・マシン・システム全体を構成
 *  (SlotSystem.v)
 * ------------------------------------------------------------*/

module SlotSystem(clock, dynamicClock, /*reset*/, start, stop, digit, sevenSegmentLed, led);
    
    input clock;
    input dynamicClock;
    //input reset;
    input start;
    input [2:0] stop;
    output [3:0] digit;
    output [3:0] sevenSegmentLed;
    output [7:0] led;
    
    wire [2:0] left, middle, right, dynamicDigit;
    
    SlotBody U0(clock, /*reset*/, start, stop, left, middle, right, run_stop, fever);
    FeverLed U1(clock, run_stop, fever, led);
    DisplayPatternDecoder U2(dynamicDigit, sevenSegmentLed);
    DynamicLighting U3(dynamicClock, left, middle, right, digit, dynamicDigit);
    
endmodule
