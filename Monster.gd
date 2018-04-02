#    Copyright (C) 2018  Jason Anderson

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

extends KinematicBody2D

const MAX_SPEED = 750 # Pixels per second
var speed = 0
var vel = Vector2()
var delay = 1
var waited = 0


func randomly_select_direction():
    var direction = ['move_up','move_down','move_right','move_left']
    var num = randi() % direction.size()
    var random_choice = direction[num]
    return random_choice

func _ready():
    randomize()

func _physics_process(change_in_time):
    var motion = Vector2()
    
    if waited > delay:
        var selection = randomly_select_direction()
        if selection == "move_up":
            # motion += Vector2(0, -1)
            motion.y = -1
        elif selection == "move_down":
            # motion += Vector2(0, 1)
            motion.y = 1
        if selection == "move_left":
            # motion += Vector2(-1, 0)
            motion.x = -1
        elif selection == "move_right":
            # motion += Vector2(1, 0)
            motion.x = 1
        if motion != Vector2():
            speed = MAX_SPEED
        else:
            speed = 0
        vel = motion.normalized() * speed
        move_and_slide(vel)
        waited = 0
    elif waited <= delay:
        waited += change_in_time
