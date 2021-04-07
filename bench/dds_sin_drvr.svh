class dds_sin_drvr extends uvm_driver #(dds_sin_seqi);        // [UVM] class
    `uvm_component_utils(dds_sin_drvr)                       // [UVM] macro

    extern function new(string name, uvm_component parent);
    extern task run_phase(uvm_phase phase);                 // [UVM] run phase

    virtual dds_sin_if dut_vi;                          // our interface
endclass : dds_sin_drvr

//-------------------------------------------------------------------------------------------------------------------------------
// IMPLEMENTATION
//-------------------------------------------------------------------------------------------------------------------------------
function dds_sin_drvr::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction 

task dds_sin_drvr::run_phase(uvm_phase phase);
    forever begin
        dds_sin_seqi tx;

        seq_item_port.get_next_item(tx);     
        // dut_vi.freq_i  = tx.freq_i[31:0];
        @(posedge dut_vi.iclk);
        case (tx.bus_op)
            BUS_WRITE: begin
                dut_vi.freq_i  = tx.freq_i[31:0];
                dut_vi.freq_we = 1;
                @(posedge dut_vi.iclk);
                dut_vi.freq_we = 0; 
            end
            BUS_IDLE: begin
                repeat(5000) @(posedge dut_vi.iclk);
                dut_vi.freq_we = 0;             
            end
            default : begin
                dut_vi.freq_we = 0; 
            end
        endcase
        @(negedge dut_vi.iclk);  
        dut_vi.freq_we = 0; 
        seq_item_port.item_done();
    end
endtask : run_phase