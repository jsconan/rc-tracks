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
 * Global functions.
 *
 * @author jsconan
 */

/**
 * Aligns a value with respect to the target layer height.
 * @param Number value
 * @returns Number
 */
function layerAligned(value) = roundBy(value, layerHeight);

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
function layers(N) = N * layerHeight;

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
 * Gets the adjusted quantity of shapes to place on a grid with repect to the size of one shape.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @returns Number
 */
function getMaxQuantity(length, width, quantity=1) =
    let(
        maxLine = floor(printerLength / length),
        maxCol = floor(printerWidth / width)
    )
    min(maxLine * maxCol, quantity)
;

/**
 * Gets the maximal number of shapes that can be placed on a line with respect the size of one shape.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @param Number [line] - The expected number of shapes per line.
 * @returns Number
 */
function getMaxLine(length, width, quantity=1, line=undef) =
    let(
        maxLine = floor(printerLength / length)
    )
    min(uor(line, ceil(sqrt(quantity))), maxLine)
;

/**
 * Gets the overall length of the area taken to place the repeated shapes on a grid with respect to the expected quantity.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @param Number [line] - The expected number of shapes per line.
 * @returns Number
 */
function getGridLength(length, width, quantity=1, line=undef) =
    let(
        length = getPrintInterval(length),
        width = getPrintInterval(width),
        quantity = getMaxQuantity(length, width, quantity)
    )
    min(quantity, getMaxLine(length, width, quantity, line)) * length
;

/**
 * Gets the overall width of the area taken to place the repeated shapes on a grid with respect to the expected quantity.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @param Number [line] - The expected number of shapes per line.
 * @returns Number
 */
function getGridWidth(length, width, quantity=1, line=undef) =
    let(
        length = getPrintInterval(length),
        width = getPrintInterval(width),
        quantity = getMaxQuantity(length, width, quantity),
        line = getMaxLine(length, width, quantity, line)
    )
    ceil(quantity / line) * width
;

/**
 * Computes the length of a straight section given the ratio.
 * @param Number length - The length of a track section.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getStraightLength(length, ratio=1) = length * abs(ratio);

/**
 * Gets the length of a curved section given the radius and the ratio.
 * @param Number radius - The radius of the curve.
 * @param Number [ratio] - The size factor.
 * @returns Number
 */
function getCurveLength(radius, ratio=1) = getArcLength(radius=radius, angle=getCurveAngle(ratio));

/**
 * Computes the angle of a curve with respect to the ratio.
 * @param Number ratio - The ratio of the curve.
 * @returns Number
 */
function getCurveAngle(ratio) = CURVE_ANGLE / abs(ratio);

/**
 * Computes the rotation angle used to place a curve.
 * @param Number angle - The angle of the curve.
 * @returns Number
 */
function getCurveRotationAngle(angle) = CURVE_ANGLE - angle / 2;
