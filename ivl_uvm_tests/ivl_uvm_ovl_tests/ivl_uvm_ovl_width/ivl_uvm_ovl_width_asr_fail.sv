module test;
   wire clk;
   reg reset_n;
  reg req,en;
  wire fire;
//ovl_width instance  
ovl_width #( .min_cks(3), .max_cks(2))
 
valid_width (
  .clock(clk),
  .reset(reset_n),
  .enable (en),
  .test_expr(req),
  .fire(fire));


 initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);

      // Initialize values.
      reset_n = 0;
      en = 0;
      req = 0;
      $dsiplay("ovl_width does not fire at reset");
      wait_clks(2);
      
      $display("-----ovl_width checker-----");
      reset_n = 1;
      en = 1;
      req = 0;
      $display({"ovl_width does not fire ", "when req is FALSE"});    
      wait_clks(2);

      $display("---ovl_width: checking min_chks---");
      req = 1;
      wait_clks(2);
      $display("ovl_width fails at min_chks");
      req = 0;
      wait_clks(1);

      $display("---ovl_width: checking max_chks---");
      req = 1;
      wait_clks(5);
      $display("ovl_width fails max chks");
      req = 0;
      wait_clks(3);
      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);  
  
  
endmodule : test
