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
 * Defines the shapes for the straight ground tiles.
 *
 * @author jsconan
 */

/**
 * Draws the shape for a line of holes.
 * @param Number length - The length of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 */
module straightGroundHolesLine(length, thickness, barrierWidth, barrierHeight, barrierChunks) {
    barrierLength = length / barrierChunks;

    repeat(intervalX=barrierLength, count=barrierChunks, center=true) {
        barrierPegHole(
            width = barrierWidth,
            height = barrierHeight,
            thickness = thickness,
            distance = printTolerance
        );
    }
}

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
    barrierPosition = (width - barrierWidth) / 2;

    repeatRotate(count=2) {
        translateY(barrierPosition) {
            straightGroundHolesLine(
                length = length,
                thickness = thickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = barrierChunks
            );
        }
    }
}

/**
 * Draws the shape of the link hole for a ground tile.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 */
module barrierLinkGroundHole(width, height) {
    barrierLink(
        width = width,
        height = height,
        distance = printTolerance * 2,
        neckDistance = 0
    );
}

/**
 * Draws the shape of the link for a ground tile.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the link.
 */
module barrierLinkGround(width, height, thickness) {
    rotateZ(STRAIGHT) {
        linear_extrude(height=thickness, center=true, convexity=10) {
            barrierLinkProfile(
                width = width,
                height = height,
                distance = 0,
                neckDistance = printTolerance
            );
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
    overallLength = getStraightLength(length, ratio);
    overallChunks = getStraightBarrierChunks(barrierChunks, ratio);

    difference() {
        // Tile body
        box([overallLength, width, thickness], center=true);
        // Fastener holes
        straightGroundHoles(
            length = overallLength,
            width = width,
            thickness = thickness,
            barrierWidth = barrierWidth,
            barrierHeight = barrierHeight,
            barrierChunks = overallChunks
        );
        // Barrier link holes
        repeatRotate(count=2) {
            translate([overallLength, width - barrierWidth, -barrierHeight] / 2) {
                barrierLinkGroundHole(
                    width = barrierWidth,
                    height = barrierHeight
                );
            }
        }
    }
    // Barrier links
    repeatRotate(count=2) {
        translate([overallLength, barrierWidth - width, 0] / 2) {
            barrierLinkGround(
                width = barrierWidth,
                height = barrierHeight,
                thickness = thickness
            );
        }
    }
}

/**
 * Draws the shape of the decoration for a starting ground tile.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number startPositions - The number of parallel starting blocks.
 * @param Number startLines - The number of starting lines.
 */
module startingGroundTileDecoration(length, width, thickness, barrierWidth, barrierHeight, startPositions=3, startLines=2) {
    // Prepare the parameters
    laneWidth = getTrackLaneWidth(width, barrierWidth);
    finishLineWidth = laneWidth / 10;
    finishLineArea = finishLineWidth * 2;
    finishLinePosition = length / 2;
    startingArea = length - finishLineArea;
    startingBlockLength = laneWidth / (startPositions + 1);
    startingBlockWidth = laneWidth / 10;
    startingBlockThickness = getBarrierBaseUnit(barrierWidth, barrierHeight);
    startingBlockIntervalX = laneWidth / startPositions;
    startingBlockIntervalY = startingArea / startLines;
    startingBlockShift = startingBlockWidth;
    startingBlockPosition = length / 2 + startingArea - length;

    // Uncomment to debug:
    // %rectangle([length, width]);
    // %translateX((startingArea - length) / 2) rectangle([startingArea, laneWidth]);
    // %translateX((length - finishLineArea) / 2) rectangle([finishLineArea, laneWidth]);

    // Render the finish line
    translateX(finishLinePosition) {
        rotateZ(-RIGHT) {
            finishLine(
                length = laneWidth,
                width = finishLineWidth,
                height = thickness,
                lines = 2,
                distance = 0,
                center = true
            );
        }
    }

    // Render the starting blocks
    translateX(startingBlockPosition) {
        rotateZ(-RIGHT) {
            repeat(count=startLines, interval=yAxis3D(-startingBlockIntervalY), center=false) {
                translateY(-startingBlockShift * (floor(startPositions / 2) - (1 - startPositions % 2) * .5)) {
                    repeat(count=startPositions, interval=[startingBlockIntervalX, -startingBlockShift, 0], center=true) {
                        startingBlock(
                            length = startingBlockLength,
                            width = startingBlockWidth,
                            height = thickness,
                            thickness = startingBlockThickness,
                            distance = 0,
                            center = true
                        );
                    }
                }
            }
        }
    }
}
