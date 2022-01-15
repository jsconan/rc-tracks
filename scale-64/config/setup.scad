/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2022 Jean-Sebastien CONAN
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
 * A race track system for 1/64 to 1/76 scale RC cars.
 *
 * Setup the context.
 *
 * @author jsconan
 */

// Bootstrap the project using the global config
include <../../config/setup.scad>

// Then we need the config for the project
include <config.scad>
include <values.scad>

// Finally, include the shapes
include <../shapes/profiles.scad>
include <../shapes/fragments.scad>
include <../shapes/straight.scad>
include <../shapes/curved.scad>
include <../shapes/ground.scad>

// Validate the config against the constraints
validateConfig(
    lane = trackLaneWidth,
    thickness = trackGroundThickness,
    width = barrierWidth,
    height = barrierHeight,
    chunks = barrierChunks,
    diameter = fastenerDiameter,
    headDiameter = fastenerHeadDiameter,
    headHeight = fastenerHeadHeight
);
