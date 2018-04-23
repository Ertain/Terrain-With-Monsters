# Copyright (C) 2018 Jason Anderson

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.
# 
#


extends Node2D

onready var music_box = get_node("Background Music")
var phrases = ['I could\nsure use some\nmoisturizer.', 'Thank you\nfor clicking\nthat!', 'Is this\na secret to\neverybody?', 'There will\nbe light\nshowers\nthis evening.',
                'Why don\'t\nyou go\nand click off?']
var music_offset = 0.0

func _ready():
    # For some odd reason, this loops by default. Therefore,
    # we need to turn off looping.
    $Falling_Rocks.stream.loop = false

# Some code for exiting the program.
func _process(change_in_time):
    if(Input.is_key_pressed(KEY_ESCAPE)):
        get_tree().quit()

func _on_Treasure_box_pressed():
    if music_box.is_playing():
        music_offset = music_box.get_playback_position()
        music_box.stop()
        $"Plain/Ghost/complain timer".start()
    else:
        music_box.play(music_offset)


func _on_Rock1_pressed():
    $Falling_Rocks.play()

func _on_Crystal1_pressed():
    $Fortune/MarginContainer/HBoxContainer/Label.align = HALIGN_CENTER
    $Fortune/MarginContainer/HBoxContainer/Label.text = phrases[ randi() % phrases.size() ]
    $Fortune.popup()

func _on_okay_button_pressed():
    $Fortune.hide()
