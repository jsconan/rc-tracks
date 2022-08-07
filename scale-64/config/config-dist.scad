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
 * Local configuration for the project.
 *
 * @author jsconan
 */

// The dimensions and constraints of a track element
trackLaneWidth = 120;           // The width of the track lane (the distance between the barriers)
trackGroundThickness = .8;      // The thickness of a track tile (track ground)
barrierWidth = 6;               // The width of the barriers
barrierHeight = 8;              // The height of the barriers
barrierChunks = 4;              // The number of barrier chunks per section
fastenerDiameter = 2;           // The diameter of the fasteners that can be used for the barriers
fastenerHeadDiameter = 4;       // The diameter of the fasteners head
fastenerHeadHeight = 1;         // The height of the fasteners head
startLines = 2;                 // The number of starting lines
startPositions = 2;             // The number of starting positions on a same line
shiftStartPositions = false;    // Tells if the positions on a same starting line should be shifted

// Options for the ready to print models
printGroundUpsideDown = true;   // Flip the ground tiles to print them upside down
printQuantity = 1;              // Quantity of elements to print per set
showConfig = 0;                 // Show the config when rendering a model. The render script uses it to extract the config

// Colors applied to the elements when previewed.
// This will be used for the animations and other pictures, but this won't have effect on the ready to print elements.
colorGround = "#444";           // Color of the ground tiles
colorTile = "#468";             // Color of the full tiles
colorDecoration = "#eed";       // Color of the ground tiles decoration
colorPeg = "#aaa";              // Color of the barrier pegs
colorEven = "#eec";             // Color of the barriers, when placed at an even coordinate
colorOdd = "#c24";              // Color of the barriers, when placed at an odd coordinate

// Options for the animations
defaultScaleFrom = vector3D(.1);                // Origin scale factor for the models when animating
defaultScaleTo = vector3D(1);                   // Target scale factor for the models when animating
defaultRotateFrom = [-RIGHT, -RIGHT, RIGHT];    // Origin rotation angles for the models when animating
defaultRotateTo = vector3D(0);                  // Target rotation angles for the models when animating
defaultTranslateFrom = [-200, 150, 150];        // Origin position for the models when animating
defaultTranslateTo = ORIGIN_3D;                 // Target position for the models when animating
defaultPresentation = ORIGIN_3D;                // Position to present the models
defaultSlideTo = [200, 150, 150];               // Target position for the models when sliding
presentationSteps = 2;                          // Number of steps applied to present a model
animateSteps = 1;                               // Number of steps applied for one animation move
slideSteps = 1;                                 // Number of steps applied to slide a model
showSteps = 0;                                  // Show the expected number of steps for the whole animation
