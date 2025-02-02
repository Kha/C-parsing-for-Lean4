# C-parsing-for-Lean4
A parser for ANSI C, in Lean4.

## Running

Run `lake build` at the toplevel folder.

## Description

The system uses macros to parse C code into an AST represented by a user-defined Lean type `translation_unit`.  
This has been implemented by defining syntax categories according to the ANSI C Grammar (see below), and mapping non-terminal expansions to different constructors of the corresponding datatype.

## Testing

In order to run the tests, first build. Then run `./build/bin/cParser`.  
This will run the parser on the files in the `Tests` directory.

Failed tests can be filtered by piping the output of the command through `grep` in the following manner:  
```./build/bin/cParser | grep error```

## Limitations

The parser is unable to parse multi-line C comments that are of the form:  
`/* ... */`

The parser interprets anything that follows a `--` as a Lean comment. So, the parser does not support the unary C command `--`

Since the parser does not maintain a symbol table, it cannot tell the difference between an identifier functioning as a type name and as a variable name. This ambiguity causes it to fail on certain cases of the `parameter_declaration` non-terminal, and those that depend on it. (see  `./Tests/GroupThree/ParamDecl/parameter_decl_3.c`)

## Group-wise list of non-terminals
The order in which the nonterminals of the C grammar ([reference](https://www.lysator.liu.se/c/ANSI-C-grammar-y.html)) is as follows:
```
+ assignment_expression
    + assignment_operator
    + assignment_expression
    + unary_expression
    + unary_operator
    + postfix_expression
    + primary_expression
    + argument_expression_list
    + expression
    + conditional_expression ... cast_expression [leads to type_name]

+ init_declarator_list
    + init_declarator
    + initializer [leads to assignment_expression]
    + initializer_list
    + declarator
    + pointer
    + type_qualifier
    + type_qualifier_list
    + direct_declarator [leads to parameter_type_list]
    + identifier_list
    + abstract_declarator
    + direct_abstract_declarator [leads to parameter_type_list]
    + constant_expression

+ declaration_list
    + declaration
    + init_declarator_list
    + parameter_type_list
    + parameter_list
    + parameter_declaration
    + declaration_specifiers
    + storage_class_specifier
    + type_specifier
    + enum_specifier
    + enumerator_list
    + enumerator
    + struct_or_union_specifier
    + struct_or_union
    + struct_declaration_list
    + struct_declaration
    + type_name
    + specifier_qualifier_list
    + struct_declarator_list
    + struct_declarator

+ compound_statement [leads to declaration_list]
    + statement_list
    + statement
    + labeled_statement
    + jump_statement
    + iteration_statement
    + selection_statement
    + expression_statement

+ translation_unit
    + external_declaration
    + function_definition
```