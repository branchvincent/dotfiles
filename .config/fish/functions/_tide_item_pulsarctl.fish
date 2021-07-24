function _tide_item_pulsarctl --description "Show Pulsar context"
    tide_pulsarctl_color=blue tide_pulsarctl_bg_color=normal \
        _tide_print_item pulsarctl ' ' (pulsarctl context current 2>&1)
end
