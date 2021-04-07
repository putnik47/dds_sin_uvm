class dds_sin_scrb extends uvm_scoreboard;                   // [UVM] class
    `uvm_component_utils(dds_sin_scrb)                       // [UVM] macro
    bit t0;
    int time0, time1, diff_time;
    int freq_o;//actual frequency calculated from output sin from dut
    real diff_freq, perc1000, perc;
    longint C1 = 64'd100_000_000_000;
    extern function new(string name, uvm_component parent);
    extern function void build_phase(uvm_phase phase);      // [UVM] build phase

    uvm_analysis_imp #(dds_sin_seqi, dds_sin_scrb) dds_sin_aprt;
    extern function void write(dds_sin_seqi dut_vi);
endclass

//-------------------------------------------------------------------------------------------------------------------------------
// IMPLEMENTATION
//-------------------------------------------------------------------------------------------------------------------------------
function dds_sin_scrb::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void dds_sin_scrb::build_phase(uvm_phase phase);
    dds_sin_aprt = new("dds_sin_aprt", this);
endfunction

function void dds_sin_scrb::write(dds_sin_seqi dut_vi);
    string data_str;
    if(dut_vi.sin_v) begin
        t0  = ~t0;
        if(t0)  time0 = $time;
        else    time1  = $time;
        diff_time = time1 > time0 ? time1 - time0 : time0 - time1;
        freq_o = C1/diff_time;
        diff_freq = dut_vi.freq_i > freq_o ? dut_vi.freq_i - freq_o : freq_o - dut_vi.freq_i;
        perc1000 = diff_freq * 100_000 / dut_vi.freq_i;
        perc = perc1000 / 1000;

        if (perc > 1.0)//diff in predicted freq_i and actual relult is more or low 1%
            `uvm_info("FAIL", $sformatf("diff in predicted freq_i and actual result in percentages: %p", perc), UVM_NONE)
        else
            `uvm_info("PASS", $sformatf("diff in predicted freq_i and actual result in percentages: %p", perc), UVM_NONE)
    end
endfunction