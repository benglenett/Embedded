

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "my_seven_segment_display" "NUM_INSTANCES" "DEVICE_ID"  "C_S01_AXI_BASEADDR" "C_S01_AXI_HIGHADDR"
}
