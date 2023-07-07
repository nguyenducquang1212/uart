# uart

This is the root directory of the UART project. The directory structure is as follows:

- `hdl`: Uart HDL source code
- `inc`: Uart predefined macro
- `sim`: Testbench folder
  - `inc`: Testbench predefined macro
  - `src`: Testbench source code folder
  - `work`: Work folder
    - `log`: Log folder
    - `log_reg`: Log Regression folder

# Simulation

## Linux
```bash
cd sim/work
source qrun_bash
reset; vlb; vlg; vsm
```

## Windows (Using git bash)
```bash
cd sim/work
source qwin_bash
reset; vlb; vlg; vsm
```