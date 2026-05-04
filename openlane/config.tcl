set ::env(DESIGN_NAME) "top"
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/*.sv]

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "20"

# Utilization exceeds 100%
# -> Forces the tool to use DIE_AREA below
set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) "0 0 1500 1500"

# [ERROR PDN-0175] Pitch 2.7600 is too small, must be at least 6.6000
# -> prevents PDN pitch error
set ::env(FP_PDN_VPITCH) "50"
set ::env(FP_PDN_HPITCH) "50"
set ::env(FP_PDN_VOFFSET) "5"
set ::env(FP_PDN_HOFFSET) "5"

# Utilization exceeds 100%
# -> set density to prevent congestion errors
set ::env(PL_TARGET_DENSITY) "0.20"

# Disable specific timing optimization that is crashing
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(GLB_RESIZER_DESIGN_OPTIMIZATIONS) 0

# Ensure global router runs properly
set ::env(RUN_FILL_INSERTION) 1
set ::env(RUN_TAP_DECAP_INSERTION) 1
