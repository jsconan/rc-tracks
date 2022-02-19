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
 * Defines the profiles for the ground tiles.
 *
 * @author jsconan
 */

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
module barrierPegHoleProfile(width, height, thickness, distance=0) {
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

/**
 * Draws the profile of an enlarged curve ground tile.
 *
 * To get the final shape, linear_extrude(height=height, convexity=10) must be applied.
 *
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number [ratio] - The size factor.
 */
module enlargedCurveGroundProfile(length, width, ratio=1) {
    innerRadius = getEnlargedCurveInnerRadius(length=length, width=width, ratio=ratio);
    outerRadius = getEnlargedCurveOuterRadius(length=length, width=width, ratio=ratio);
    side = getEnlargedCurveSide(length=length, width=width, ratio=ratio);
    angle = CURVE_ANGLE;
    startX = cos(angle) * innerRadius;
    startY = sin(angle) * innerRadius;

    polygon(path([
        ["P", startX, startY],
        ["C", innerRadius, angle, 0],
        ["H", width],
        ["V", side],
        ["C", outerRadius, 0, angle],
        ["H", -side],
    ]), convexity = 10);
}

/**
 * Draws the profile of a starting block.
 *
 * To get the final shape, linear_extrude(height=height, convexity=10) must be applied.
 *
 * @param Number length - The length of the block.
 * @param Number width - The width of the block.
 * @param Number thickness - The thickness of the outline.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module startingBlockProfile(length, width, thickness, distance=0) {
    // Uncomment to debug:
    // %translateY(thickness - width / 2) rectangle([length, width]);

    // Prepare the parameters for the polygon
    innerLength = length - thickness * 2;
    innerWidth = width - thickness;

    // Draw the profile
    polygon(path([
        ["P", length / 2, 0],
        ["H", -length],
        ["V", -width],
        ["H", thickness],
        ["V", innerWidth],
        ["H", innerLength],
        ["V", -innerWidth],
        ["H", thickness],
    ]), convexity = 10);
}

/**
 * Draws the profile of finish line.
 *
 * To get the final shape, linear_extrude(height=height, convexity=10) must be applied.
 *
 * @param Number length - The length of the line.
 * @param Number width - The width of the line.
 * @param Number lines - The number of lines inside the pattern.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module finishLineProfile(length, width, lines=2, distance=0) {
    // Uncomment to debug:
    // %translateY(-width / 2) rectangle([length, width]);

    // Prepare the parameters for the polygon
    lines = max(2, lines);
    tileWidth = width / lines;
    cols = floor(length / tileWidth);
    tileLength = length / cols;

    // Draw the profile
    translateY(-width / 2) {
        repeatAlternate2D(countX=cols, countY=lines, intervalX=xAxis3D(tileLength), intervalY=yAxis3D(tileWidth), center=true) {
            rectangle([tileLength + ALIGN, tileWidth + ALIGN]);
        }
    }
}
