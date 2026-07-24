# Pinball Project Overview

## Project Structure

```
Pinball/
├── .gitattributes
├── .gitignore
├── .godot/
│   └── (Godot editor configuration)
├── .vscode/
│   └── (VS Code workspace settings)
├── Blender/
│   └── (Blender asset files)
├── icon.svg
├── icon.svg.import
├── il_1140xN.3624299077_gh0m - копія.png
├── il_1140xN.3624299077_gh0m - копія.png.import
├── Pinball.code-workspace
├── project.godot          # Main Godot project configuration
├── Scenes/
│   ├── Checkpoint.tscn    # Checkpoint scene definition
│   ├── Game2.tscn         # Main game scene
│   ├── Game2.tscn1242583906.tmp
│   ├── Hole.tscn          # Hole scene definition
│   ├── Main.tscn          # Original main scene
│   ├── Route_Main.tscn    # Main route with checkpoints
│   ├── Route_Small_1.tscn
│   └── Route_Small_2.tscn
└── Scripts/
    ├── Ball.gd            # Ball physics and movement
    ├── Ball.gd.uid
    ├── Carousel.gd        # Carousel obstacle rotation
    ├── Carousel.gd.uid
    ├── Checkpoint.gd      # Checkpoint behavior and types
    ├── Checkpoint.gd.uid
    ├── Hole.gd            # Hole trigger and points system
    ├── Hole.gd.uid
    ├── Marker.gd          # Marker movement along route
    ├── Marker.gd.uid
    ├── Game.gd            # Player management system
    ├── Game.gd.uid
    ├── Route.gd           # Route management
    └── Route.gd.uid
```

## Project Configuration

**Engine:** Godot 4.6 (Mobile features enabled)
**Main Scene:** `res://Scenes/Game2.tscn`
**Rendering Method:** Mobile
**Physics Engine:** GodotPhysics3D

## Core Components

### 1. Ball (Ball.gd)
- **Type:** `RigidBody3D`
- **Purpose:** Main gameplay ball with physics
- **Controls:** Space key applies impulse in `shootDir` direction
- **Current Direction:** Vector3(-1, 0, 0) - shoots left
- **Physics:** Uses `apply_central_impulse()` in `_integrate_forces()`

### 2. Carousel (Carousel.gd)
- **Type:** `RigidBody3D`
- **Purpose:** Rotating obstacle
- **Controls:**
  - LEFT key: Apply torque impulse (spin counter-clockwise)
  - RIGHT key: Apply torque impulse (spin clockwise)
- **Shoot Direction:** Vector3(-7, 0, 0)

### 3. Checkpoint (Checkpoint.gd)
- **Type:** `Node3D` (with `@tool` attribute for editor visibility)
- **Class Name:** `Checkpoint` (registered as global class)
- **Properties:**
  - `index: int` - Checkpoint number (displayed on Label3D)
  - `type: enum` - Visual type (DEFAULT=0, BIG=1, BLUE=2)
  - `skip_turn: bool` - Special checkpoint that skips turn
- **Visuals:** Three mesh variants (MeshInstance3D, MeshInstance3D2, MeshInstance3D3) for different types
- **Behavior:** Updates mesh visibility based on type

### 4. Hole (Hole.gd)
- **Type:** `Node3D` (with `@tool` attribute)
- **Class Name:** `Hole` (registered as global class)
- **Signals:** `hole_triggered(points: int)` - Emitted when ball enters
- **Properties:**
  - `points: int` - Points awarded when ball enters (displayed on Label3D)
- **Detection:** Uses `body_entered` signal to detect ball collision
- **Target:** Looks for body with name "RigidBody3D_Ball"

### 5. Marker (Marker.gd)
- **Type:** `RigidBody3D`
- **Purpose:** Visual marker that moves along the route
- **Properties:**
  - `route: Route` - Reference to the route to follow
  - `currentCheckpoint: int` - Current position in route
- **Behavior:**
  - Connects to all Hole `hole_triggered` signals
  - Moves to checkpoints based on points earned
  - Uses tweening for smooth movement between checkpoints
  - Checks for `skip_turn` checkpoints
- **Movement:** Uses `create_tween()` to animate position changes

### 6. Route (Route.gd)
- **Type:** `Node3D`
- **Class Name:** `Route` (registered as global class)
- **Methods:**
  - `getCheckpointByIndex(index: int) -> Node3D` - Returns checkpoint at specified index
- **Structure:** Contains a `Checkpoints` child node with checkpoint instances

### 7. Game (Game.gd)
- **Type:** `Node3D`
- **Purpose:** Player management system with UI and 3D markers
- **Variables:**
  - `players: Array` - List of player names (starts with "First")
  - `player_panels: Array` - References to HBoxContainer_Player UI elements
  - `player_markers: Array` - References to 3D Marker instances
  - `colors: Array` - Color palette for player identification (Red, Yellow, Green, Blue, Purple)
- **UI Management:**
  - Creates HBoxContainer_Player panels for each player with ColorRect, Button_Add, and Button_Remove
  - Panels are vertically stacked with 40px spacing
  - Each ColorRect is colored based on player index from the colors array
- **Marker Management:**
  - Duplicates the base Marker (RigidBody3D) for each new player
  - Assigns material color to each Marker's MeshInstance3D matching its ColorRect
  - Removes markers when players are removed
- **Controls:**
  - Button_Add: Adds new player with panel and marker
  - Button_Remove: Removes last player, panel, and marker (minimum 1 player)

## Scene Hierarchy

