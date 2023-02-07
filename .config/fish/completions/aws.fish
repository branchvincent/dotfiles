if command -q aws_completer
    complete aws -fa '(COMP_LINE=(commandline -pc) COMP_POINT=(commandline -C) aws_completer)'
end
