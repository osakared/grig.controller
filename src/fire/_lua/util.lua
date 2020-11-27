_hx_insert_tag_value = function(table, tag, value)
    table:insert({tag = tag,value = value})
end

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

--- ======================================================================================================
--- https://github.com/mrVanDalo/stepp0r/blob/master/src/Layer/PlaybackPositionObserver.lua
---                                                 [ Line Change Observer ]
---
--- observes the playback position to make listeners on the playback position possible

class "LineChaneObserver"

--- ======================================================================================================
---
---                                                 [ INIT ]

function LineChaneObserver:__init()
    self._hooks = {}
end

--- id : a key to find the hook later (to delete it)
--- hook : a function called (with the updated value)
function LineChaneObserver:register(id,hook)

    if self._hooks[id] then
        self:unregister(id)
    end

    local internal_hook_func = function()
        local current_pos_value = renoise.song().transport.playback_pos
        local current_effect_column_value = renoise.song().selected_effect_column_index
        local current_note_column_value = renoise.song().selected_note_column_index
        if current_pos_value ~= self._hooks[id].last_pos_value then
            self._hooks[id].last_pos_value = current_pos_value
            self._hooks[id].external_hook()
        elseif current_effect_column_value ~= self._hooks[id].last_effect_column_value then
            self._hooks[id].last_effect_column_value = current_effect_column_value
            self._hooks[id].external_hook()
        elseif current_note_column_value ~= self._hooks[id].last_note_column_value then
            self._hooks[id].last_note_column_value = current_note_column_value
            self._hooks[id].external_hook()
        end
    end

    self._hooks[id] = {
        external_hook  = hook,
        internal_hook  = internal_hook_func,
        last_pos_value = renoise.song().transport.playback_pos,
        last_effect_column_value = renoise.song().selected_effect_column_index,
        last_note_column_value = renoise.song().selected_note_column_index,
    }

    renoise.tool().app_idle_observable:add_notifier(internal_hook_func)
end

function LineChaneObserver:unregister(id)
    if self._hooks[id] then
        if renoise.tool().app_idle_observable:has_notifier(self._hooks[id].internal_hook) then
            renoise.tool().app_idle_observable:remove_notifier(self._hooks[id].internal_hook)
        end
        self._hooks[id] = nil
    end
end

function LineChaneObserver:has_notifier(id)
    if self._hooks[id] then
        return true
    else
        return false
    end
end
