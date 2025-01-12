import os

fn test_syscallwrappers() {
	if true { return }
	$if linux {
		$if x64 {
			exe := os.executable()
			vdir := os.dir(exe)
			if vdir.len > 1 {
				dot_checks := vdir + "/.checks"
				assert os.dir_exists(dot_checks)

				os.chdir(dot_checks)
				checks_v := "checks.v"
				assert os.file_exists(checks_v)
				rc := os.exec("v run $checks_v") or { panic(err) }
				assert !rc.output.contains("V panic: An assertion failed.")
				assert !rc.output.contains("failed")
				assert rc.exit_code == 0
			} else {
				panic("Can't find test directory")
			}
		}
	}
}
