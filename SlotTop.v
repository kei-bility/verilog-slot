/* ----------------------------------
 *  �X���b�g�E�}�V���E�Q�[���̃g�b�v���W���[��
 *  (SlotTop.v)
 *---------------------------------- */
 
module SlotTop(/*reset*/, mainClock, switch, extsegsel, extled, led, seg, segsel);
    
    //input reset;            // ���Z�b�g
    input mainClock;        // 6MHz�̃��C���N���b�N
    input [2:0] switch;     // 3����X�C�b�`
    //output clock1KHz;       // �_�C�i�~�b�N�_���p�N���b�N
    //output clock10Hz;       // �X���b�g�p�N���b�N
	 
	 output [15:0] extled;
	 output [7:0] led;
	 output [7:0] seg;
	 output [1:0] segsel;
	 output [3:0] extsegsel;
    
	 // �����M��
    wire clk1KHz, clk10Hz;
	 wire [3:0] extsegsel;
	 wire [15:0] extled;
	 wire [7:0] led;
	 wire [7:0] seg;
	 wire [1:0] segsel;
	 
	 wire [7:0] extseg;
    
    // �����N���Eb�N�̃C���X�^���X��
    DividingClock S0(mainClock,     // 6MHz�́E�E�C���N���Eb�N
                     clk1KHz,       // 7�Z�OLED�̃_�C�i�~�b�N�_���p�N���b�N
                     clk10Hz);      // �X���b�g�p�̃N���b�N
                     
    // �X���b�g�V�X�e���̃C���X�^���X��
    SlotSystem S1(clk10Hz,          // �X���b�g�p
                  clk1KHz,          // �_�C�i�~�b�N�_���p�N���b�N
                  //reset,            // ���Z�b�g
                  ~switch[2],       // �X���b�g�̃X�^�[�g�X�C�b�`
                  ~switch[2:0],     // �����~�߂�X�C�b�`
                  extsegsel,        // 
                  extseg,
                  extled[7:0]);     // feverLed
    
endmodule

