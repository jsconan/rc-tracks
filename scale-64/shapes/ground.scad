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
 * Draws the shape of the holes for a straight ground.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 */
module straightGroundHoles(length, width, thickness, barrierWidth, barrierHeight, barrierChunks) {
    barrierLength = length / barrierChunks;
    barrierPosition = (width - barrierWidth) / 2;
    
    repeatMirror(axis=[0, 1, 0]) {
        translateY(barrierPosition) {    
            repeat(intervalX=barrierLength, count=barrierChunks, center=true) {
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
    overallLength = length * ratio;
    overallChunks = getStraightBarrierChunks(barrierChunks, ratio);

    difference() {
        box([overallLength, width, thickness], center=true);
        straightGroundHoles(
            length = overallLength,
            width = width,
            thickness = thickness,
            barrierWidth = barrierWidth,
            barrierHeight = barrierHeight,
            barrierChunks = overallChunks
        );
    }
}

/**
 * Draws the shape of a curved ground.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number angle - The angle of the curve.
 * @param Number [ratio] - The size factor.
 */
module curvedGround(length, width, thickness, angle, ratio=1) {
    linear_extrude(height=thickness, center=true, convexity=10) {
        curvedGroundProfile(
            length = length,
            width = width,
            angle = angle,
            ratio = ratio
        );
    }
}

/**
 * Draws the shape of the holes for a curved ground.
 * @param Number radius - The radius of the curve at the position of the holes.
 * @param Number angle - The angle of the curve.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 */
module curvedGroundHoles(radius, angle, thickness, barrierWidth, barrierHeight, barrierChunks) {
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
    radius = length * ratio;
    angle = getCurveAngle(ratio);
    barrierInnerPosition = getCurveInnerRadius(length=length, width=width, ratio=ratio) + barrierWidth / 2;
    barrierOuterPosition = getCurveOuterRadius(length=length, width=width, ratio=ratio) - barrierWidth / 2;
    innerBarrierChunks = getCurvedInnerBarrierChunks(barrierChunks, ratio);
    outerBarrierChunks = getCurvedOuterBarrierChunks(barrierChunks, ratio);

    translate([-radius, -length, 0] / 2) {
        difference() {
            curvedGround(
                length = length,
                width = width,
                thickness = thickness,
                angle = angle,
                ratio = ratio
            );
            curvedGroundHoles(
                radius = barrierInnerPosition,
                angle = angle,
                thickness = thickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = innerBarrierChunks
            );
            curvedGroundHoles(
                radius = barrierOuterPosition,
                angle = angle,
                thickness = thickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = outerBarrierChunks
            );
        }
    }
}
