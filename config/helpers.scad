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
 * A race track system for RC cars of various scales.
 *
 * Global helper functions.
 *
 * @author jsconan
 */

/**
 * Aligns a value with respect to the target layer height.
 * @param Number value
 * @returns Number
 */
function layerAligned(value) = roundBy(value, printResolution);

/**
 * Aligns a value with respect to the target nozzle size.
 * @param Number value
 * @returns Number
 */
function nozzleAligned(value) = roundBy(value, nozzleWidth);

/**
 * Gets the thickness of N layers.
 * @param Number N
 * @returns Number
 */
function layers(N) = N * printResolution;

/**
 * Gets the width of N times the nozzle width.
 * @param Number N
 * @returns Number
 */
function shells(N) = N * nozzleWidth;

/**
 * Computes the print interval between the centers of 2 objects.
 * @param Number size - The size of the shape.
 * @returns Number
 */
function getPrintInterval(size) = size + printInterval;

/**
 * Centers the children elements to te printer's build plate.
 * @param Boolean [moveOrigin] - Translate the children in order to be centered on the build plate.
 */
module centerBuildPlate(moveOrigin = false) {
    buildPlate([printerLength, printerWidth], center=!moveOrigin);
    translate(moveOrigin ? [printerLength, printerWidth, 0] / 2 : [0, 0, 0]) {
        children();
    }
};
