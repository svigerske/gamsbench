# gamsbench
Scripts to run GAMS benchmark on global solvers.

Scripts are taken from SCIP (scip.zib.de) and slightly modified:
  - increased tolerance in bounds consistency check (cmpres.awk)
  - changed formula for gap (divide by max(|lb|,|ub|) instead of min(|lb|,|ub|))
  - check on gams/examiner2 instead of gams trace files
  - fail runs when solution violates variable bounds or constraints

License: Apache 2.0
