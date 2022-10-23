if type -q aws_completer
    complete aws -fa '(COMP_LINE=(commandline -pc) aws_completer)'
end
