type binop =
  | Add
  | Sub
  | Mult
  | Div
  | Mod
  | Equal
  | Neq
  | Less
  | Leq
  | Greater
  | Geq
  | And
  | Or
[@@deriving show, ord, eq]

type uop = Neg | Not [@@deriving show, ord, eq]

type identifier = string [@@deriving show, ord, eq]

type typ =
  | TInt (* Type int *)
  | TBool (* Type bool *)
  | TChar (* Type char *)
  | TArray of typ * int option (* Array type *)
  | TRef of typ (* Reference type *)
  | TVoid (* Type unit *)
  | TFun of typ list * typ (* Type functions [paramerts] -> return_type *)
  | TInterface of identifier  (* Type of an interface *)
  | TComponent of identifier (* Type of a component *)
[@@deriving show, ord, eq]

type ('a, 'b) annotated_node = { node : 'a; annot : 'b }
[@@deriving show, ord, eq]

type vdecl = identifier * typ [@@deriving show, ord, eq]

type 'a expr = ('a expr_node, 'a) annotated_node

and 'a expr_node =
  | LV of 'a lvalue (* x or a[e] *)
  | Assign of 'a lvalue * 'a expr (* x=e or a[e]=e *)
  | ILiteral of int (* Integer literal *)
  | CLiteral of char (* Char literal *)
  | BLiteral of bool (* Bool literal *)
  | UnaryOp of uop * 'a expr (* Unary primitive operator *)
  | Address of 'a lvalue (* Address of a variable *)
  | BinaryOp of binop * 'a expr * 'a expr (* Binary primitive operator *)
  | Call of identifier option * identifier * 'a expr list
(* Function call f(...) *)
[@@deriving show, ord, eq]

and 'a lvalue = ('a lvalue_node, 'a) annotated_node

and 'a lvalue_node =
  | AccVar of identifier option * identifier (* Variable access x *)
  | AccIndex of 'a lvalue * 'a expr
(* Array indexing a[e] *)
[@@deriving show, ord, eq]

and 'a stmt = ('a stmt_node, 'a) annotated_node

and 'a stmt_node =
  | If of 'a expr * 'a stmt * 'a stmt (* Conditional *)
  | While of 'a expr * 'a stmt (* While loop *)
  | Expr of 'a expr (* Expression statement e; *)
  | Return of 'a expr option (* Return statement *)
  | Block of 'a stmtordec list (* Block: grouping and scope *)
  | Skip
[@@deriving show, ord, eq]

and 'a stmtordec = ('a stmtordec_node, 'a) annotated_node

and 'a stmtordec_node =
  | LocalDecl of vdecl (* Local variable declaration *)
  | Stmt of 'a stmt (* A statement *)
[@@deriving show, ord, eq]

and 'a fun_decl = {
  rtype : typ;
  fname : identifier;
  formals : vdecl list;
  body : 'a stmt option; (* None when is a prototype *)
}
[@@deriving show, ord, eq]

and 'a member_decl = ('a member_decl_node, 'a) annotated_node
[@@deriving show, ord, eq]

and 'a member_decl_node =
  (* A member of an interface or of a component *)
  | FunDecl of 'a fun_decl
  | VarDecl of vdecl
[@@deriving show, ord, eq]

and 'a interface_decl = ('a interface_decl_node, 'a) annotated_node 

and 'a interface_decl_node =
  | InterfaceDecl of {
      (* Interface declaration *)
      iname : identifier;
      declarations : 'a member_decl list;    
    }
[@@deriving show, ord, eq]

and 'a component_decl = ('a component_decl_node, 'a) annotated_node

and 'a component_decl_node =
  | ComponentDecl of {
      (* Component declaration *)
      cname : identifier;
      uses : identifier list;
      provides : identifier list;
      definitions : 'a member_decl list;
    }
[@@deriving show, ord, eq]

and connection = Link of identifier * identifier * identifier * identifier
[@@deriving show, ord, eq]

and 'a compilation_unit =
  | CompilationUnit of {
      interfaces : 'a interface_decl list;
      components : 'a component_decl list;
      connections : connection list;
    }
[@@deriving show, ord, eq]

type located_compilation_unit = Location.code_pos compilation_unit
[@@deriving show, ord, eq]

type typed_compilation_unit = typ compilation_unit
[@@deriving show, ord, eq]
