/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020-2022 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/rc-tracks.
 *
 * jsconan/rc-tracks is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/rc-tracks is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/rc-tracks. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A race track system for 1/24 to 1/32 scale RC cars.
 *
 * Setup the context and define the config for the tests.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../config/setup.scad>

// Defines the test config
mode = MODE_DEV;        // The render quality to apply
length = 50;            // The nominal size of a track element
width = 50;             // The virtual width of a track lane
lane = 100;             // The actual width of a track lane
radius = 50;            // The radius of the track inner curve
height = 30;            // The height of the barrier, including the holders
base = 2;               // The base unit value used to design the barrier holder
thickness = 0.6;        // The thickness of the barrier body
wall = 0.8;             // The thickness of the walls
clip = 2;               // The thickness of the cable clips

// Validate the config against the constraints
validateConfig(
    length = length,
    width = width,
    lane = lane,
    height = height,
    radius = radius,
    base = base
);

// Show the values
printConfig(
    length = length,
    width = width,
    lane = lane,
    height = height,
    radius = radius,
    base = base
);
