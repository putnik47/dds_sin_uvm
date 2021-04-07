`timescale 1ns/100ps
`include "dds_sin_if.sv"
module tb_top;
    bit clk, rst;                                            // simple clock
    always #10 clk = ~clk;                                   // 50 MHz
    initial #50 rst = 1;
//----------------------------------------------------------------------------------
// DUT connection
//----------------------------------------------------------------------------------
    dds_sin_if dut_vi(clk);// connect iclk to clk
    dds_sin #(
        //SIN_PERIOD = 4096,
        //SHFT       = 30
    )
    dds_sin (
        .clk(dut_vi.iclk),
        .rst(/*dut_vi.*/rst),
        .freq_i(dut_vi.freq_i),//'h1113840), //word_cntl,
        .freq_we(dut_vi.freq_we),
        .sin_v(dut_vi.sin_v),
        .sin_o(dut_vi.sin_o)
    );

    import uvm_pkg::*;                                      // [UVM] package
    `include "uvm_macros.svh"                               // [UVM] macroses
    import dds_sin_package::*;                               // connect our package

    initial begin
        uvm_config_db #(virtual dds_sin_if)::set(            // [UVM] pass interface
            null, "*", "dut_vi", dut_vi);         //  to UVM database
        run_test("dds_sin_test_default");                    // [UVM] run test routine
    end
endmodule