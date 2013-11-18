# TestFlight

Example implementation of analytics and logging via TestFlight.


## Usage

- Add the TestFlight SDK to your project.
- Add all source files from this folder.
- Call `GSTestFlightSetup(@"token");` with your app's TestFlight token.


## App Store

To prevent TestFlight checkpoints and remote logging to be sent in App Store builds, the relevant calls are wrapped in `#ifdef BETA` checks. Edit or remove them to fit your workflow.
