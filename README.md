# EventTicketingAPI

A demonstration REST API built with Vapor that provides mock event ticketing functionality. This API serves as a backend companion for the [EventTicketingSDK](https://github.com/YOUR_USERNAME/EventTicketingSDK) portfolio project.

## Overview

This API simulates the ticket browsing, searching, and purchasing workflow that users would experience with a real ticketing platform. It provides dummy data suitable for demonstration and testing purposes.

**Note:** This is a portfolio project intended to showcase software development skills. It does not process real transactions or store persistent data.

## Features

- **Event Search** - Browse and search available events
- **Ticket Reservation** - Reserve tickets for events
- **Ticket Purchase** - Complete the mock purchase process

## Getting Started

### Prerequisites

- Xcode with Swift command line tools enabled
- Swift 5.9 or later

### Running with Swift Package Manager

Build the project:
```bash
swift build
```

Start the server:
```bash
swift run
```

Run tests:
```bash
swift test
```

### Running with Docker

Build the Docker image:
```bash
docker build -t event-ticketing-api .
```

Run the container:
```bash
docker run -p 8080:8080 event-ticketing-api
```

The API will be available at `http://localhost:8080`

## Related Projects

- [EventTicketingSDK](https://github.com/YOUR_USERNAME/EventTicketingSDK) - iOS SDK that consumes this API

## Built With

- [Vapor](https://vapor.codes) - Swift web framework
