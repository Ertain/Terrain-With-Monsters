#  Copyright (C) 2018  Jason Anderson

#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  

extends KinematicBody2D

const MAX_SPEED = 750 # Pixels per second
var speed = 0
var vel = Vector2()
# This is so that the blob doesn't move so often.
var delay = 1
var waited = 0
# We can't have the speech bubble showing all the time.
var show_speech_bubble = false
onready var speech_bubble_timer = get_node("bubble_timer")
onready var speech_bubble = get_node("speech bubble")
var the_collider = 0
var collisionCounter = 0

func randomly_select_direction():
    var direction = ['move_up','move_down','move_right','move_left']
    var num = randi() % direction.size()
    var random_choice = direction[num]
    return random_choice

func _on_bubble_timer_timeout():
    speech_bubble.hide()

func _ready():
    randomize()
    speech_bubble_timer.wait_time = 1
    # Updates during the "_physics_process".
    speech_bubble_timer.process_mode = 0

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
    
    # Show the speech bubble. Set a timer to count down
    # until you need to hide the speech bubble.
    if show_speech_bubble:
        speech_bubble.show()
        speech_bubble_timer.start()
        show_speech_bubble = false

    var collisionCounter = get_slide_count() - 1
    if collisionCounter > -1:
        var le_collision =  get_slide_collision(0).collider
        if le_collision is KinematicBody2D:
            show_speech_bubble = true

