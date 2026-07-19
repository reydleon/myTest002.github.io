# Local KMZ Map Viewer 013 — GitHub Pages

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
"# myTest002.github.io" 
