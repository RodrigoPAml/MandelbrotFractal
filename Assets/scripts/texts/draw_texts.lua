-- textos da tela

function draw_texts.start()
    local this = engine.current()
    local font_path = engine.dir.get_assets_path() .. '/fonts/arial.ttf';

    local cam = engine.cam2d.get(engine.cam2d.get_current())

    this._size_y = cam.top
    this._font_id = engine.font.create(font_path, 0, 128)
    this._time = engine.time.get_timestamp() 
end

function draw_texts.update()
    local this = engine.current()

    engine.font.set_scale(this._font_id, { x = 0.3, y = 0.3 })

    engine.font.set_color(this._font_id, { x = 1, y = 0, z = 0 })
    engine.font.set_text(this._font_id, 'Espaco/Z para zoom')
    engine.font.set_position(this._font_id, { x = 10, y = this._size_y - 100 })
    engine.font.draw(this._font_id)

    engine.font.set_color(this._font_id, { x = 1, y = 0, z = 1 })
    engine.font.set_text(this._font_id, 'Setas para mover')
    engine.font.set_position(this._font_id, { x = 10, y = this._size_y - 130 })
    engine.font.draw(this._font_id)

    engine.font.set_color(this._font_id, { x = 0, y = 1, z = 1 })
    engine.font.set_text(this._font_id, 'Q para trocar shader')
    engine.font.set_position(this._font_id, { x = 10, y = this._size_y - 160 })
    engine.font.draw(this._font_id)

    local q_key = engine.input.get_key(engine.enums.keyboard_key.Q)

    if(q_key == engine.enums.input_action.press and this._time < engine.time.get_timestamp()) then 
        local go = engine.go.get(engine.go.find_all('fractal')[1])
        local go2 = engine.go.get(engine.go.find_all('fractal_basic')[1])

        if(go.active) then
            engine.go.set_active(go.id, false)
            engine.go.set_active(go2.id, true)
        else 
            engine.go.set_active(go2.id, false)
            engine.go.set_active(go.id, true)
        end

        this._time = engine.time.get_timestamp() + 0.1
    end
end

function draw_texts.destroy()
    local this = engine.current()
    engine.font.destroy(this._font_id)
end