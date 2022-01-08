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
 * Refines values and defines functions.
 *
 * @author jsconan
 */

/**
 * Computes the height of the barrier body part that will be inserted in the holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getBarrierStripHeight(base) = base * stripHeightRatio;

/**
 * Computes the indent of the barrier body strip.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getBarrierStripIndent(base) = base * stripIndentRatio;

/**
 * Computes the outer length of a barrier link.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierLinkLength(base, distance = 0) = base * 1.5 + distance;

/**
 * Computes the outer width of a barrier link.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierLinkWidth(base, distance = 0) = (base + distance) * 2;

/**
 * Computes the outer width of a barrier holder notch.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierNotchWidth(base, distance = 0) = (getBarrierLinkWidth(base, distance) + getBarrierStripIndent(base) + minWidth) * 2;

/**
 * Computes the inner width of a barrier holder notch.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Number
 */
function getBarrierNotchDistance(base, distance = 0) = (getBarrierLinkWidth(base, distance) + minWidth) * 2;

/**
 * Computes the outer width of a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier holder.
 * @returns Number
 */
function getBarrierHolderWidth(base, distance = 0) = getBarrierLinkWidth(base, printTolerance) + minWidth * 4 + distance * 2;

/**
 * Computes the top width of a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @returns Number
 */
function getBarrierHolderTopWidth(base, thickness) = nozzleAligned((getBarrierLinkWidth(base, printTolerance) - thickness) / 2) * 2 + thickness;

/**
 * Computes the outer height of a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier holder.
 * @returns Number
 */
function getBarrierHolderHeight(base, distance = 0) = getBarrierStripHeight(base) + minThickness + layerHeight + distance * 2;

/**
 * Computes the height of the link for a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getBarrierHolderLinkHeight(base) = getBarrierHolderHeight(base) - base;

/**
 * Computes the outer width of a unibody barrier.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier.
 * @returns Number
 */
function getBarrierUnibodyWidth(base, distance = 0) = getBarrierHolderWidth(base) + base + distance * 2;

/**
 * Computes the height of the link for a unibody barrier.
 * @param Number height - The height of the barrier.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getBarrierUnibodyLinkHeight(height, base) = height - getBarrierHolderHeight(base) - base;

/**
 * Computes the inner height of the barrier body, between the barrier holders.
 * @param Number height - The height of the barrier.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getBarrierBodyInnerHeight(height, base) = height - (getBarrierStripHeight(base) + minThickness) * 2;

/**
 * Computes the outer height of the barrier body, taking care of the barrier holders.
 * @param Number height - The height of the barrier.
 * @returns Number
 */
function getBarrierBodyHeight(height) = height - (minThickness + layerHeight) * 2;

/**
 * Gets the length of a curved track element (the length of the arc of the curve).
 * @param Number length - The length of the track element.
 * @returns Number
 */
function getCurveLength(length) = getArcLength(radius = length, angle = 90);

/**
 * Gets the difference between the length of a curved track element chunk and a straight track element.
 * @param Number length - The length of the track element.
 * @returns Number
 */
function getCurveRemainingLength(length) = getCurveLength(length) - length;

/**
 * Computes the minimal length of a track element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getMinLength(base) = getBarrierNotchWidth(base, printTolerance) * 4;

/**
 * Computes the minimal height of a track barrier.
 * @param Number base - The base unit value used to design the barrier holder.
 * @returns Number
 */
function getMinHeight(base) = getBarrierStripHeight(base) * 3;

/**
 * Computes the ratio of the inner curve with respect to the track section size.
 * @param Number length - The nominal size of a track element.
 * @param Number radius - The radius of the track inner curve.
 * @returns Number
 */
function getInnerCurveRatio(length, radius) = radius / length;

/**
 * Computes the ratio of the outer curve with respect to the track width.
 * @param Number length - The nominal size of a track element.
 * @param Number width - The width of a track lane.
 * @param Number radius - The radius of the track inner curve.
 * @returns Number
 */
function getOuterCurveRatio(length, width, radius) = (width + radius) / length;

/**
 * Computes the radius of a curve with respect to the ratio.
 * @param Number length - The nominal size of a track element.
 * @param Number ratio - The ratio of the curve.
 * @returns Number
 */
function getCurveRadius(length, ratio) = length * ratio;

/**
 * Computes the angle of a curve with respect to the ratio.
 * @param Number ratio - The ratio of the curve.
 * @returns Number
 */
function getCurveAngle(ratio) = curveAngle / ratio;

/**
 * Computes the rotation angle used to place a curve.
 * @param Number angle - The angle of the curve.
 * @returns Number
 */
function getCurveRotationAngle(angle) = 45 + (curveAngle - angle) / 2;

/**
 * Computes the radius of the accessory mast.
 * @param Number width - The width of the mast.
 * @returns Number
 */
