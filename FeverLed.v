/* -----------------------------------------------------
 *  �ԐFLED�̃G�t�F�N�g
 * ----------------------------------------------------- */
 
 
 module FeverLed(clock, masterState, fever, led);
    input clock;
    input masterState;  //�X���b�g�̎��s��
    input fever;        //����������
    output [7:0] led;
    
    wire [7:0] led;
    reg [1:0] disp;    //LED��]�p
    
    //����������/�������Ă��Ȃ�����LED�̓���̐ݒ�
    function [7:0] RotateLed;
        input [1:0] disp;
        input masterState;
        input fever;
        
        begin
            if (!masterState) begin
                if (!fever) begin
                    RotateLed = 8'b1111_1111;
                    //RotateLed = TimeCounter(clock); //�c�莞�Ԃ̕\��
                end else begin
                    RotateLed = (disp == 2'b00) ? 8'b0001_1000:
                                 (disp == 2'b01) ? 8'b0010_0100:
                                 (disp == 2'b10) ? 8'b0100_0010:
                                 (disp == 2'b11) ? 8'b1000_0001:
                                                   8'b0000_0000;
                end
            end
        end
    endfunction
    
    
    always @(posedge clock) begin
        disp <= disp + 1;
    end
    
    assign led = RotateLed(disp, masterState, fever);
    
endmodule