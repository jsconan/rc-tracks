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
 * Defines the profile shapes for the track elements.
 *
 * @author jsconan
 */

/**
 * Draws the profile of a barrier link.
 *
 * To get the final shape, linear_extrude(height=height, convexity=10) must be applied.
 *
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierLinkProfile(width, height, distance = 0) {
    base = getBarrierBaseUnit(width, height);
    neckAlign = abs(distance);
    
    translateX(neckAlign) {
        linkProfile(
            neck = [base / 2 + neckAlign, base],
            bulb = base,
            distance = distance
        );
    }
}

/**
 * Draws the profile of a barrier peg.
 *
 * To get the final shape, rotate_extrude(angle=360, convexity=10) must be applied.
 *
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fastener.
 * @param Number thickness - The thickness of the track ground.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierPegProfile(width, height, diameter, thickness, distance = 0) {
    // Prepare the parameters for the polygon
    pegDiameter = getBarrierPegDiameter(width, height);
    pegHeight = getBarrierPegHeight(width, height, thickness);
    radius = diameter / 2 + distance;
    pegRadius = pegDiameter / 2 + distance;
    pegFootRadius = pegRadius + thickness;
    remainingRadius = pegRadius - radius;
    remainingFootRadius = pegFootRadius - radius;
    remainingHeight = pegHeight - remainingRadius - thickness;

    // Uncomment to debug:
    // %rectangle([pegDiameter, pegHeight]);

    // Draw the profile
    polygon(path([
        ["P", radius, pegHeight / 2],
        ["V", -pegHeight],
        ["H", remainingFootRadius],
        ["L", -thickness, thickness],
        ["V", remainingHeight],
    ]), convexity = 10);
}

/**
 * Draws the profile of a peg hole for the track ground.
 *
 * To get the final shape, rotate_extrude(angle=360, convexity=10) must be applied.
 *
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the track ground.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierPegHoleProfile(width, height, thickness, distance = 0) {
    // Prepare the parameters for the polygon
    pegDiameter = getBarrierPegDiameter(width, height);
    pegRadius = pegDiameter / 2 + distance;
    pegFootRadius = pegRadius + thickness;
    alignedHeight = thickness + ALIGN2;

    // Uncomment to debug:
    // %rectangle([pegFootRadius * 2, thickness]);

    // Draw the profile
    polygon(path([
        ["P", 0, alignedHeight / 2],
        ["V", -alignedHeight],
        ["H", pegFootRadius],
        ["V", ALIGN],
        ["L", -thickness, thickness],
        ["V", ALIGN],
    ]), convexity = 10);
}

/**
 * Draws the profile of a barrier fastening hole.
 *
 * To get the final shape, rotate_extrude(angle=360, convexity=10) must be applied.
 *
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fastener.
 * @param Number headDiameter - The diameter of the fastener head.
 * @param Number headHeight - The height of the fastener head.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierFastenerHoleProfile(width, height, diameter, headDiameter, headHeight, distance = 0) {
    // Uncomment to debug:
    // %rectangle([headDiameter + distance * 2, height]);

    // Prepare the parameters for the polygon
    alignedHeight = height + ALIGN2;
    headRadius = max(headDiameter, diameter) / 2 + distance;
    radius = diameter / 2 + distance;
    pegRadius = getBarrierPegDiameter(width, height) / 2 + distance;
    pegHeight = getBarrierPegInnerHeight(width, height) + layerHeight + ALIGN;
    remainingRadius = pegRadius - radius;
    remainingPegHeight = pegHeight - remainingRadius;
    remainingHeight = alignedHeight - headHeight - pegHeight;
    remainingWidth = headRadius - radius;

    // Draw the profile
    polygon(path([
        ["P", 0, alignedHeight / 2],
        ["V", -alignedHeight],
        ["H", pegRadius],
        ["V", remainingPegHeight],
        ["L", -remainingRadius, remainingRadius],
        ["V", remainingHeight],
        ["H", remainingWidth],
        ["V", headHeight],
    ]), convexity = 10);
}

/**
 * Draws the profile of a barrier.
 *
 * To get the final shape, linear_extrude(height=length, convexity=10) must be applied.
 *
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierProfile(width, height, distance = 0) {
    // Uncomment to debug:
    // %rectangle(vadd([width, height], distance * 2));

    // Compute the base values
    baseUnit = getBarrierBaseUnit(width, height);
    barrierOffset = getBarrierOffset(width, height);

    // Prepare the parameters for the polygon
    barrierTopWidth = width - barrierOffset * 2;
    barrierSlopeWidth = barrierOffset;
    barrierSlopeHeight = baseUnit - barrierOffset;
    barrierOuterSide = baseUnit / 2;
    barrierInnerSide = height - (barrierSlopeHeight + barrierOuterSide + barrierOffset * 2) * 2;

    // Draw the profile
    polygon(outline(path([
        // top left
        ["P", -barrierTopWidth / 2, height / 2],
        ["L", -barrierOffset, -barrierOffset],
        ["V", -barrierOuterSide],
        ["L", barrierSlopeWidth, -barrierSlopeHeight],        
        ["L", barrierOffset, -barrierOffset],
        // middle left
        ["V", -barrierInnerSide],
        // bottom left
        ["L", -barrierOffset, -barrierOffset],
        ["L", -barrierSlopeWidth, -barrierSlopeHeight],        
        ["V", -barrierOuterSide],
        ["L", barrierOffset, -barrierOffset],
        // bottom
        ["H", barrierTopWidth],
        // bottom right
        ["L", barrierOffset, barrierOffset],
        ["V", barrierOuterSide],
        ["L", -barrierSlopeWidth, barrierSlopeHeight],
        ["L", -barrierOffset, barrierOffset],
        // middle right
        ["V", barrierInnerSide],
        // top right
        ["L", barrierOffset, barrierOffset],
        ["L", barrierSlopeWidth, barrierSlopeHeight],
        ["V", barrierOuterSide],
        ["L", -barrierOffset, barrierOffset],
    ]), distance), convexity = 10);
}

/**
 * Draws the profile of a curved ground tile.
 *
 * To get the final shape, linear_extrude(height=height, convexity=10) must be applied.
 *
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number angle - The angle of the curve.
 * @param Number [ratio] - The size factor.
 */
module curvedGroundProfile(length, width, angle, ratio=1) {
    innerRadius = getCurveInnerRadius(length=length, width=width, ratio=ratio);
    outerRadius = getCurveOuterRadius(length=length, width=width, ratio=ratio);
    startX = cos(angle) * innerRadius;
    startY = sin(angle) * innerRadius;

    polygon(path([
        ["P", startX, startY],
        ["C", innerRadius, angle, 0],
        ["H", width],
        ["C", outerRadius, 0, angle],
    ]), convexity = 10);
}
