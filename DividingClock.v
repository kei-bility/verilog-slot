/* ----------------------------------------------------------------
 *  �����N���b�N������
 *  6MHz�̔��M�@�̐M���𕪎����āA1kHz�̃_�C�i�~�b�N�\���p�N���b�N��10Hz�̃Q�[���p
 *  �N���b�N�M���𐶐�
 *  (DividingClock.v)
 * ---------------------------------------------------------------- */
 
module DividingClock(clock6MHz, clock1KHz, clock10Hz);

    input clock6MHz;        // ����6MHz�N���b�N
    output clock1KHz;       // �_�C�i�~�b�N�_���p�̃N���b�N
    output clock10Hz;       // �Q�[���p�̃N���b�N
    
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