function getMastRadius(width) = circumradius(n = mastFacets, a = width / 2);

/**
 * Validates the config values, checking if it match the critical constraints.
 * @param Number length - The nominal size of a track element.
 * @param Number width - The virtual width of a track lane (i.e. the width used to compute the outer radius).
 * @param Number lane - The actual width of a track lane (i.e. the width of the physical track lanes).
 * @param Number height - The height of the barrier.
 * @param Number radius - The radius of the track inner curve.
 * @param Number base - The base unit value used to design the barrier holder.
 */
module validateConfig(length, width, lane, height, radius, base) {
    assert(
        length >= getMinLength(base),
        str(
            "The size for a track element is too small! The minimum length is ",
            getMinLength(base),
            ". The current value is ",
            length
        )
    );
    assert(
        barrierHeight >= getMinHeight(base),
        str(
            "The height for a track barrier is too small! The minimum height is ",
            getMinHeight(base),
            ". The current value is ",
            barrierHeight
        )
    );
    assert(
        width >= length,
        "The virtual width of the track must be greater or equal than the length of one element!"
    );
    assert(
        lane >= length && lane >= width,
        "The actual width of the track must be greater or equal than the length of one element and than the virtual width as well!"
    );
    assert(
        radius >= length,
        "The radius of the track inner curve must be greater or equal than the length of one element!"
    );
    assert(
        width % length == 0,
        "The virtual width of the track must be a multiple of the length of one element!"
    );
    assert(
        lane % length == 0,
        "The actual width of the track must be a multiple of the length of one element!"
    );
    assert(
        radius % length == 0,
        "The radius of the track inner curve must be a multiple of the length of one element!"
    );
}

/**
 * Prints the config values.
 * @param Number length - The nominal size of a track element.
 * @param Number width - The virtual width of a track lane (i.e. the width used to compute the outer radius).
 * @param Number lane - The actual width of a track lane (i.e. the width of the physical track lanes).
 * @param Number height - The height of the barrier.
 * @param Number radius - The radius of the track inner curve.
 * @param Number base - The base unit value used to design the barrier holder.
 */
module printConfig(length, width, lane, height, radius, base) {
    innerCurveRatio = getInnerCurveRatio(length, radius);
    outerCurveRatio = getOuterCurveRatio(length, width, radius);
    echo(join([
        "",
        str("-- RC Track System ------------"),
        str("Version:               ", projectVersion),
        str("-- Track elements -------------"),
        str("Track section length:  ", length / 10, "cm"),
        str("Curve section length:  ", getCurveLength(length) / 10, "cm"),
        str("Virtual lane width:    ", width / 10, "cm"),
        str("Actual lane width:     ", lane / 10, "cm"),
        str("Track inner radius:    ", radius / 10, "cm"),
        str("Inner curve ratio:     ", innerCurveRatio),
        str("Inner curve angle:     ", getCurveAngle(innerCurveRatio), "°"),
        str("Outer curve ratio:     ", outerCurveRatio),
        str("Outer curve angle:     ", getCurveAngle(outerCurveRatio), "°"),
        str("Barrier height:        ", height, "mm"),
        str("Barrier thickness:     ", barrierBodyThickness, "mm"),
        str("Barrier base value:    ", base, "mm"),
        str("Barrier holder width:  ", getBarrierHolderWidth(base), "mm"),
        str("Barrier holder height: ", getBarrierHolderHeight(base), "mm"),
        str("Unibody barrier width: ", getBarrierUnibodyWidth(base), "mm"),
        str("Unibody barrier height:", height, "mm"),
        str("-- Track samples --------------"),
        str("Size of samples:       ", sampleSize, "mm"),
        str("Base of samples:       ", sampleBase, "mm"),
        str("-- Track accessories ----------"),
        str("Mast height:           ", mastHeight, "mm"),
        str("Mast width:            ", mastWidth, "mm"),
        str("Mast radius:           ", getMastRadius(mastWidth), "mm"),
        str("Flag height:           ", flagHeight, "mm"),
        str("Flag width:            ", flagWidth, "mm"),
        str("Flag thickness:        ", flagThickness, "mm"),
        str("-- Printer settings -----------"),
        str("Nozzle diameter:       ", nozzleWidth, "mm"),
        str("Print layer:           ", layerHeight, "mm"),
        str("Print tolerance:       ", printTolerance, "mm"),
        str("Printer's length:      ", printerLength / 10, "cm"),
        str("Printer's width:       ", printerWidth / 10, "cm"),
        str("Print interval:        ", printInterval, "mm"),
        ""
    ], str(chr(13), chr(10))));
}

// The minimal thickness of a part
minThickness = layers(2);

// The minimal width of a part
minWidth = shells(2);

// The ratios applied to the base unit value used to design the barrier holder
stripHeightRatio = 3;
stripIndentRatio = 0.5;

// The angle of a typical curve
curveAngle = 90;
