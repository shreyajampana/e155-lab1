-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/sjampana/E155/lab1/source/impl_1/lab1_sj.sv" 
"C:/Users/sjampana/E155/lab1/source/impl_1/seven_seg_sj.sv" 
"C:/Users/sjampana/E155/lab1/source/impl_1/lab1_testbench.sv" 
"C:/Users/sjampana/E155/lab1/source/impl_1/seven_seg_testbench.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top lab1_testbench
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run 100 ns"
