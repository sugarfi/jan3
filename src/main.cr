require "kemal"
require "celestine"
require "random"

WIDTH = 800
HEIGHT = 600

START_RADIUS = 200
MAX = 4
TO = [
    {-1, -1},
    { 1, -1},
    {-1,  1},
    { 1,  1}
]

get "/" do
    Celestine.draw do |ctx|
        ctx.width = WIDTH
        ctx.height = HEIGHT
        ctx.width_units = ctx.height_units = "px"

        width = START_RADIUS * 2
        
        (0..MAX).to_a.reverse.each do |i|
            count = 2 ** i
            radius = START_RADIUS / count
            dia = radius * 2

            count.times do |y|
                count.times do |x|
                    TO.each do |target|
                        xt, yt = target

                        ctx.circle do |c|
                            xn = x * dia + radius
                            yn = y * dia + radius

                            c.fill = "red"
                            c.fill_opacity = 0

                            c.x = xn
                            c.y = yn

                            c.radius = radius

                            c.animate do |a|
                                a.attribute = "cx"
                                a.from = xn
                                a.to = xn + xt * radius / 2

                                a.duration = 2

                                a.freeze = true

                                a.custom_attrs = {
                                    "begin" => "#{i * 3}s"
                                }

                                a
                            end

                            c.animate do |a|
                                a.attribute = "cy"
                                a.from = yn
                                a.to = yn + yt * radius / 2

                                a.duration = 2

                                a.freeze = true

                                a.custom_attrs = {
                                    "begin" => "#{i * 3}s"
                                }

                                a
                            end

                            c.animate do |a|
                                a.attribute = "r"
                                a.from = radius
                                a.to = radius / 2

                                a.duration = 2

                                a.freeze = true

                                a.custom_attrs = {
                                    "begin" => "#{i * 3}s"
                                }

                                a
                            end
                
                            c.animate do |a|
                                a.attribute = "fill-opacity"

                                a.from = 0
                                a.to = 1

                                a.duration = 1
            
                                a.freeze = true

                                if i != 0
                                    a.custom_attrs = {
                                        "begin" => "#{(i - 1) * 3 + 2}s"
                                    }
                                end

                                a
                            end

                            if i < MAX
                                c.animate do |a|
                                    a.attribute = "fill-opacity"

                                    a.from = 1
                                    a.to = 0

                                    a.duration = 1
                
                                    a.freeze = true

                                    a.custom_attrs = {
                                        "begin" => "#{i * 3 + 2}s"
                                    }

                                    a
                                end
                            end

                            c
                        end
                    end
                end
            end
        end
    end
end

Kemal.run
