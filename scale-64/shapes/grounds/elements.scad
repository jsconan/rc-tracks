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
 * Defines the ready to print shapes for the ground tiles.
 *
 * @author jsconan
 */

/**
 * A ground tile of a straight track section.
 * @param Number [ratio] - The size factor.
 */
module straightTrackSectionGround(ratio=1) {
    translateZ(trackGroundThickness / 2) {
        flipElement(printGroundUpsideDown) {
            straightGroundTile(
                length = trackSectionLength,
                width = trackSectionWidth,
                thickness = trackGroundThickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = barrierChunks,
                ratio = ratio
            );
        }
    }
}

/**
 * A ground tile of a starting track section.
 */
module startingTrackSectionGround() {
    translateZ(trackGroundThickness / 2) {
        straightGroundTile(
            length = trackSectionLength,
            width = trackSectionWidth,
            thickness = trackGroundThickness,
            barrierWidth = barrierWidth,
            barrierHeight = barrierHeight,
            barrierChunks = barrierChunks,
            ratio = 1
        );
        translateZ((trackGroundThickness + layerHeight) / 2) {
            startingGroundTileDecoration(
                length = trackSectionLength,
                width = trackSectionWidth,
                thickness = layerHeight,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                startPositions = 3,
                startLines = 2
            );
        }
    }
}

/**
 * A ground tile of a tight curved track section.
 * @param Number [ratio] - The size factor.
 */
module curvedTrackSectionGround(ratio=1) {
    translateZ(trackGroundThickness / 2) {
        flipElement(printGroundUpsideDown) {
            curvedGroundTile(
                length = trackSectionLength,
                width = trackSectionWidth,
                thickness = trackGroundThickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = barrierChunks,
                ratio = ratio
            );
        }
    }
}

/**
 * A ground tile of a tight curved track section with extra space.
 * @param Number [ratio] - The size factor.
 */
module enlargedCurveTrackSectionGround(ratio=1) {
    translateZ(trackGroundThickness / 2) {
        flipElement(printGroundUpsideDown) {
            enlargedCurveGroundTile(
                length = trackSectionLength,
                width = trackSectionWidth,
                thickness = trackGroundThickness,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                barrierChunks = barrierChunks,
                ratio = ratio
            );
        }
    }
}