### Main.tscn
- Root Node3D
  - box (Node3D)
    - StaticBody3D0-4 (Walls and floor)
    - Obstacle1-3 (Static obstacles)
  - RigidBody3D (Ball)
    - MeshInstance3D (Sphere)
    - CollisionShape3D (Sphere)
  - Camera3D
  - DirectionalLight3D

### Game2.tscn (Current Main Scene)
- Root Node3D
  - RigidBody3D (Ball with Ball.gd)
  - RigidBody3D (Carousel with Carousel.gd)
  - Hole instances
  - Route_Main (Route with checkpoints)
  - Route_Small_1
  - Route_Small_2
  - Marker (with Marker.gd)
  - Various mesh and collision components

### Checkpoint.tscn
- Node3D (with Checkpoint.gd)
  - MeshInstance3D (DEFAULT type - red cylinder)
  - MeshInstance3D2 (BIG type - larger cylinder, hidden by default)
  - MeshInstance3D3 (BLUE type - blue cylinder, hidden by default)
  - Label3D (displays index number)

### Hole.tscn
- Node3D (with Hole.gd)
  - StaticBody3D
    - StaticBody3D2
      - Label3D (displays points value)
  - MeshInstance3D (hole visual)
  - CollisionShape3D (ConcavePolygonShape3D)

### Route_Main.tscn
- Node3D (with Route.gd)
  - Checkpoints (Node3D)
    - Checkpoint1-100+ (Checkpoint instances with configured indices and types)
  - CSGPolygon3D (visual path representation)
  - Path3D (with Curve3D for path definition)
  - Sprite3D (decorative element)

## Game Mechanics

### Checkpoint System
1. Checkpoints are arranged along routes
2. Each checkpoint has an index (1, 2, 3, ...)
3. Special checkpoints have types (BIG, BLUE) and may have `skip_turn` enabled
4. Checkpoint 11, 38, 59, 72, 83, 100 have `skip_turn = true`
5. Checkpoint 11, 26, 38, 59, 63, 72, 80, 83, 100 have `type = BIG` (type 1)

### Hole System
1. Holes have point values
2. When ball enters a hole, `hole_triggered` signal is emitted with point value
3. Marker listens to all hole signals and moves accordingly
4. Points determine how many checkpoints the marker advances

### Marker Movement
1. Marker starts at checkpoint 1
2. When hole is triggered, marker tweens to checkpoint at `currentCheckpoint + points`
3. Movement is animated with 0.4 second duration per checkpoint
4. After movement completes, checks if current checkpoint has `skip_turn`

### Player Management
1. Each player has a UI panel (HBoxContainer_Player) and a 3D marker
2. Players are identified by color (Red, Yellow, Green, Blue, Purple)
3. Button_Add adds new player with panel and marker
4. Button_Remove removes last player, panel, and marker (minimum 1 player)
5. Player markers maintain index correspondence with player arrays
6. Each player's marker material color matches their UI panel ColorRect

## Recent Development (Git History)

```
3fd8c0c - Draft implementation of skip turn checkpoint
7cf7a03 - Draft implementation of skip turn checkpoint  
968bcee - Implemented marker movement when ball falls into the hole
a525409 - Draft implementation of marker movement alongside the path
ba76df1 - Draft implementation of path and checkpoints
```

## Latest Changes (Uncommitted)

### Player Management System (Game.gd)
- Added multi-player support with dynamic UI panel creation
- Each player gets a colored HBoxContainer_Player panel with ColorRect
- Each player gets a 3D Marker instance with matching color material
- Button_Add creates new player, panel, and marker
- Button_Remove removes last player, panel, and marker (minimum 1)
- Color cycling: Red, Yellow, Green, Blue, Purple for player identification
- Markers maintain index correspondence with player arrays

## Key Features in Development

1. **Skip Turn Checkpoints:** Special checkpoints that trigger skip turn logic
2. **Marker Animation:** Smooth tween-based movement along predefined paths
3. **Point System:** Holes award points that advance the marker
4. **Multiple Route Types:** Main route and small routes for different gameplay sections
5. **Checkpoint Types:** Visual differentiation with different mesh types

## Technical Patterns

### Scripting Patterns
- Use of `@tool` for editor-visible scripts
- Class name registration for reusable components
- Signal-based communication between components
- Property setters with side effects (e.g., updating labels)

### Scene Organization
- Modular scene design (Checkpoint, Hole as separate scenes)
- Hierarchical node structure
- Use of Node3D for positioning
- Physics bodies for collision detection

### Physics
- RigidBody3D for dynamic objects (Ball, Carousel, Marker)
- StaticBody3D for static obstacles
- CollisionShape3D with various shapes (Sphere, ConcavePolygon, etc.)
- Physics material overrides for custom friction/bounce

## Dependencies

- **Godot Engine:** 4.6
- **Features:** Mobile, PackedStringArray support
- **Rendering:** Mobile rendering method
- **Physics:** GodotPhysics3D

## File References

- **Main Entry:** `project.godot` → `run/main_scene="uid://cct1xvewwiifm"` (Game2.tscn)
- **Icon:** `res://icon.svg`
- **Window Size:** 1600x900

## Current State

The project appears to be a pinball-style game with:
- A ball that can be shot with SPACE key
- A carousel obstacle controlled with LEFT/RIGHT keys
- A checkpoint system with 100+ checkpoints
- A hole system that triggers marker advancement
- A marker that moves along checkpoints based on points earned
- Special checkpoints that can skip turns

The development is focused on the marker movement system and checkpoint interactions.
