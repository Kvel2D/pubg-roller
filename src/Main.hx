
import haxegon.*;

@:publicFields
class Main {

    static inline var screen_width = 972;
    static inline var screen_height = 972;

    var position: IntVector2 = {x: 0, y: 0};
    var forbidden = 
    [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [7, 0],
    [7, 1],
    [0, 2], [7, 2], 
    [0, 3], 
    [7, 5], 
    [0, 6], [2, 6], [7, 6], 
    [0, 7], [1, 7], [2, 7], [3, 7], [6, 7], [7, 7], 
    ];
    var allowed = new Array<IntVector2>();

    function roll() {
        position =  allowed[Random.int(0, allowed.length - 1)]; 
    }

    function new() {
        Gfx.resize_screen(screen_width, screen_height);
        Gfx.load_image("map");
        Gfx.line_thickness *= 3;

        function is_allowed(x, y) {
            for (pos in forbidden) {
                if (pos[0] == x && pos[1] == y) {
                    return false;
                }
            }
            return true;
        }

        for (x in 0...8) {
            for (y in 0...8) {
                if (is_allowed(x, y)) {
                    allowed.push({x: x, y: y});
                }
            }
        }

        roll();
    }

    function update() {
        Gfx.draw_image(0, 0, "map");
        var width = screen_width / 8;
        Gfx.draw_box(position.x * width, position.y * width, width, width, Col.ORANGE);
        Text.display(75, 0, '${position.x},${position.y}', Col.ORANGE);
        GUI.text_button(0, 0, "Reroll", function() { 
            roll();
        });

        if (Input.just_pressed(Key.R) || Input.just_pressed(Key.SPACE)) {
            roll();
        }
    }
}
