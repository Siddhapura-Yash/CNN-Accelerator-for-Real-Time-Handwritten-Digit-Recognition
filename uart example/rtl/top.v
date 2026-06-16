module top #(
    parameter DATA_WIDTH = 8,
    parameter KERNEL_SIZE = 3,
    parameter IMAGE_WIDTH = 28,
    parameter IMAGE_HEIGHT = 28
)(
    input clk,
    input rst,
    input data_in,
    output reg [6:0]seg,
    output reg prediction_valid
);

wire byte_done;
wire [7:0]rx_out;

rx RX_DUT (
    .i_Clock(clk),
    .i_Rx_Serial(data_in),
    .o_Rx_DV(byte_done),
    .o_Rx_Byte(rx_out)
);

conv #(
    .DATA_WIDTH(DATA_WIDTH),
    .KERNEL_SIZE(KERNEL_SIZE),
    .IMAGE_WIDTH(IMAGE_WIDTH),
    .IMAGE_HEIGHT(IMAGE_HEIGHT))
CNN_DUT (
    .clk(clk),
    .rst(rst),
    .pixel_in(rx_out),
    .pixel_in_valid(byte_done),
    .prediction(prediction),
    .data_out_valid()
);

wire [3:0] prediction;

reg [26:0] counter; 

always @(posedge clk) begin
    if (!rst) begin
        counter <= 27'd0;
        prediction_valid     <= 1'b0;
    end
    else begin
        if (counter == 27'd99_999_999) begin
            counter <= 27'd0;
            prediction_valid     <= ~prediction_valid;
        end
        else begin
            counter <= counter + 1'b1;
        end
    end
end    

always @(posedge clk) begin
    if (!rst) begin
        seg <= 7'b0000000;   // blank on reset
    end
    else 
    begin
        case (prediction)
            4'd0: seg <= 7'b1111110;
            4'd1: seg <= 7'b0110000;
            4'd2: seg <= 7'b1101101;
            4'd3: seg <= 7'b1111001;
            4'd4: seg <= 7'b0110011;
            4'd5: seg <= 7'b1011011;
            4'd6: seg <= 7'b1011111;
            4'd7: seg <= 7'b1110000;
            4'd8: seg <= 7'b1111111;
            4'd9: seg <= 7'b1111011;
            default: seg <= 7'b0000000;
        endcase
    end
end

endmodule