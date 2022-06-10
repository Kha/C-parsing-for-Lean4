import CParser.SyntaxDecl
-- declare_syntax_cat assignment_operator
-- declare_syntax_cat primary_expression
-- declare_syntax_cat postfix_expression
-- declare_syntax_cat argument_expression_list
-- declare_syntax_cat unary_expression
-- declare_syntax_cat unary_operator
-- declare_syntax_cat expression
-- declare_syntax_cat conditional_expression
-- declare_syntax_cat logical_or_expression
-- declare_syntax_cat logical_and_expression
-- declare_syntax_cat inclusive_or_expression
-- declare_syntax_cat exclusive_or_expression
-- declare_syntax_cat and_expression
-- declare_syntax_cat equality_expression
-- declare_syntax_cat relational_expression
-- declare_syntax_cat shift_expression
-- declare_syntax_cat additive_expression
-- declare_syntax_cat multiplicative_expression
-- declare_syntax_cat cast_expression

inductive PrimaryExpr where
  | Identifier : String → PrimaryExpr
  | Constant : Int → PrimaryExpr
  | StringLit : String → PrimaryExpr
  | BracketExpr : Expression → PrimaryExpr

syntax str : primary_expression
syntax ident : primary_expression
syntax num : primary_expression
syntax "(" expression ")" : primary_expression

syntax "`[primary_expression| " primary_expression "]" : term

inductive PostfixExpr where
  | Primary : PrimaryExpr → PostfixExpr
  | SquareBrack : PostfixExpr → Expression → PostfixExpr
  | CurlyBrack : PostfixExpr → PostfixExpr
  | AEL : PostfixExpr → ArgumentExpressionList → PostfixExpr
  | Identifier : PostfixExpr → String → PostfixExpr
  | PtrIdent : PostfixExpr → String → PostfixExpr
  | IncOp : PostfixExpr → PostfixExpr
  | DecOp : PostfixExpr → PostfixExpr

syntax primary_expression : postfix_expression
syntax postfix_expression "[" expression "]" : postfix_expression
syntax postfix_expression "(" ")"  : postfix_expression
syntax postfix_expression "(" argument_expression_list ")" : postfix_expression
syntax postfix_expression "." ident : postfix_expression
syntax postfix_expression "->" ident : postfix_expression
syntax postfix_expression "++" : postfix_expression
syntax postfix_expression "--" : postfix_expression

syntax "`[postfix_expression| " postfix_expression "]" : term

inductive UnaryOp where
  | Address : UnaryOp
  | Indirection : UnaryOp
  | Plus : UnaryOp
  | Minus : UnaryOp
  | Complement : UnaryOp
  | LogicalNegation : UnaryOp

syntax "&" : unary_operator
syntax "*" : unary_operator
syntax "+" : unary_operator
syntax "-" : unary_operator
syntax "~" : unary_operator
syntax "!" : unary_operator

syntax "`[unary_operator| " unary_operator "]" : term

inductive UnaryExpr where
  | PostFix : PostfixExpr → UnaryExpr
  | IncUnary : UnaryExpr → UnaryExpr
  | DecUnary : UnaryExpr → UnaryExpr
  | UnaryOpCast : UnaryOp → UnaryExpr
  | SizeOf : UnaryExpr → UnaryExpr
  | SizeOfType : TypeName → UnaryExpr

syntax postfix_expression : unary_expression
syntax "++" unary_expression : unary_expression
syntax "--" unary_expression : unary_expression
syntax unary_operator cast_expression : unary_expression
syntax "sizeof" unary_expression : unary_expression
-- syntax "sizeof" "(" type_name ")" : unary_expression   -- type_name not in group one

syntax "`[unary_expression| " unary_expression "]" : term

inductive CastExpr where
  | Unary : UnaryExpr → CastExpr
  | TypeNameCast : TypeName → CastExpr

syntax unary_expression : cast_expression
syntax "(" type_name ")" cast_expression : cast_expression

syntax "`[cast_expression| " cast_expression "]" : term

-- Expression is incomplete, temporarily made for primary_expression
inductive Expression : Type where
  | Foo: Int → Expression

syntax num : expression

syntax "`[expression| " expression "]" : term
