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

// Defines the project's version
include <version.scad>

// Include the config for the project
include <constants.scad>
include <config.scad>
include <helpers.scad>

// Include the shapes for the barriers
include <../shapes/barriers/helpers.scad>
include <../shapes/barriers/profiles.scad>
include <../shapes/barriers/fragments.scad>
include <../shapes/barriers/straight.scad>
include <../shapes/barriers/curved.scad>
include <../shapes/barriers/elements.scad>

// Include the shapes for the ground tiles
include <../shapes/grounds/helpers.scad>
include <../shapes/grounds/profiles.scad>
include <../shapes/grounds/fragments.scad>
include <../shapes/grounds/straight.scad>
include <../shapes/grounds/curved.scad>
include <../shapes/grounds/elements.scad>

// Include the shapes for the full tiles
include <../shapes/tiles/profiles.scad>
include <../shapes/tiles/fragments.scad>
include <../shapes/tiles/straight.scad>
include <../shapes/tiles/curved.scad>
include <../shapes/tiles/elements.scad>

// Include the shapes for the animations
include <../shapes/animations/helpers.scad>
include <../shapes/animations/operators.scad>
include <../shapes/animations/straight.scad>
include <../shapes/animations/curved.scad>

// The overall length of a track section (size of a tile in the track)
trackSectionLength = getTrackSectionLength(trackLaneWidth, barrierWidth);

// The overall width of a track section (size of a tile in the track)
trackSectionWidth = getTrackSectionWidth(trackLaneWidth, barrierWidth);

// The length of a barrier chunk
barrierLength = getBarrierLength(trackLaneWidth, barrierWidth, barrierChunks);

// Show the config values
if (showConfig) {
    let(
        barrierBaseUnit = getBarrierBaseUnit(barrierWidth, barrierHeight),
        trackSectionPadding = (trackSectionLength - trackSectionWidth) / 2,
        tightCurveInnerRadius = getCurveInnerRadius(trackSectionLength, trackSectionWidth, 1) + barrierWidth,
        tightCurveOuterRadius = getCurveOuterRadius(trackSectionLength, trackSectionWidth, 1) - barrierWidth,
        largeCurveInnerRadius = getCurveInnerRadius(trackSectionLength, trackSectionWidth, 2) + barrierWidth,
        largeCurveOuterRadius = getCurveOuterRadius(trackSectionLength, trackSectionWidth, 2) - barrierWidth
    ) {
        echo(join([
            "",
            str("-- RC Track System ------------------"),
            str("Scale:                         ", PROJECT_SCALE),
            str("Version:                       ", printVersion()),
            str("-- Track elements -------------------"),
            str("Track lane width:              ", trackLaneWidth / 10, "cm"),
            str("Track section length:          ", trackSectionLength / 10, "cm"),
            str("Track section width:           ", trackSectionWidth / 10, "cm"),
            str("Track section padding:         ", trackSectionPadding / 10, "cm"),
            str("Tight curve inner radius:      ", tightCurveInnerRadius / 10, "cm"),
            str("Tight curve outer radius:      ", tightCurveOuterRadius / 10, "cm"),
            str("Large curve inner radius:      ", largeCurveInnerRadius / 10, "cm"),
            str("Large curve outer radius:      ", largeCurveOuterRadius / 10, "cm"),
            str("Barrier width:                 ", barrierWidth, "mm"),
            str("Barrier height:                ", barrierHeight, "mm"),
            str("Barrier length:                ", barrierLength, "mm"),
            str("Barrier chunks:                ", barrierChunks, " per section"),
            str("Barrier base value:            ", barrierBaseUnit, "mm"),
            str("Barrier fastener diameter      ", fastenerDiameter, "mm"),
            str("Barrier fastener head diameter ", fastenerHeadDiameter, "mm"),
            str("Barrier fastener head height   ", fastenerHeadHeight, "mm"),
            str("Ground thickness:              ", trackGroundThickness, "mm"),
            str("-- Printer settings -----------------"),
            str("Nozzle diameter:               ", nozzleWidth, "mm"),
            str("Print layer:                   ", layerHeight, "mm"),
            str("Print tolerance:               ", printTolerance, "mm"),
            str("Printer's length:              ", printerLength / 10, "cm"),
            str("Printer's width:               ", printerWidth / 10, "cm"),
            str("Print interval:                ", printInterval, "mm"),
            ""
        ], str(chr(13), chr(10))));
    }
}

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
