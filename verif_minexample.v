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
          data_at sh tint Vzero b;
          data_at sh tint Vzero c;
          data_at sh tint Vzero d)
  POST [ tint ]
    PROP()
    LOCAL (temp ret_temp Vzero)
    SEP ().
    
Definition Gprog : funspecs :=
        ltac:(with_library prog [minexample_spec]).

Lemma body_minexample : semax_body Vprog Gprog f_minexample minexample_spec.
Proof.
  start_function.
  assert_PROP True.
  - (* the goal in this branch has ENTAIL delta. We are in the entailment context. *)
    (* now the line below will fail with "no matching clauses for match *)
    Fail (gather_SEP (data_at sh tint Vzero c) (data_at sh tint Vzero d)).
    (* but the numerical equivalent will still succeed: *)
    gather_SEP 2 3.
    admit.
  - (* the goal in this branch has semax delta; we are in the proof context. *)
    (* the line below words great, ie equivalent to gather_SEP 2 3. *)
    gather_SEP (data_at sh tint Vzero c) (data_at sh tint Vzero d).
    admit.
Abort.
