Introduction
============

A heartbeat generator can be used in a digital system to ...

Features
========

Normal rhythm produces four entities – a P wave, a QRS complex, a T wave, and a U wave – that each
have a fairly unique pattern. [[1]](https://en.wikipedia.org/wiki/Electrocardiography)

For simplicity the existing heartbeat module generates the QRS complex and T wave only. 

  * Models QRS-Complex and T-Wave
  * Average time values based on 72 bpm
  * Enable input for external prescaler


General Description
===================

![Heartbeat Generator - Schematic Symbol](images/heartbeat_gen.png){width=40%}

| **Name**    | **Type**          | **Direction** | **Polarity** | **Description** |
|-------------|-------------------|:-------------:|:------------:|-----------------|
| clk_i       | std_ulogic        | IN            | HIGH         | clock           |

: Heartbeat Generator - Description of I/O Signals


Functional Description
======================

The shape of an [electrogardiogramm](https://en.wikipedia.org/wiki/Electrocardiography) as a voltage graph over time



![Electrocardiogram](images/ECG-SinusRhythmLabel.png){width=20%}

The important QRS complex and T wave are modelled as digital pulses.

![QRS Complex and T Wave Pulses](images/qrs-complex-t-wave-pulses.pdf){width=80%}


Design Description
==================

A conceptional RTL diagram is shown below.

![Heartbeat Generator - Conceptional RTL](images/heartbeat_gen_conceptional_rtl.pdf){width=60%}

The simulation result shows two full periods based on a clock period of 1 ms

![Two Periods - Simulation Result](images/heartbeat_gen_two_periods_simwave.png){width=80%}

In more detail using cursors to display correct parameters of the QRS complex and T wave.

![QRS-Complex and T-Wave - Simulation Result](images/qrs-complex-t-wave_simwave.png){width=80%}



Device Utilization and Performance
==================================

The following table shows the utilisation of both modules heartbeat_gen and cntdnmodm.

The following results  are extracted from

  ```pure
  pnr/de1_heartbeat_gen/de1_heartbeat_gen.fit.rpt
  ```


```pure
+--------------------------------------------------------------------------------------+
; Fitter Summary                                                                       ;
+------------------------------------+-------------------------------------------------+
```

The following results  are extracted from

  ```pure
de1_heartbeat_gen.sta.rpt
```

```pure
+----------------------------------------------------------------------------------------+
; TimeQuest Timing Analyzer Summary                                                      ;
+--------------------+-------------------------------------------------------------------+

-----------------------------------------+
; Clocks                                 ; 
+------------+------+--------+-----------+


+-----------------------------------------------------------------------------+
; Multicorner Timing Analysis Summary                                         ;
+------------------+-------+-------+----------+---------+---------------------+

```

Application Note
================

The following test environment on a DE1 prototype board uses a system clock frequency of 50 MHz.
A prescaler is parameterised to generate an output signal with a period of 1 ms.

![Test Environment on DE1 Prototype Board](images/de1_heartbeat_gen_schematic.pdf){width=70%}



Appendix
========

References
----------

* [Wiki: Electrocardiography](https://en.wikipedia.org/wiki/Electrocardiography)

Project Hierarchy
-----------------

### Module Hierarchy for Verification

```pure
t_heartbeat_gen(tbench)
  heartbeat_gen(rtl)
```

### Prototype Environment

```pure
de1_heartbeat_gen(structure)
  heartbeat_gen(rtl)
  cntdnmodm(rtl)
```

VHDL Sources
------------

```vhdl
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY heartbeat_gen IS
  PORT (clk_i   : IN  std_ulogic;
        rst_ni  : IN  std_ulogic;
        en_pi   : IN  std_ulogic;
        count_o : OUT std_ulogic_vector;
        heartbeat_o : OUT std_ulogic
        );
END heartbeat_gen;
```

```vhdl
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ARCHITECTURE rtl OF heartbeat_gen IS

  CONSTANT n    : natural                := 10;
  CONSTANT zero : unsigned(n-1 DOWNTO 0) := (OTHERS => '0');

  CONSTANT heartbeat_period : unsigned(n-1 DOWNTO 0) := to_unsigned(833, n);
  CONSTANT qrs_width        : unsigned(n-1 DOWNTO 0) := to_unsigned(100, n);
  CONSTANT st_width
  CONSTANT t_width
  CONSTANT qt_width

  SIGNAL next_state, current_state : unsigned(n-1 DOWNTO 0);

  SIGNAL tc_qrs                    : std_ulogic;  -- qrs interval
  SIGNAL tc_t                      : std_ulogic;  -- T wave

BEGIN

  next_state_logic : 
                     


  state_register : 
                   

  -- output_logic
  t_wave : tc_t <= 
                   
                   
                   
  qrs_complex : tc_qrs <= 
                          

  output_value : heartbeat_o <= 


END rtl;
```

Revision History
----------------

| **Date**  | **Version**  | **Change Summary**  |
|:----------|:-------------|:--------------------|
| May 2020  | 0.1  | Initial Release  |
| April 2021  | 0.2  | Added parameterisation  |

