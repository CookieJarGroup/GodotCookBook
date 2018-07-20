from godot import exposed
from godot.bindings import Area2D, Vector2


DEFAULT_SPEED = 220


@exposed
class test(Area2D):


    def _process(self, delta):
        pass

    def _ready(self):
        pass
