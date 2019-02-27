Compilation Instructions
========================

1. Copy minexample.v and verif_minexample.v into VST/progs

2. Then, while in VST/progs, run coqc to create a .vo file:

      coqc -Q ../../CompCert compcert -Q . VST.progs minexample.v

   If you are using the compcert internal to VST, the following will likely work:

      coqc -Q ../compcert compcert -Q . VST.progs minexample.v

   Please note that I created this minimal example using the external CompCert.

3. Then you can open up my verif_minexample.v file.
