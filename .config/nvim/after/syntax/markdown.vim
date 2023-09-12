syn include @yamlTop syntax/yaml.vim
syntax match YAMLFrontMatter /\%^---\_.\{-}\.\.\.$/ contains=@yamlTop
unlet! b:current_syntax

