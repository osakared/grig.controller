_hx_length = function(table)
    return #table;
end

_hx_table_push = function(table, item)
    table[#table + 1]=item;
end

_hx_table_clear = function(table)
    for k in pairs (table) do
        table [k] = nil
    end
end