let optimize_module llvm_module =
  let pass_manager = Llvm.PassManager.create () in

  (* memory to register promontion *)
  Llvm_scalar_opts.add_memory_to_register_promotion pass_manager;

  (* constant propagation: not available in LLVM > 10
     Llvm_scalar_opts.add_constant_propagation pass_manager; *)

  (* loop unrolling *)
  Llvm_scalar_opts.add_loop_unroll pass_manager;

  (* dead code elimination *)
  Llvm_scalar_opts.add_aggressive_dce pass_manager;

  (* control-flow graph simplification *)
  Llvm_scalar_opts.add_cfg_simplification pass_manager;

  (* tail call elimination *)
  Llvm_scalar_opts.add_tail_call_elimination pass_manager;

  Llvm.PassManager.run_module llvm_module pass_manager |> ignore;

  llvm_module
