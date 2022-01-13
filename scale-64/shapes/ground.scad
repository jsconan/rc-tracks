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
 * Defines the track ground parts.
 *
 * @author jsconan
 */

/**
 * Draws the shape of a straight ground tile.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 */
module straightGroundTile(length, width, thickness, barrierWidth, barrierHeight, barrierChunks, ratio=1) {
    barrierLength = length / barrierChunks;
    barrierPosition = width / 2 - barrierWidth;
    overallLength = length * ratio;
    overallChunks = barrierChunks * ratio;

    difference() {
        box([overallLength, width, thickness], center=true);
        repeatMirror(axis=[0, 1, 0]) {
            translateY(barrierPosition) {    
                repeat(intervalX=barrierLength, count=overallChunks, center=true) {
                    barrierPegHole(
                        width = barrierWidth,
                        height = barrierHeight,
                        thickness = thickness,
                        distance = printTolerance
                    );
                }
            }
        }
    }
}

/**
 * Draws the profile of a curved ground tile.
 *
 * To get the final shape, linear_extrude(height=height, convexity=10) must be applied.
 *
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number curveAngle - The angle of the curve.
 * @param Number [ratio] - The size factor.
 */
module curvedGroundTileProfile(length, width, curveAngle, ratio=1) {
    innerRadius = (length * ratio - width) / 2;
    outerRadius = width + innerRadius;
    startX = cos(curveAngle) * innerRadius;
    startY = sin(curveAngle) * innerRadius;
    polygon(path([
        ["P", startX, startY],
        ["C", innerRadius, curveAngle, 0],
        ["H", width],
        ["C", outerRadius, 0, curveAngle],
    ]), convexity = 10);
}

/**
 * Draws the shape of the holes for a curved ground tile.
 * @param Number radius - The radius of the curve at the position of the holes.
 * @param Number angle - The angle of the curve.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 */
module curvedGroundTileHoles(radius, angle, thickness, barrierWidth, barrierHeight, barrierChunks) {
    holeSectorAngle = angle * (barrierChunks - 1) / barrierChunks;
    rotateZ((angle - holeSectorAngle) / 2) {
        repeatRotate(angle=holeSectorAngle, count=barrierChunks) {
            translateX(radius) {    
                barrierPegHole(
                    width = barrierWidth,
                    height = barrierHeight,
                    thickness = thickness,
                    distance = printTolerance
                );
            }
        }
    }
}

/**
 * Draws the shape of a curved ground tile.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number [ratio] - The size factor.
 */
module curvedGroundTile(length, width, thickness, barrierWidth, barrierHeight, barrierChunks, ratio=1) {
    curveAngle = 90 / ratio;
    radius = length * ratio;
    innerRadius = (radius - width) / 2;
    outerRadius = width + innerRadius;
    barrierInnerPosition = innerRadius + barrierWidth;
    barrierOuterPosition = outerRadius - barrierWidth;
    innerBarrierChunks = min(ratio, barrierChunks);
    outerBarrierChunks = barrierChunks;

    translate([-radius, -length, 0] / 2) {
        difference() {
            linear_extrude(height=thickness, center=true, convexity=10) {
                curvedGroundTileProfile(
                    length = length,
                    width = width,
                    curveAngle = curveAngle,
                    ratio = ratio
                );
            }

            curvedGroundTileHoles(
                radius = barrierInnerPosition,
                angle = curveAngle,
                thickness = thickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = innerBarrierChunks
            );

            curvedGroundTileHoles(
                radius = barrierOuterPosition,
                angle = curveAngle,
                thickness = thickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = outerBarrierChunks
            );
        }
    }
}
