//=========================================================================
//                                                                         
// DDS SIN generator for input frequency                                  
//                                                                         
//=========================================================================
`timescale 1ns/100ps
module dds_sin #(
    parameter SIN_PERIOD = 4096,
              SHFT       = 32
)(
    input                clk, rst,
    input        [31: 0] freq_i, 
    input freq_we,//word_cntl,
    output bit sin_v,
    output logic [13: 0] sin_o
);
localparam K1 = 3502;
logic [31: 0] freq_i_r;
logic [43: 0] acc, phase;
logic [43: 0] freq_i_full;
logic [13: 0] sin_table [0:SIN_PERIOD-1]; 
always_ff @(posedge clk)
    if(freq_we)
        freq_i_r <= freq_i;
    
always_ff @(posedge clk, negedge rst)
    if(!rst) 
        freq_i_full <= K1*('hffffff);
    else
        freq_i_full <= K1*freq_i_r;

always_ff @(posedge clk, negedge rst)
    if(!rst) begin
        phase <= 0;
        acc   <= 0;
    end
    else
	    acc   <= acc + phase/* 0 */ + freq_i_full;

bit sin_v_r;
always_ff @(posedge clk)
    sin_v_r <= rst ? sin_o == 0 : 0;
always_ff @(posedge clk)
    sin_v <= (sin_o == 0) && ~sin_v_r;

wire [11: 0] n_sin = (acc >> SHFT);
always_ff @(posedge clk) sin_o      = sin_table[n_sin];


initial $readmemh("../../rtl/sin_4096_h.txt", sin_table);

endmodule
