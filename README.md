# Local KMZ Map Viewer 021.3 — Updated Drive Endpoint

Static GitHub Pages build for:

```text
reydleon/myTest002.github.io
```

Expected public address:

```text
https://reydleon.github.io/myTest002.github.io/
```

## Repository structure

```text
myTest002.github.io/
├── index.html
├── 404.html
├── .nojekyll
├── README.md
└── LICENSE
```

No Node.js server is required. GitHub Pages serves the application directly.

## Publish using the GitHub website

1. Open the repository:

   ```text
   reydleon/myTest002.github.io
   ```

2. Delete or replace the existing repository files.

3. Upload these files to the repository root:

   ```text
   index.html
   404.html
   .nojekyll
   README.md
   LICENSE
   ```

4. Commit the files to the `main` branch.

5. Open:

   ```text
   Settings → Pages
   ```

6. Under **Build and deployment**, select:

   ```text
   Source: Deploy from a branch
   Branch: main
   Folder: / (root)
   ```

7. Save and wait for GitHub Pages to publish.

## Publish using Git

From inside this project folder:

```bash
git init
git branch -M main
git remote add origin https://github.com/reydleon/myTest002.github.io.git
git add .
git commit -m "Publish Local KMZ Map Viewer 013"
git push -u origin main
```

When replacing an existing repository, clone it first or use the existing local repository folder:

```bash
git clone https://github.com/reydleon/myTest002.github.io.git
cd myTest002.github.io
```

Copy the Version 013 files into that folder, then run:

```bash
git add .
git commit -m "Publish Local KMZ Map Viewer 013"
git push
```

## Included features

- KMZ and KML upload in the browser
- Google My Maps-style layer panel
- Layers collapsed by default
- Expand all and collapse all controls
- Automatic uniform, individual, and attribute-based styling
- Numeric and category legends
- Selectable label fields
- Hybrid satellite imagery with street names
- Satellite, streets, OpenStreetMap, topographic, light, and dark basemaps
- Search
- Feature popups
- SharePoint, Google Drive, PDF, and website links
- Drawing and measurement tools
- GeoJSON export
- Coordinate display
- Construction-status legend
- Browser-local settings persistence

## Important behavior

KMZ/KML files are processed inside the user's browser. They are not uploaded to GitHub or to a backend server.

The application currently requires internet access for:

- OpenLayers and JSZip loaded from public CDNs
- Online basemap tiles
- Online SharePoint, Google Drive, and document links

## GitHub Pages limitations

GitHub Pages does not run:

- `server.js`
- Express
- Node.js backend code
- Server-side file-system access

This Version 013 is intentionally static and GitHub Pages compatible.


## Version 014 mobile improvements

- Full-screen map on Chrome for Android.
- Layers panel changed to a bottom drawer.
- Floating **Layers** button opens the drawer.
- Close button and Escape-key support.
- Search bar sized for phone screens.
- Horizontally scrollable mapping toolbar.
- Larger 40–44 px touch targets.
- Mobile-safe basemap and legend placement.
- Mobile popups and dialogs constrained to the viewport.
- Safe-area support for modern phones.
- Uses dynamic viewport height (`dvh`) to avoid browser toolbar sizing problems.


## Version 015 fixed preload

The eight bundled KMZ files are fetched from the GitHub Pages repository when
the page starts. Each response is converted to a browser `File` object and
passed directly to the viewer's existing `loadFile()` function.

Bundled directory:

```text
kmz/20260718A/
```

Startup behavior:

1. Fetch each KMZ sequentially.
2. Display loading progress in the status area.
3. Parse each KMZ through JSZip and OpenLayers.
4. Add each layer to the sidebar.
5. Fit the map to all loaded layers.
6. Report any individual file failures.


## Version 016 large-layer fix

The `003-supertable_rev0050masterk100.kmz` file is valid and contains 1,416
point features. Earlier versions could overload mobile Chrome by producing a
large categorized legend and drawing a permanent text label for every point.

Version 016:

- Uses uniform styling for high-cardinality datasets.
- Limits automatic category styling to manageable legends.
- Suppresses permanent labels when a layer contains more than 500 features.
- Keeps the feature name and attributes available when a point is selected.
- Caches OpenLayers style objects instead of creating new objects every render.
- Disables unnecessary vector updates during map animation and interaction.
- Includes the newly uploaded copy of the 003 KMZ under its original website filename.


## Version 017 point visibility fix

`003-supertable_rev0050masterk100.kmz` contains 1,416 `Point` geometries.

Its KML also defines an icon with this internal archive path:

```text
images/icon-1.png
```

When OpenLayers extracted the embedded KML style, that feature-level icon style
overrode the viewer's layer style. The browser could not directly request the
relative image from inside the KMZ archive, so the points were loaded but not
visible.

Version 017:

- Parses KML with `extractStyles: false`.
- Clears feature-level styles after parsing.
- Applies the viewer's own circle marker to every imported point.
- Preserves attributes, names, popups, category logic, and geometry.
- Logs geometry counts to the browser console for diagnosis.


## Version 018 label and slab defaults

| Layer | Grouping | Label field |
|---|---|---|
| 001 | Uniform | `Name` / `name` |
| 002 | Automatic | `Name` / `name` |
| 003 | Uniform optimized for large point layer | `Name` / `name` |
| 004 | Automatic | `Name` / `name` |
| 005 | Automatic | `Name` / `name` |
| 006 | Automatic | `Name` / `name` |
| 007 | `StatusA` categories | `Slab ID` |
| 008 | `StatusA` categories | `Slab ID` |

Field matching is case-insensitive. Slab label fallbacks include `SlabID`,
`Slab_ID`, and `Slab Id`.


## Version 019 toolbar repair

The previous HTML placed advanced controls after the script that attempted to
attach their event handlers. It also contained inline JavaScript inside
`<script src="...">` tags, which browsers ignore.

Version 019:

- Corrects the OpenLayers and JSZip CDN script tags.
- Places all advanced controls before application initialization.
- Activates point, line, polygon, and measurement drawing.
- Wires both the horizontal and vertical toolbars.
- Adds active-tool highlighting.
- Adds undo-last-drawing and clear-all-drawings actions.
- Keeps completed measurement labels visible.
- Makes Select return to feature-click mode.
- Makes Pan cancel drawing interactions.
- Makes the arrow control fit all loaded layers.
- Reports JavaScript errors in the status area and browser console.


## Version 020 markup suite

### Labels
- Per-layer **Show labels** checkbox.
- Visibility is stored independently for every KMZ layer.
- Geometry remains visible when labels are hidden.

### Drawing and annotation
- Point/pin
- Polyline
- Polygon
- Rectangle
- Circle
- Freehand pencil
- Arrow with arrowhead
- Text annotation
- Freehand revision cloud
- Distance measurement
- Area measurement

### Object editing
- Select and move
- Vertex editing
- Multi-object selection
- Duplicate
- Delete
- Stroke color
- Fill color
- Opacity
- Line width
- Solid, dashed, and dotted lines
- Text size

### History and storage
- Undo and redo
- Save markup in browser local storage
- Restore saved markup
- Export markup as GeoJSON
- Clear all markup

### Keyboard shortcuts
- `Esc`: cancel drawing, measurement, text placement, close dialogs/popups, and return to pan
- `Delete`: delete selected markup
- `Ctrl+D`: duplicate selected markup
- `Ctrl+Z`: undo
- `Ctrl+Y`: redo
- `S`: select/move
- `V`: modify vertices
- `P`: point
- `L`: line
- `G`: polygon
- `R`: rectangle
- `C`: circle
- `F`: freehand
- `A`: arrow
- `T`: text
- `M`: distance measurement

### Scope note
Desktop-grade topology operations such as automatic trim, extend, offset,
intersection solving, and railway-specific chainage calculations require a
larger geometry engine and are not silently simulated. The release provides
the reliable browser-native markup and editing tools listed above.


## Version 020.1 corrections

- Repaired JavaScript that had been placed outside its `<script>` block.
- Re-enabled toolbar keyboard shortcuts.
- `Esc` now reliably cancels the active drawing or measurement tool.
- Drawing tools now disable Select, Modify, and Translate interactions to prevent click conflicts.
- Completed measurement interactions are removed correctly.
- Layers `007` and `008` have labels OFF by default.
- A saved per-layer label preference still overrides the default.


## Version 020.2 additions

- The entire **Track alignment – Slab IDs2** layer window can be shown or hidden.
- Desktop: use the arrow in the panel header.
- Mobile: use the × button and floating **Layers** button.
- A floating **Layers** button remains available when the panel is hidden.
- The show/hide choice is saved in browser local storage.
- The map resizes after opening or closing the panel.
- Layers containing only lines or polygons start with labels OFF.
- Layers 007 and 008 start with labels OFF.
- Saved per-layer label preferences override defaults.


## Version 020.3 corrections

- Fixed labels continuing to appear after being switched off.
- Removed the renderer fallback to KML `Name` and `name`.
- The renderer now uses `_viewerLabel` exclusively.
- An empty `_viewerLabel` is treated as an intentional hidden-label state.
- Layers 007 and 008 start with labels OFF.
- LineString, MultiLineString, Polygon, and MultiPolygon-only layers start with labels OFF.
- High-density layers start with labels OFF.
- The layer checkbox can still turn labels back on.


## Version 020.4 corrections

- Restored the missing `populateStyleModal`, `refreshStyleFields`, and
  `applyStyleSettings` functions.
- Fixed the visible `populateStyleModal is not defined` runtime error.
- Layer styling now supports uniform, categories, numeric ranges, labels,
  opacity, symbol size, label size, and basic `Field=value` filters.
