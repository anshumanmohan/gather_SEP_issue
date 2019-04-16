Require Import VST.floyd.proofauto.
Require Import VST.progs.minexample.
Instance CompSpecs : compspecs. make_compspecs prog. Defined.
Definition Vprog : varspecs. mk_varspecs prog. Defined.

Definition minexample_spec : ident * funspec :=
 DECLARE _minexample
 WITH a: val, b: val, c: val, d: val, sh : share
 PRE []                                            
   PROP  ()
   LOCAL () 
   SEP   (data_at sh tint Vzero a;
          data_at sh tint Vzero a -* data_at sh tint Vzero b)
  POST [ tint ]
    PROP()
    LOCAL (temp ret_temp Vzero)
    SEP ().
    
Definition Gprog : funspecs :=
        ltac:(with_library prog [minexample_spec]).

Lemma body_minexample : semax_body Vprog Gprog f_minexample minexample_spec.
Proof.
  start_function.
  (* pattern-accepting behavior: *)
  Fail
    (gather_SEP
       (data_at sh tint Vzero a)
       (data_at sh tint Vzero a -* data_at sh tint Vzero b)).
  (* equivalent numerical behavior: *)
  gather_SEP 0 1.
Abort.