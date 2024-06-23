-- script que invoca o shader dos fractais

function fractal.start()
    local this = engine.current()
    local cam = engine.cam2d.get(engine.cam2d.get_current())

    -- tamanho da tela enviada ao shader
    this._size_x = cam.right
    this._size_y = cam.top

    -- retangulo do tamanho da tela em vertices
    this._quad_id = engine.vertex.create({
        vertices_count = 6,
        buffers_count = 1,
        buffers = {
            {
                type = engine.enums.vertex_buffer_type.float,
                data = {
                    0.0, 0.0,
                    0.0, 1.0,
                    1.0, 1.0,
                    0.0, 0.0,
                    1.0, 1.0,
                    1.0, 0.0
                },
                layouts_count = 1,
                layouts = {
                    {
                        count = 2,
                    }
                }
            }
        }
    })

    -- create shader de fractal
    this._shader_id = engine.shader.create({
        vertex_path = engine.dir.get_assets_path() .. "/shaders/shader.vert",
        fragment_path = engine.dir.get_assets_path() .. "/shaders/" .. this.file_name,
    })
end

function fractal.update()
    fractal.control()
    fractal.draw_fractal()
end

function  fractal.control()
    local this = engine.current()

    local right_key = engine.input.get_key(engine.enums.keyboard_key.right)
    local left_key = engine.input.get_key(engine.enums.keyboard_key.left)
    local up_key = engine.input.get_key(engine.enums.keyboard_key.up)
    local down_key = engine.input.get_key(engine.enums.keyboard_key.down)
    local z_key = engine.input.get_key(engine.enums.keyboard_key.Z)
    local space_key = engine.input.get_key(engine.enums.keyboard_key.space)
    
    local translate_amount = 5 - (this.zoom/40);
    if(right_key == engine.enums.input_action.press) then 
        this.center_x = this.center_x - translate_amount
    end

    if(left_key == engine.enums.input_action.press) then 
        this.center_x = this.center_x + translate_amount
    end

    if(up_key == engine.enums.input_action.press) then 
        this.center_y = this.center_y - translate_amount
    end

    if(down_key == engine.enums.input_action.press) then 
        this.center_y = this.center_y + translate_amount
    end

    if(down_key == engine.enums.input_action.press) then 
        this.center_y = this.center_y + translate_amount
    end

    if(z_key == engine.enums.input_action.press) then 
        this.zoom = this.zoom - (this.zoom * engine.get_frametime()/this.zoom_factor)
    end

    if(space_key == engine.enums.input_action.press) then 
        this.zoom = this.zoom + engine.get_frametime()/this.zoom_factor
    end
end

function fractal.draw_fractal()
    local this = engine.current()

    engine.shader.activate(this._shader_id)
    engine.shader.set_mat4(engine.cam2d.get_current(), "projection", engine.cam2d.get_matrix(engine.cam2d.get_current()))

    local model = engine.math.make_identity_mat4()
    model = engine.math.translate(model, { x = this._size_x / 2 - this._size_x / 2, y = this._size_y / 2 - this._size_y / 2, z = 0 })
    model = engine.math.scale(model, { x = this._size_x, y = this._size_y, z = 1 })

    engine.shader.set_mat4(this._shader_id, "model", model)
    engine.shader.set_vec2(this._shader_id, "resolution", { x = this._size_x, y = this._size_y })
    engine.shader.set_vec2(this._shader_id, "center", { x = this.center_x, y = this.center_y})
    engine.shader.set_float(this._shader_id, "zoom", this.zoom)
    engine.shader.set_int(this._shader_id, "max_iterations", this.max_iterations)
    
    if this.samples then 
        engine.shader.set_int(this._shader_id, "samples", this.samples)
    end

    engine.vertex.activate(this._quad_id)
    engine.vertex.draw(this._quad_id, engine.enums.drawing_type.triangle_fan)

    engine.command.set_primitive_point_size(10)
end

function fractal.destroy()
    local this = engine.current()
    engine.shader.destroy(this._shader_id)
    engine.vertex.destroy(this._quad_id)
end
