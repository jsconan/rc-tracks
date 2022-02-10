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
 * Defines the fragments shapes for the track elements.
 *
 * @author jsconan
 */

/**
 * Draws the shape of a barrier link.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number [distance] - An additional distance added to the outline of the shape.
 * @param Number [neckDistance] - An additional distance added to the neck of the link.
 * @param Boolean [center] - The shape is centered vertically.
 */
module barrierLink(width, height, distance=0, neckDistance=0, center=false) {
    linear_extrude(height=height, center=center, convexity=10) {
        barrierLinkProfile(
            width = width,
            height = height,
            distance = distance,
            neckDistance = neckDistance
        );
    }
}

/**
 * Draws the shape of a barrier peg.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fastener.
 * @param Number thickness - The thickness of the track ground.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierPeg(width, height, diameter, thickness, distance=0) {
    rotate_extrude(angle=DEGREES, convexity=10) {
        barrierPegProfile(
            width = width,
            height = height,
            diameter = diameter,
            thickness = thickness,
            distance = distance
        );
    }
}

/**
 * Draws the shape of a peg hole for the track ground.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the track ground.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierPegHole(width, height, thickness, distance=0) {
    rotate_extrude(angle=DEGREES, convexity=10) {
        barrierPegHoleProfile(
            width = width,
            height = height,
            thickness = thickness,
            distance = distance
        );
    }
}

/**
 * Draws the shape of a barrier fastening hole.
 * @param Number width - The width of the barrier.
 * @param Number height - The height of the barrier.
 * @param Number diameter - The diameter of the fasteners.
 * @param Number headDiameter - The diameter of the fasteners head.
 * @param Number headHeight - The height of the fasteners head.
 * @param Number [distance] - An additional distance added to the outline of the shape.
 */
module barrierFastenerHole(width, height, diameter, headDiameter, headHeight, distance=0) {
    rotate_extrude(angle=DEGREES, convexity=10) {
        barrierFastenerHoleProfile(
            width = width,
            height = height,
            diameter = diameter,
            headDiameter = headDiameter,
            headHeight = headHeight,
            distance = distance
        );
    }
}

/**
 * Draws the shape of a starting block.
 * @param Number length - The length of the block.
 * @param Number width - The width of the block.
 * @param Number height - The height of the block.
 * @param Number thickness - The thickness of the outline.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 * @param Boolean [center] - The shape is centered vertically.
 */
module startingBlock(length, width, height, thickness, distance=0, center=false) {
    linear_extrude(height=height, center=center, convexity=10) {
        startingBlockProfile(
            length = length,
            width = width,
            thickness = thickness,
            distance = distance
        );
    }
}

/**
 * Draws the shape of finish line.
 * @param Number length - The length of the line.
 * @param Number width - The width of the line.
 * @param Number height - The height of the line.
 * @param Number lines - The number of lines inside the pattern.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 * @param Boolean [center] - The shape is centered vertically.
 */
module finishLine(length, width, height, lines=2, distance=0, center=false) {
    linear_extrude(height=height, center=center, convexity=10) {
        finishLineProfile(
            length = length,
            width = width,
            lines = lines,
            distance = distance
        );
    }
}
