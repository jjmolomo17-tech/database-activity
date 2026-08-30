# database-activity

# Pulse - Live World Snapshot Board 

## Overview
Pulse is a live dashboard that captures real-time global events and displays them in a modern web interface.  
It integrates **USGS Earthquake API** and **Open Notify ISS API**, storing data in a **Supabase PostgreSQL database**, and presenting it through a styled **HTML/CSS frontend**.

The project demonstrates how to combine **API data ingestion, database upserts, automation, and frontend visualization** into a cohesive pipeline.

---

## Features
-  Fetches **earthquake data** (last 24 hours) from USGS.
-  Tracks the **International Space Station (ISS)** location in real time.
-  Stores data in Supabase tables (`earthquakes` and `iss_location`).
-  Displays data in a modern dashboard with **color-coded cards** and **icons**.
-  Includes a **dropdown filter** to show earthquakes above a chosen magnitude.
-  Automated with **Windows Task Scheduler** to refresh data every hour.

---

## Project Structure
