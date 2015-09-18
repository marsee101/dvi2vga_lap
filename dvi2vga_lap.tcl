# dvi2vga_lap.tcl
# I have to modify the output file of "write project tcl ...". 
# by marsee
# 2015/09/13

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Create project
create_project dvi2vga_lap ./dvi2vga_lap

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [get_projects dvi2vga_lap]
set_property "default_lib" "xil_defaultlib" $obj
set_property "part" "xc7z010clg400-1" $obj
set_property "simulator_language" "Mixed" $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set IP repository paths
set obj [get_filesets sources_1]
set_property "ip_repo_paths" "[file normalize "$origin_dir/config_files/lap_fil_axis_cnone"] [file normalize "$origin_dir/config_files/synchro/synchro.srcs/sources_1/new"] [file normalize "$origin_dir/config_files/dvi2rgb_v1_5"] [file normalize "$origin_dir/config_files/rgb2vga_v1_0"]" $obj

# Rebuild user ip_repo's index before adding any source files
update_ip_catalog -rebuild

source "$origin_dir/config_files/dvi2vga.tcl"

regenerate_bd_layout

save_bd_design

make_wrapper -files [get_files "$origin_dir/dvi2vga_lap/dvi2vga_lap.srcs/sources_1/bd/dvi2vga/dvi2vga.bd"] -top
add_files -norecurse "$origin_dir/dvi2vga_lap/dvi2vga_lap.srcs/sources_1/bd/dvi2vga/hdl/dvi2vga_wrapper.v"

add_files -fileset constrs_1 -norecurse "$origin_dir/config_files/dvi2vga.xdc"

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
