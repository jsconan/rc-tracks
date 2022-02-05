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
 * Ready to print track parts: a set of female barrier chunks for an enlarged curved track section.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {

    ratio = 1;
    innerCurveLength = getCurvedBarrierFemaleLength(
        getCurveInnerBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio),
        getCurveAngle(ratio) / getCurveInnerBarrierChunks(barrierChunks, ratio),
        barrierWidth, barrierHeight
    );
    outerCurveLength = getCurvedBarrierFemaleLength(
        getEnlargedCurveOuterBarrierPosition(trackSectionLength, trackSectionWidth, barrierWidth, ratio),
        getCurveAngle(ratio) / getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio),
        barrierWidth, barrierHeight
    );
    straightLength = getStraightBarrierFemaleLength(barrierLength, barrierWidth, barrierHeight);

    innerCurveChunks = getEnlargedCurveInnerBarrierChunks(barrierChunks, ratio) / 2 * printQuantity;
    outerCurveChunks = getEnlargedCurveOuterBarrierChunks(barrierChunks, ratio) / 2 * printQuantity;
    straightChunks = getEnlargedCurveSideBarrierChunks(barrierChunks, ratio) * printQuantity;

    innerCurveInterval = getGridWidth(innerCurveLength, barrierWidth, quantity=innerCurveChunks, line=printQuantity);
    outerCurveInterval = getGridWidth(outerCurveLength, barrierWidth, quantity=outerCurveChunks, line=printQuantity);
    straightInterval = getGridWidth(straightLength, barrierWidth, quantity=straightChunks, line=printQuantity);

    // Draws the ready to print model
    translateY((straightInterval + outerCurveInterval) / 2) {
        straightBarrierFemaleSet(quantity=straightChunks, line=printQuantity);
    }
    enlargedCurveBarrierFemaleSet(ratio=ratio, quantity=outerCurveChunks, line=printQuantity);
    translateY(-(innerCurveInterval + outerCurveInterval) / 2) {
        innerCurveBarrierFemaleSet(ratio=ratio, quantity=innerCurveChunks, line=printQuantity);
    }

}
