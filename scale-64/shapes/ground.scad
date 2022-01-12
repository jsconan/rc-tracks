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
 */
module straightGroundTile(length, width, thickness, barrierWidth, barrierHeight, barrierChunks) {
    barrierLength = length / barrierChunks;
    barrierPosition = width / 2 - barrierWidth;

    difference() {
        box([length, width, thickness], center=true);
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
}
