# EventMaster

Interview task for [@miquido](https://github.com/miquido)

This iOS application displays a list of upcoming events in Poland using the Ticketmaster API. Users can view event details, including the date, location, ticket price range, and a gallery of images. The app is developed using SwiftUI, handles networking with Structured Concurrency, and follows a clean, modular architecture (MVVM).

## Table of Contents

- [Screenshots](#screenshots)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Architecture](#architecture)

---

## Screenshots

Here are some screenshots of the app to give a quick visual overview:

![eventmastersc 2](https://github.com/user-attachments/assets/6a8132bb-f4cc-46fe-ba89-d38b67ab0fc0)

## Features

1. **Event List**: Displays a scrollable list of events happening in Poland.
   - Shows the event name, date, location, and venue name.
   - Displays a preview image for each event.
   - Includes pagination for seamless scrolling.

2. **Event Details**:
   - Shows detailed information about the selected event, such as:
     - Event name and performer
     - Date and time
     - Location (country, city, venue, and address)
     - Genre and ticket price range
     - Image gallery and seat map (if available)
   - Includes options to add the event to the calendar or open the venue location in Apple Maps.

3. **Offline Handling**:
   - Displays a user-friendly message if network data is unavailable.
   
4. **Additional Enhancements**:
   - Sorting options to organize events by date, name, etc.
   - UI & Unit tests for core functionality.

## Requirements

- iOS 16.0+
- Xcode 14.0+

## Installation

> **Note**: The app fetches data from Ticketmaster’s API, so you will need an API key to access it. Refer to [Ticketmaster Developer Portal](https://developer.ticketmaster.com) to create an account and get an API key.

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Michael-128/EventMasters.git
   cd EventMasters
   ```

2. **Open in Xcode**:
   ```bash
   open EventMasters.xcodeproj
   ```

4. **Configure Your API Key**:
   - **Using Environment Variables** (recommended & required for running tests): Add your API key in Xcode by navigating to **Edit Scheme** under the **Run** configuration. Add an entry in **Environment Variables** with the key name `API_KEY`.
   - **Direct Assignment** (for production builds): Alternatively, you can hardcode the API key in `APIService.swift` by updating the following line:
     ```swift
     public var apiKey: String? = "YOUR_API_KEY"
     ```
   - **Prompt on Launch**: If no API key is provided, the app will prompt you to enter one each time it is launched.

5. **Build and Run**:
   - Select your target device or simulator in Xcode.
   - Press `Cmd + R` to build and run the app.

## Architecture

This app follows a modular, clean architecture (MVVM) with a focus on separation of concerns:

- **Networking Layer**: Handles API requests using `URLSession` and `Structured Concurrency`.
- **ViewModel**: Manages data transformations and state for SwiftUI views.
- **SwiftUI Views**: Responsible for presenting data in a user-friendly layout.

The app does not rely on external libraries, in line with the task requirements. All data handling and asynchronous calls are managed with Structured Concurrency for clarity and simplicity.
