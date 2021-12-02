/**
 mComp parser specification 
 */
%{
    (* Here code *)  
%} 

/* Token declarations */
%token EOF

/* Precedence and associativity specification */



/* Start symbol */
%start compilation_unit
%type <Ast.located_compilation_unit> compilation_unit 

%% 


/* Grammar Specification */

compilation_unit:
  | /* RHS */ EOF       
    { 
      failwith "Not implemented yet"   
    }                   
;

