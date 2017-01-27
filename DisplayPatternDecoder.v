/* -----------------------------------------------------
 *  ダイナミック点灯のとこから3ビット出力をもらって、7セグLEDに適当なパターンの表示をする
 *       (DisplayPatternDecoder.v)
 * ----------------------------------------------------- */
 
module DisplayPatternDecoder(dynamicDigit, sevenSegmentLed);
    input [2:0] dynamicDigit;
    output [7:0] sevenSegmentLed;
    
    assign sevenSegmentLed =     (dynamicDigit == 3'b000) ? 8'b01001001:
                     (dynamicDigit == 3'b001) ? 8'b01110110:
                     (dynamicDigit == 3'b010) ? 8'b01101010:
                     (dynamicDigit == 3'b011) ? 8'b01010101:
                     (dynamicDigit == 3'b100) ? 8'b00011011:
                     (dynamicDigit == 3'b101) ? 8'b01100100:
                     (dynamicDigit == 3'b110) ? 8'b01011101:
                                         8'b01101011;
endmodule