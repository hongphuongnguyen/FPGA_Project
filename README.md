Hệ thống điểu chỉnh độ sáng của đèn thông qua cảm biến ánh sáng MKE S02 sử dụng kit EPM240T100C5, hiển thị độ sáng lên màn hình LCD1602. 
Hệ thống gồm 4 khối:  + Khối chia tần (Lấy clk của EPM240 chia tần cấp clk cho khối ADC0804)
                      + Khối ADC (Từ giá trị tương tự của cảm biến, chuyển đổi sang giá trị số 8 bit 0-255)
                      + Khối PWM (Từ giá trị digital ra của khối ADC, thực hiện băm xung với mức cao từ 0 đến giá trị ADC và mức thấp từ giá trị ADC đến 255).
                      + Khối LCD (Từ giá trị digital ra của khối ADC 0-255, chuyển đổi nó về từ 0-100% tương ứng, hiển thị LCD các ký tự hàng chục và hàng đơn vị).
