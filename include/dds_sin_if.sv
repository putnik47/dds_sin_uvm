interface dds_sin_if (input bit iclk);

    bit freq_we;  
    bit sin_v;
    bit [31: 0] freq_i;//, //word_cntl,
    bit [13: 0] sin_o;//, sin_o90, sin_o180, sin_o270

endinterface