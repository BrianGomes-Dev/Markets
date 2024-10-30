# Markets

This is an iOS application developed to display market data with details for each entry. 
The app uses MVVM (Model-View-ViewModel) architecture to separate concerns and enhance testability. 
It supports searching for markets with debouncing functionality to optimize network requests.

## Features

1. **Markets List**: Displays a list of markets fetched from the API.
2. **Search Functionality**: Allows users to search for markets with debouncing to prevent excessive network calls.
3. **Market Detail Screen**: Displays detailed information about a selected market.
4. **Accessibility**: The app includes accessibility labels and hints for better usability.

## Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture. Here’s a breakdown of each component:

- **Model**: Represents the `Market` structure, decoding the JSON response from the API.
- **View**: The `MarketsTableViewController` and `MarketDetailViewController` act as the views, displaying the UI elements.
- **ViewModel**: The `MarketViewModel` handles business logic, manages data fetching, filtering, and communicates updates to the View.
- **Network Manager**: The `NetworkManager` is responsible for handling network requests and abstracting API calls from the ViewModel.

This architecture ensures that the business logic and network code are separated from the UI, making the application easier to test and maintain.

## Setup

1. **Prerequisites**: Ensure you have Xcode installed with iOS development tools.
2. **API Configuration**: The app uses a mock server for fetching data. The URL and configuration details can be adjusted in `NetworkManager`.
3. **Running**:
   - Open the project in Xcode.
   - Build and run the app on a simulator or a physical device.
