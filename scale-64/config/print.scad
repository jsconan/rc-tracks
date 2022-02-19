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
 * Show the config values.
 *
 * @author jsconan
 */

// Import the project's setup.
include <setup.scad>

// Show the config values
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
        str("Version:                       ", projectVersion),
        str("Scale:                         ", "1/64 to 1/76"),
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
