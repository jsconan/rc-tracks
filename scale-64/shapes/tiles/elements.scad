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
 * Defines the ready to print shapes for the full tiles.
 *
 * @author jsconan
 */

/**
 * A full tile of a straight track section.
 * @param Number [ratio] - The size factor.
 */
module straightTrackTile(ratio=1) {
    translateZ(trackGroundThickness / 2) {
        straightTile(
            length = trackSectionLength,
            width = trackSectionWidth,
            thickness = trackGroundThickness,
            barrierWidth = barrierWidth,
            barrierHeight = barrierHeight,
            barrierChunks = barrierChunks,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight,
            ratio = ratio
        );
    }
}

/**
 * A full tile of a starting track section.
 */
module startingTrackTile() {
    translateZ(trackGroundThickness / 2) {
        straightTile(
            length = trackSectionLength,
            width = trackSectionWidth,
            thickness = trackGroundThickness,
            barrierWidth = barrierWidth,
            barrierHeight = barrierHeight,
            barrierChunks = barrierChunks,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight,
            ratio = 1
        );
        translateZ(layerHeight / 2) {
            startingGroundTileDecoration(
                length = trackSectionLength,
                width = trackSectionWidth,
                thickness = layerHeight,
                barrierWidth = barrierWidth,
                barrierHeight = barrierHeight,
                startPositions = startPositions,
                startLines = startLines,
                shiftPositions = shiftStartPositions
            );
        }
    }
}

/**
 * A full tile of a curved track section.
 * @param Number [ratio] - The size factor.
 */
module curvedTrackTile(ratio=1) {
    translateZ(trackGroundThickness / 2) {
        curvedTile(
            length = trackSectionLength,
            width = trackSectionWidth,
            thickness = trackGroundThickness,
            barrierWidth = barrierWidth,
            barrierHeight = barrierHeight,
            barrierChunks = barrierChunks,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight,
            ratio = ratio
        );
    }
}

/**
 * A full tile of a curved track section with extra space.
 * @param Number [ratio] - The size factor.
 */
module enlargedCurveTrackTile(ratio=1) {
    translateZ(trackGroundThickness / 2) {
        enlargedCurveTile(
            length = trackSectionLength,
            width = trackSectionWidth,
            thickness = trackGroundThickness,
            barrierWidth = barrierWidth,
            barrierHeight = barrierHeight,
            barrierChunks = barrierChunks,
            diameter = fastenerDiameter,
            headDiameter = fastenerHeadDiameter,
            headHeight = fastenerHeadHeight,
            ratio = ratio
        );
    }
}
