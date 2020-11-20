# Exercises on CFA

# Exercise 1

Our current solver [cfa_solver.ml](../code/fun-cfa/cfa_solver.ml) supports three kinks of constraints
```ocaml
type t =
  | IsIn of Token.t * Var.t   (* {t} ⊆ v *)
  | SubSeteq of Var.t * Var.t (* v1 ⊆ v2 *)
  | Impl of Token.t * Var.t * Var.t * Var.t (* {t} ⊆ v ==> v1 ⊆ v2 *)
```
The goal of this exercise is to modify the syntax of our constraints to make them more expressive and more general. 
Consider the following syntax
``` 
lhs    ::= v | ts
rhs    ::= v
constr ::= lhs1 ⊆ rhs1 ∧ ... ∧ lhsn ⊆ rhsn ==> lhs ⊆ rhs  
```
where `lhs` stands for terms that occur on the left-hand side of `⊆` and they can be either a variable `v` or a set of tokens `ts`, i.e., `ts = {t1, ..., tn}`.
Instead, `rhs` stands for terms that occur on the right-hand side of `⊆`, and they can only be variables `v`. 
A constraint `constr` is an implication where the premiss is a possibly empty conjunction of inclusions.
When the conjunction is empty, the resulting constraint is equivalent to 
```
lhs ⊆ rhs
```

Modify our solver by defining a representation for the new constraints, and adapt the implementation of the `solve` function as well as of the operators `@<` and `@~~>` to operate on them.

Adapt the code in [fun_cfa.ml](../code/fun-cfa/fun_cfa.ml) to work with the new implementation of the solver. 

# Exercise 2

Extend the CFA of *FUN* by introducing an *abstract reachability component*
```
R ∊ Reach = Lab → ℘({on}).
```
First, modify the specification of the analysis so as to have an acceptability relation of the form 
```
(C,ρ,R) ⊧ e
```
The idea is that a function `fun f x = e` has `{on} ⊆ R(l)` where `l` is the label of `e` if and only if `f` may be applied somewhere, and that the "recursive call" to analyse the body of `f` is carried out if and only if `{on} ⊆ R(l)`.

Then, modify the constraint generation function to accommodate the new analysis specification.

Finally, implement the new analysis by modifying the implementation in [fun_cfa.ml](../code/fun-cfa/fun_cfa.ml).

**Hints**: use the constraints and the solver of [Exercise 1](#exercise-1). You may make the analysis result clearer by considering the domain of `R` the set of functions name, i.e., `{on} ⊆ R(f)` when `f` may be applied somewhere.

