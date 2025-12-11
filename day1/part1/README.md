# Solution Design
General block design. 

            <img width="429" height="543" alt="image" src="https://github.com/user-attachments/assets/91cb4c2e-d2c0-49db-9dea-cf059b0385f2" />

- Testbench fills memory with the instructions as signed values
- Probes with addresses once full
- Address causes instruction to be dumped into adder input 2
  - Hundred digit irrelevant to operation, since every sweep > 100 is just a circle
  - Removed > 100 digits, but retained sign with 'rem'
- Adder input 1 tied to 50 at start, as this is intial dial position
- Keeps adding/subtracting from initial 50, using mod 100 to ensure it always lands on the wheel
  - We want mod this time, since any negative values are translated to their positive counterpart like how a wheel wraps around
- Zero counter tracks output, adds 1 for each 0 detected
