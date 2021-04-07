package dds_sin_package;
    import uvm_pkg::*;                                      // [UVM] package
    `include "/home/soft/INCISIVE151/tools/methodology/UVM/CDNS-1.1d/sv/src/uvm_macros.svh"                               // [UVM] package

    // `include "common_macros.svh"
    `include "dds_sin_seqi.svh"
    typedef uvm_sequencer #(dds_sin_seqi) dds_sin_seqr;       // [UVM] sequencer

    `include "dds_sin_drvr.svh"

    typedef uvm_analysis_port #(dds_sin_seqi) dds_sin_aprt;
    `include "dds_sin_mont.svh"

    `include "dds_sin_scrb.svh"
    `include "dds_sin_agnt.svh"

    `include "dds_sin_seqc_default.svh"
    `include "dds_sin_test_default.svh"
endpackage