From Coq Require Import Relations.Relation_Definitions.
From Coq Require Import List.
From Coq Require Import Sets.Ensembles.

Section Arity.
    Definition finite_set (n : nat) : list nat :=
    seq 0 n.

    Definition list_to_ensemble {A : Type} (l : list A) : Ensemble A := 
        fold_left 
        (fun accum a => Add A accum a)
        l 
        (Empty_set A).

    Definition arity n := list_to_ensemble (finite_set n).
End Arity.

Record ports {V : Type} (ar : V -> nat) := {
    v : V ;
    port : nat ;
    is_port : In nat (arity (ar v)) port ;
}.

Record hypergraph := { 
    V : Type ; (* vertices *)
    ar : V -> nat ; (* arity *)
    E : relation V ; (* edges *)
    link : ports ar -> V * V ; (* assign each port to an edge *)
    links_valid : forall n, let '(x, y) := (link n) in E x y ;
}.

(* trees *)
Record graph := build_graph {
    nodes : Type ;
    edges : relation nodes ; 
}.

(* edges of the hypergraph *)
Record bigraph (T : Type) := {
    nodes : Type ; 
    hyperedges : relation T ;
}.