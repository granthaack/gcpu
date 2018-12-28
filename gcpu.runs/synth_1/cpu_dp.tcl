# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/granthaack/projects/gcpu/gcpu.cache/wt [current_project]
set_property parent.project_path /home/granthaack/projects/gcpu/gcpu.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo /home/granthaack/projects/gcpu/gcpu.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/alu.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/biu_dp.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/cla_adder.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/cla_gen.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/cla_sub.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/com_and.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/com_not.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/com_or.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/com_xor.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/const_mux.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/dreg.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/ex_dp.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/half_adder.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/mux8.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/regfile.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/tstate_buf.v
  /home/granthaack/projects/gcpu/gcpu.srcs/sources_1/new/cpu_dp.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top cpu_dp -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef cpu_dp.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file cpu_dp_utilization_synth.rpt -pb cpu_dp_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]