- Added a central **Show / Hide Windows** menu.
- Independently toggle:
  - Layers window
  - Search window
  - Top navigation tools
  - Drawing toolbar
  - Drawing style controls
  - Right-side map controls
  - Construction legend
  - Satellite/Map switch
  - Coordinates
  - Status messages
- Window visibility settings persist in browser local storage.


## Version 020.5 Google Drive loading

The eight KMZ files are no longer loaded from a repository-local `kmz/` folder.

They are loaded from the Google Drive API using their Drive file IDs.

### Required setup

1. Create or use a Google Cloud project.
2. Enable **Google Drive API**.
3. Create an API key.
4. Restrict the API key to the website domain where practical.
5. Open the viewer and click **Drive Key**.
6. Paste the API key.
7. Click **Reload Drive**.

The API key is stored only in browser `localStorage`. It is not written to the
GitHub repository.

### Why an API key is required

Normal Google Drive `/view` and `/uc?export=download` links are not reliable for
cross-origin browser `fetch()` calls. The Google Drive API `alt=media` endpoint
supports the static GitHub Pages application and returns the KMZ bytes directly.

### Drive KMZ source files

- 001-assetsv20250822a.kmz
- 002-Segment 1.kmz
- 003-supertable_rev0050masterk100.kmz
- 004-pre-bentRail Locations.kmz
- 005-AssetsSignalling.kmz
- 006-IntersectionPlan_v20260502a.kmz
- 007-Slabss_v20250922C09b-WB.kmz
- 008-Slabss_v20250922C09b-EB.kmz


## Version 020.6 public Google Drive loading

- Removed the Google Cloud API-key prompt.
- The viewer automatically loads the eight public KMZ files from Google Drive.
- Uses the known Drive file IDs from the shared `20260718A` folder.
- Tries two public Drive download URL formats.
- Verifies that each downloaded response begins with a ZIP/KMZ signature.
- Rejects Google sign-in and confirmation HTML pages.
- Adds **Open Drive** and **Reload Drive** buttons.

### Important limitation

Google Drive is not designed as a public static-file CDN. Even public files can
sometimes be blocked by cross-origin restrictions, virus-scan confirmation,
download throttling, or sign-in pages. When this happens, the viewer reports the
affected filenames instead of trying to parse HTML as KMZ.


## Revision 21 — latest dated Drive folder

The viewer now uses the parent folder:

```text
https://drive.google.com/drive/folders/1t2gMvS_uJzQSaT2RWtcVxaWPEinmyxIm
```

It automatically selects the newest direct subfolder whose name matches:

```text
YYYYMMDD
YYYYMMDDA
YYYYMMDDB
```

Examples:

```text
20260718
20260718A
20260718B
20260719
```

The selected revision is `20260719`.

### Google Apps Script bridge

GitHub Pages cannot directly enumerate Google Drive folders or reliably download
Drive files because of browser CORS restrictions. Revision 21 includes:

```text
google-apps-script/
├── Code.gs
├── appsscript.json
└── SETUP.md
```

Deploy the included Apps Script as a public Web App, then paste its `/exec` URL
using **Drive Endpoint**.

The bridge:

- Enumerates the parent folder.
- Selects the newest dated revision folder.
- Returns the KMZ manifest.
- Returns KMZ bytes as base64 JSON.
- Requires no API key in the website.
- Keeps Drive authorization inside the Apps Script owner account.


## Revision 21.1 default folder

The fixed startup revision is:

```text
20260718A
https://drive.google.com/drive/folders/1oSQ2Ji08nMgY2p7fNiVO4upyY5j-I_bg
```

Startup no longer selects the newest dated folder automatically.

- **Reload 20260718A** loads the fixed default revision.
- **Load Latest** manually scans the parent folder and loads the newest `YYYYMMDD*` revision.
- If newer dated folders are added, they do not replace the default unless **Load Latest** is selected.


## Revision 21.2 endpoint

The Google Apps Script bridge is built into the viewer:

```text
https://script.google.com/macros/s/AKfycbzwAMTdGpoa6lehJkw26H2csg0xJj26iJjr9eYqwOZe53JqphDXpmIIK2go8h32uBWw/exec
```

Behavior:

- No endpoint prompt on first load.
- Startup loads `20260718A`.
- **Reload 20260718A** reloads the fixed default folder.
- **Load Latest** selects the newest `YYYYMMDD*` folder.
- **Change Endpoint** remains available for future redeployments.


## Revision 21.3 endpoint update

The built-in Apps Script endpoint is now:

```text
https://script.google.com/macros/s/AKfycbzwAMTdGpoa6lehJkw26H2csg0xJj26iJjr9eYqwOZe53JqphDXpmIIK2go8h32uBWw/exec
```

Startup continues to load `20260718A` automatically.
