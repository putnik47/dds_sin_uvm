// dds_sin_agnt.svh
class dds_sin_agnt extends uvm_agent;                        // [UVM] class
    `uvm_component_utils(dds_sin_agnt)                       // [UVM] macro

    extern function new(string name, uvm_component parent);
    extern function void build_phase(uvm_phase phase);      // [UVM] build phase
    extern function void connect_phase(uvm_phase phase);    // [UVM] connect phase

    virtual dds_sin_if dut_vi;                          // our interface

    dds_sin_seqr                     dds_sin_seqr_h;
    dds_sin_drvr                     dds_sin_drvr_h;
    dds_sin_mont                     dds_sin_mont_h;
    dds_sin_scrb                     dds_sin_scrb_h;
endclass

//-------------------------------------------------------------------------------------------------------------------------------
// IMPLEMENTATION
//-------------------------------------------------------------------------------------------------------------------------------
function dds_sin_agnt::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void dds_sin_agnt::build_phase(uvm_phase phase);
    dds_sin_seqr_h = uvm_sequencer #(dds_sin_seqi)::type_id::create("dds_sin_seqr_h", this);
    dds_sin_drvr_h = dds_sin_drvr::type_id::create("dds_sin_drvr_h", this);
    dds_sin_mont_h = dds_sin_mont::type_id::create("dds_sin_mont_h", this);
    dds_sin_scrb_h = dds_sin_scrb::type_id::create("dds_sin_scrb_h", this);

    dds_sin_drvr_h.dut_vi = this.dut_vi;
    dds_sin_mont_h.dut_vi = this.dut_vi;
endfunction

function void dds_sin_agnt::connect_phase(uvm_phase phase);
    dds_sin_drvr_h.seq_item_port.connect(dds_sin_seqr_h.seq_item_export);
    dds_sin_mont_h.dds_sin_aprt.connect(dds_sin_scrb_h.dds_sin_aprt);
endfunction