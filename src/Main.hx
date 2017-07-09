
import haxegon.*;

@:publicFields
class Main {

    static inline var screen_width = 1080;
    static inline var screen_height = 1080;

    var position: Array<Int> = [1, 1];
    var allowed = [
    [5, 0], [6, 0],
    [0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1], [6, 1],
    [1, 2], [2, 2], [3, 2], [4, 2], [5, 2], [6, 2], 
    [1, 3], [2, 3], [3, 3], [4, 3], [5, 3], [6, 3], [7, 3], 
    [0, 5], [1, 5], [2, 5], [3, 5], [4, 5], [5, 5], [6, 5], 
    [1, 6], [3, 6], [4, 6], [5, 5], [6, 5],
    [4, 7], [5, 7],
    ];

    function roll() {
        position =  allowed[Random.int(0, allowed.length - 1)]; 
    }

    function new() {
        Gfx.resize_screen(screen_width, screen_height);
        Gfx.load_image("map");
        Gfx.line_thickness *= 5;

        roll();
    }

    function update() {
        Gfx.draw_image(0, 0, "map");
        var width = screen_width / 8;
        Gfx.draw_box(position[0] * width, position[1] * width, width, width, Col.RED);
        Text.display(75, 0, '${position[0]},${position[1]}', Col.RED);

        GUI.text_button(0, 0, "Reroll", function() { 
            roll();
        });
        if (Input.just_pressed(Key.R) || Input.just_pressed(Key.SPACE)) {
            roll();
        }
    }
}
