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
 * Defines the shapes for the straight full tiles.
 *
 * @author jsconan
 */

/**
 * Draws the shape of a straight full tile.
 * @param Number length - The length of a track section.
 * @param Number width - The width of a track section.
 * @param Number thickness - The thickness of the track ground.
 * @param Number barrierWidth - The width of the barrier.
 * @param Number barrierHeight - The height of the barrier.
 * @param Number barrierChunks - The number of barrier chunks per section.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [ratio] - The size factor.
 */
module straightTile(length, width, thickness, barrierWidth, barrierHeight, barrierChunks, diameter, headDiameter, headHeight, ratio=1) {
    overallLength = getStraightLength(length, ratio);
    overallChunks = getStraightBarrierChunks(barrierChunks, ratio);
    linkHeight = getBarrierLinkHeight(barrierWidth, barrierHeight);
    barrierPosition = (width - barrierWidth) / 2;
    barrierLength = length / barrierChunks;

    difference() {
        union() {
            // Tile body
            translateZ(-thickness) {
                box([overallLength, width, thickness], center=false);
            }
            // Barriers body
            translate([0, barrierWidth - width, barrierHeight] / 2) {
                repeat(count=2, intervalY=width - barrierWidth) {
                    straightBarrierBody(
                        length = overallLength,
                        width = barrierWidth,
                        height = barrierHeight
                    );
                }
            }
        }
        repeatRotate(count=2) {
            translateY(barrierPosition) {
                // Fastener holes
                repeat(intervalX=barrierLength, count=barrierChunks, center=true) {
                    tileHole(
                        width = barrierWidth,
                        height = barrierHeight,
                        thickness = thickness,
                        diameter = diameter,
                        headDiameter = headDiameter,
                        headHeight = headHeight,
                        distance = printTolerance
                    );
                }
                // Link holes
                translateX(overallLength / 2) {
                    tileLink(
                        width = barrierWidth,
                        height = linkHeight + layerHeight,
                        thickness = thickness + ALIGN,
                        distance = printTolerance,
                        neckDistance = 0
                    );
                }
            }
        }
    }
    // Links
    repeatRotate(count=2) {
        translate(-[overallLength, barrierWidth - width, 0] / 2) {
            tileLink(
                width = barrierWidth,
                height = linkHeight - layerHeight,
                thickness = thickness,
                distance = -printTolerance,
                neckDistance = printTolerance
            );
        }
    }
}
