/* -------------------------------------------------------------
 *  �X���b�g�E�}�V���{�́A�p�^�[���E�f�R�[�_�ALED�G�t�F�N�g�A�_�C�i�~�b�N�_���A�̃��W���[��
 *  4���C���X�^���X�����ăX���b�g�E�}�V���E�V�X�e���S�̂��\��
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
