library verilog;
use verilog.vl_types.all;
entity Project3_vlg_check_tst is
    port(
        BusWires        : in     vl_logic_vector(15 downto 0);
        Done            : in     vl_logic;
        Overflow        : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end Project3_vlg_check_tst;
