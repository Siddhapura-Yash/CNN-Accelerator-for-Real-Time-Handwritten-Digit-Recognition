module conv #(parameter DATA_WIDTH = 8,
             parameter KERNEL_SIZE = 3,
             parameter IMAGE_WIDTH = 28,
             parameter IMAGE_HEIGHT = 28)(
                input clk,
                input rst,
                input [DATA_WIDTH-1:0]pixel_in,
                input pixel_in_valid
             );

wire [DATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1:0]control_out;
wire control_out_valid;

control_logic #(.DATA_WIDTH(DATA_WIDTH),
                .KERNEL_SIZE(KERNEL_SIZE),
                .IMAGE_WIDTH(IMAGE_WIDTH))
line_buffer_DUT (
                .clk(clk),
                .rst(rst),
                .data_in(pixel_in),
                .data_in_valid(pixel_in_valid),
                .data_out(control_out),
                .data_out_valid(control_out_valid)
);

wire [DATA_WIDTH-1:0]pixels[0:8];

genvar p;
generate
    for(p=0; p<9; p=p+1)
    begin
        assign pixels[p] = control_out[p*DATA_WIDTH +: DATA_WIDTH];
    end
endgenerate

wire [DATA_WIDTH-1:0] debug_pixels1;
wire [DATA_WIDTH-1:0] debug_pixels2;
wire [DATA_WIDTH-1:0] debug_pixels3;
wire [DATA_WIDTH-1:0] debug_pixels4;
wire [DATA_WIDTH-1:0] debug_pixels5;
wire [DATA_WIDTH-1:0] debug_pixels6;
wire [DATA_WIDTH-1:0] debug_pixels7;
wire [DATA_WIDTH-1:0] debug_pixels8;
wire [DATA_WIDTH-1:0] debug_pixels9;

assign debug_pixels1 = control_out[0*DATA_WIDTH +: DATA_WIDTH];
assign debug_pixels2 = control_out[1*DATA_WIDTH +: DATA_WIDTH];
assign debug_pixels3 = control_out[2*DATA_WIDTH +: DATA_WIDTH];
assign debug_pixels4 = control_out[3*DATA_WIDTH +: DATA_WIDTH];
assign debug_pixels5 = control_out[4*DATA_WIDTH +: DATA_WIDTH];
assign debug_pixels6 = control_out[5*DATA_WIDTH +: DATA_WIDTH];
assign debug_pixels7 = control_out[6*DATA_WIDTH +: DATA_WIDTH];
assign debug_pixels8 = control_out[7*DATA_WIDTH +: DATA_WIDTH];
assign debug_pixels9 = control_out[8*DATA_WIDTH +: DATA_WIDTH];

endmodule