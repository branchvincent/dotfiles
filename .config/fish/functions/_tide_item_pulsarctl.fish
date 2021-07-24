function _tide_item_pulsarctl --description "Show Pulsar context"
    echo (set_color blue) (pulsarctl context current 2>&1)
end
