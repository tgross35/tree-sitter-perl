((source_file . (comment) @preproc)
  (#lua-match? @preproc "^#!/"))

[ "use" "no" "require" ] @include

[ "if" "elsif" "unless" "else" ] @conditional

(conditional_expression [ "?" ":" ] @conditional.ternary) 

[ "while" "until" "for" "foreach" ] @repeat

[ "try" "catch" "finally" ] @exception

"return" @keyword.return

[ "sub" "method" ] @keyword.function

[ "map" "grep" "sort" ] @function.builtin

[ "package" "class" ] @include

[
  "defer"
  "do" "eval"
  "my" "our" "local" "state" "field"
  "last" "next" "redo" "goto"
  "undef"
] @keyword

(_ operator: _ @operator)
"\\" @operator

(yadayada) @exception

(phaser_statement phase: _ @keyword.phaser)

[
  "or" "and"
  "eq" "ne" "cmp" "lt" "le" "ge" "gt"
  "isa"
] @keyword.operator

(eof_marker) @preproc
(data_section) @comment

(pod) @text

[
  (number)
  (version)
] @number

[
  (string_literal) 
  (interpolated_string_literal) 
  (quoted_word_list) 
  (command_string) 
  (heredoc_content)
  (replacement)
  (transliteration_content)
] @string

[
  (heredoc_token)
  (command_heredoc_token)
  (heredoc_end)
] @label

[(escape_sequence) (escaped_delimiter)] @string.escape

(_ modifiers: _ @character.special)
[  
 (quoted_regexp)
 (match_regexp)
 (regexp_content)
] @string.regex

(autoquoted_bareword) @string.special

(use_statement (package) @type)
(package_statement (package) @type)
(class_statement (package) @type)
(require_expression (bareword) @type)

(subroutine_declaration_statement name: (bareword) @function)
(method_declaration_statement name: (bareword) @method)
(attribute_name) @attribute
(attribute_value) @string

(label) @label

(statement_label label: _ @label)

(relational_expression operator: "isa" right: (bareword) @type)

(function_call_expression (function) @function.call)
(method_call_expression (method) @method.call)
(method_call_expression invocant: (bareword) @type)

(func0op_call_expression function: _ @function.builtin)
(func1op_call_expression function: _ @function.builtin)

([(function)(expression_statement (bareword))] @function.builtin
 (#match? @function.builtin
   "^(accept|atan2|bind|binmode|bless|crypt|chmod|chown|connect|die|dbmopen|exec|fcntl|flock|getpriority|getprotobynumber|gethostbyaddr|getnetbyaddr|getservbyname|getservbyport|getsockopt|glob|index|ioctl|join|kill|link|listen|mkdir|msgctl|msgget|msgrcv|msgsend|opendir|print|printf|push|pack|pipe|return|rename|rindex|read|recv|reverse|say|select|seek|semctl|semget|semop|send|setpgrp|setpriority|seekdir|setsockopt|shmctl|shmread|shmwrite|shutdown|socket|socketpair|split|sprintf|splice|substr|system|symlink|syscall|sysopen|sysseek|sysread|syswrite|tie|truncate|unlink|unpack|utime|unshift|vec|warn|waitpid|formline|open|sort)$"
))

(function) @function

(ERROR) @error

(_
  "{" @punctuation.special
  (varname)
  "}" @punctuation.special)

(varname 
  (block
    "{" @punctuation.special 
    "}" @punctuation.special))


(
  [(varname) (filehandle)] @variable.builtin
  (#match? @variable.builtin "^((ENV|ARGV|INC|ARGVOUT|SIG|STDIN|STDOUT|STDERR)|[_ab]|\\W|\\d+|\\^.*)$")
)

(scalar) @variable.scalar
(scalar_deref_expression [ "$" "*"] @variable.scalar)
[(array) (arraylen)] @variable.array
(array_deref_expression [ "@" "*"] @variable.array)
(hash) @variable.hash
(hash_deref_expression [ "%" "*"] @variable.hash)

(array_element_expression array:(_) @variable.array)
(slice_expression array:(_) @variable.array)
(keyval_expression array:(_) @variable.array)

(hash_element_expression hash:(_) @variable.hash)
(slice_expression hash:(_) @variable.hash)
(keyval_expression hash:(_) @variable.hash)

(comment) @comment

([ "=>" "," ";" "->" ] @punctuation.delimiter)

(
  [ "[" "]" "{" "}" "(" ")" ] @punctuation.bracket
  ; priority hack so nvim + ts-cli behave the same
  (#set! "priority" 90))
