/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/things.
 *
 * jsconan/things is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/things is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/things. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A race track system for 1/24 to 1/32 scale RC cars.
 *
 * Configures the project.
 *
 * @author jsconan
 * @version 0.2.0
 */

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints of the printer.
printResolution = 0.2;  // The target layer height
nozzleWidth = 0.4;      // The size of the print nozzle
printTolerance = 0.1;   // The print tolerance when pieces need to be assembled

// The dimensions and constraints of a track element
trackSectionSize = 200;     // The nominal size of a track element: the length for straight element, or the radius for a curved element
trackWidth = 400;           // The width of track lane, i.e. the distance between the barriers
barrierHeight = 30;         // The height of the barrier, including the holders
barrierHolderBase = 2;      // The base unit value used to design the barrier holder
barrierBodyThickness = 0.6; // The thickness of the barrier body
archTowerThickness = 1.6;   // The thickness of the arch tower wall
wireClipThickness = .8;     // The thickness of the wire clips wall
wireClipWidth = 2;          // The thickness of the wire clips
sampleSize = 20;            // The size for the sample track elements
