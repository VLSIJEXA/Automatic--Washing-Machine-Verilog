module testbench();

   
    // Inputs
    reg clk, reset, start, door_closed, water_level_decrease, detergent_quantity_decrease;
    reg cycle_time_out, drained, spin_time_out;

    // Output
    wire [2:0] out;

    // Instantiate the automatic_washing_machine module
    automatic_washing_machine uut (
        .clk(clk),
        .reset(reset),
        .door_closed(door_closed),
        .start(start),
        .water_level_decrease(water_level_decrease),
        .detergent_quantity_decrease(detergent_quantity_decrease),
        .cycle_time_out(cycle_time_out),
        .drained(drained),
        .spin_time_out(spin_time_out),
        .out(out)
    );

    // Clock generation
    always #5 clk = ~clk; // Generate a clock with a period of 10ns

    // Test stimulus
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        start = 0;
        door_closed = 0;
        water_level_decrease = 1;
        detergent_quantity_decrease = 1;
        cycle_time_out = 0;
        drained = 0;
        spin_time_out = 0;

        // Apply reset
        #10 reset = 0;

        // Test sequence
        // 1. Start with door closed
        #10 start = 1; door_closed = 1;

        // 2. Simulate water filling process
        #15 water_level_decrease = 0;

        // 3. Simulate detergent valve behavior
        #15 detergent_quantity_decrease = 0;

        // 4. Simulate washing cycle
        #25 cycle_time_out = 1;

        // 5. Simulate drain water process
        #15 drained = 1;

        // 6. Simulate dry spin
        #15 spin_time_out = 1;

        // 7. Observe reset to idle
        #30 reset = 1; // Reset after the cycle completion
        #10 $stop;
    end

    // Monitor output
    always @(posedge clk) begin
        $display("Time=%t | State Output=%b | Inputs: start=%b, door_closed=%b, water_level_decrease=%b, detergent_quantity_decrease=%b, cycle_time_out=%b, drained=%b, spin_time_out=%b",
                 $time, out, start, door_closed, water_level_decrease, detergent_quantity_decrease, cycle_time_out, drained, spin_time_out);
    end

endmodule
