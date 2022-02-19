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
 * Setup the project.
 *
 * @author jsconan
 */

// Bootstrap the project using the global config
include <../../config/setup.scad>

// Include the config for the project
include <config.scad>
include <constants.scad>

// Include the helpers
include <helpers.scad>
include <../shapes/barriers/helpers.scad>
include <../shapes/grounds/helpers.scad>

// Include the shapes for the barriers
include <../shapes/barriers/profiles.scad>
include <../shapes/barriers/fragments.scad>
include <../shapes/barriers/straight.scad>
include <../shapes/barriers/curved.scad>
include <../shapes/barriers/elements.scad>

// Include the shapes for the ground tiles
include <../shapes/grounds/profiles.scad>
include <../shapes/grounds/fragments.scad>
include <../shapes/grounds/straight.scad>
include <../shapes/grounds/curved.scad>
include <../shapes/grounds/elements.scad>

// The overall length of a track section (size of a tile in the track)
trackSectionLength = getTrackSectionLength(trackLaneWidth, barrierWidth);

// The overall width of a track section (size of a tile in the track)
trackSectionWidth = getTrackSectionWidth(trackLaneWidth, barrierWidth);

// The length of a barrier chunk
barrierLength = getBarrierLength(trackLaneWidth, barrierWidth, barrierChunks);

// Validate the config values, checking if they match the critical constraints.
let(
    barrierLinkLength = getBarrierLinkLength(barrierWidth, barrierHeight),
    barrierPegDiameter = getBarrierPegDiameter(barrierWidth, barrierHeight),
    barrierBaseUnit = getBarrierBaseUnit(barrierWidth, barrierHeight)
) {
    assert(
        barrierLength > barrierLinkLength * 2 + barrierPegDiameter + shells(8),
        "The size of a barrier chunk is too small! Please increase the track lane or reduce the number of chunks per track section."
    );
    assert(
        !(barrierChunks % 2),
        "The number of chunks per track section must be a factor of 2."
    );
    assert(
        barrierWidth > fastenerDiameter + barrierBaseUnit * 2,
        "The diameter of the barrier fasteners is too large to fit into the barrier chunks!"
    );
    assert(
        barrierWidth > fastenerHeadDiameter + barrierBaseUnit,
        "The diameter of the barrier fasteners head is too large to fit into the barrier chunks!"
    );
    assert(
        barrierHeight > fastenerHeadHeight * 2 + barrierBaseUnit,
        "The height of the barrier fasteners head is too large to fit into the barrier chunks!"
    );
    assert(
        trackGroundThickness > layers(2),
        "The ground thickness is too small, please increase it!"
    );
}
