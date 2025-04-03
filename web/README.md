# Cooperative Areas Webmap

This directory contains the web-based map visualization of cooperative areas in Malanje using Mapbox GL JS.

## Setup Instructions

1. **Mapbox Access Token**
   - Sign up for a Mapbox account at https://www.mapbox.com/
   - Create a new access token with the following scopes:
     - `styles:read`
     - `styles:tiles`
     - `fonts:read`
   - Replace `YOUR_MAPBOX_ACCESS_TOKEN` in `index.html` with your access token

2. **Data Preparation**
   - Export your cooperative areas from QGIS as GeoJSON
   - Save the file as `data/cooperative_areas.geojson`
   - Ensure the GeoJSON file contains the following properties:
     - `cooperative_name`
     - `actual_area_ha`
     - `member_count`
     - `village_name`
     - `municipality`
     - `status`

3. **Running the Webmap**
   - Use the provided Python server: `python server.py`
   - The server will start on port 8000
   - Open your browser and navigate to `http://localhost:8000/web/index.html`
   - The server handles CORS and serves GeoJSON files with proper MIME types

## Features

- Interactive map centered on Malanje
- Cooperative areas displayed as polygons with municipality-based coloring
- Click on any cooperative to view details in a popup
- Navigation controls for zoom and pan
- Comprehensive filtering and search:
  - Municipality filter dropdown
  - Search box for finding specific cooperatives
  - Auto-zoom to single search results
- Statistics panel showing:
  - Total number of cooperatives
  - Total area in hectares
  - Total number of members
  - Breakdown by municipality
- Layer controls:
  - Opacity adjustment
  - Base map style selector
- Responsive design that works on mobile and desktop

## Customization

You can customize the map by:

1. Changing the map style:
   - Replace `mapbox://styles/mapbox/light-v11` with another Mapbox style URL

2. Modifying the cooperative areas appearance:
   - Adjust the `fill-color`, `fill-opacity`, and `line-color` in the layer paint properties
   - Colors are currently based on municipality

3. Adding more information to the popup:
   - Modify the template string in the click event handler

## Dependencies

- Mapbox GL JS v2.15.0
- Python 3.x for the server
- No other external dependencies required 